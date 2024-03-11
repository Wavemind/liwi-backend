namespace :migrate do
  desc "Migrate data for new project"
  task data: :environment do
    data = {}

    ############################################################################################
    ###########################################Users############################################
    ############################################################################################
    data['users'] = []
    # List from Unisanté
    users_to_keep = %w[gilbert.rukundo@swisstph.ch joseph.habakurama@swisstph.ch nina.emery@unil.ch margaretjorram@gmail.com valerie.dacremont@unisante.ch fenellajb@gmail.com vincent.faivre@unisante.ch alan.vonlanthen@gmail.com llameck@ihi.or.tz alexandra.kulinkina@swisstph.ch fenella.beynon@swisstph.ch lisa.m.cleveley@gmail.com ludovico.cobuccio@chuv.ch gillian.levine@swisstph.ch martin.norris@posteo.eu quentin.girard@wavemind.ch sylvain.schaufelberger@unisante.ch gkavishe@nimr-mmrc.org alix.miauton@unisante.ch emmanuel.barchichat@wavemind.ch alain.fresco@wavemind.ch rainer.tan@swisstph.ch gregory.martin@unisante.ch rwandarwacu1@gmail.com vincent.chollet@unisante.ch alan.vonlanthen@unisante.ch aymeric.poitiers@unil.ch]
    User.all.each do |user|
      next unless users_to_keep.include?(user.email)
      hash_user = user.as_json(only: [:id, :first_name, :last_name, :email, :role])

      data['users'].push(hash_user)
    end

    a_to_keep = [5, 7, 8, 1, 6, 46, 49, 56, 45, 57, 47]
    v_to_keep = [34, 41, 75, 44, 68, 58, 96, 108, 86, 94, 105, 83, 107, 88]

    data['algorithms'] = []
    Algorithm.all.each do |algorithm|
      next unless a_to_keep.include?(algorithm.id)
      puts "Extracting Algorithm #{algorithm.name}"
      hash_algorithm = algorithm.as_json

      hash_algorithm['study'] = algorithm.study.as_json(include: :users)

      hash_algorithm['questions'] = []
      algorithm.questions.each do |question|
        hash_algorithm['questions'].push(question.as_json(include: [:node_complaint_categories, :answer_type, :answers, :medias], methods: :formatted_formula).merge(type: question.type))
      end

      hash_algorithm['questions_sequences'] = []
      algorithm.questions_sequences.each do |qs|
        hash_algorithm['questions_sequences'].push(qs.as_json(include: [:node_complaint_categories, :answers, :medias, components: {include: :conditions}]).merge(type: qs.type))
      end
      # (include: {medical_staffs: {methods: [:algo_language, :app_language]}})

      hash_algorithm['drugs'] = []
      algorithm.health_cares.drugs.each do |drug|
        hash_algorithm['drugs'].push(drug.as_json(include: [:node_exclusions, :medias, formulations: {include: :administration_route}]).merge(type: drug.type))
      end

      hash_algorithm['managements'] = []
      algorithm.health_cares.managements.each do |management|
        hash_algorithm['managements'].push(management.as_json(include: [:node_exclusions, :medias]).merge(type: management.type))
      end

      hash_algorithm['versions'] = []
      algorithm.versions.each do |version|
        next unless v_to_keep.include?(version.id)
        hash_algorithm['versions'].push(version.as_json(include: [:languages, :medal_data_config_variables, components: {include: :conditions}, diagnoses: {include: [final_diagnoses: {include: [:node_exclusions, :medias]}, components: {include: :conditions}]}]))
      end
      data['algorithms'].push(hash_algorithm)
    end
    out_file = File.new("old_data.json", "w")
    out_file.puts(data.to_json)
  end

  task medias: :environment do
    medias = []
    Media.all.each do |media|
      medias.push({
                    record_id: media.fileable_id,
                    record_type: media.fileable_type,
                    url: media.url.url,
      })
    end
    out_file = File.new("old_medias.json", "w")
    out_file.puts(medias.to_json)
  end
end
