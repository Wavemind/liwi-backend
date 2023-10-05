namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task :copy_algo, [:algorithm_id] => :environment do |t, args|
    start = Time.zone.now
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        errors = []
        puts "#{Time.zone.now.strftime("%I:%M")} - Copying the Algorithm ..."
        origin_algorithm = Algorithm.find(args[:algorithm_id])
        copied_algorithm = Algorithm.new(origin_algorithm.attributes.except('id', 'name',
'created_at', 'updated_at'))
        copied_algorithm.name = "Copy of #{origin_algorithm.name}"
        Algorithm.skip_callback(:create, :after, :create_reference_table_questions)
        copied_algorithm.save(validate: false)

        # Init hashes
        nodes = {}
        qss = {}
        answers = {}
        diagnoses = {}
        versions = {}
        instances = {}

        Diagnosis.skip_callback(:create, :after, :generate_reference)
        Answer.skip_callback(:create, :after, :generate_reference)
        Node.skip_callback(:create, :after, :generate_reference)

        Questions::AssessmentTest.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::ChronicCondition.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Exposure.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::PhysicalExam.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Symptom.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Vaccine.skip_callback(:create, :after, :create_unavailable_answer)

        FinalDiagnosis.skip_callback(:create, :before, :link_algorithm)
        Question.skip_callback(:create, :before, :associate_step)
        Question.skip_callback(:create, :after, :create_positive)
        Question.skip_callback(:create, :after, :create_present)
        Question.skip_callback(:create, :after, :create_boolean)
        Question.skip_callback(:create, :after, :add_to_version_orders)
        QuestionsSequence.skip_callback(:create, :after, :create_boolean)
        Version.skip_callback(:create, :before, :init_config)
        Condition.skip_callback(:validation, :before, :prevent_loop)

        puts "#{Time.zone.now.strftime("%I:%M")} - Copying the Nodes ..."
        origin_algorithm.nodes.each do |node|
          unless node.is_a?(FinalDiagnosis)
            new_node = copied_algorithm.nodes.new(node.attributes.except('id', 'algorithm_id',
'created_at', 'updated_at'))
            new_node.source = node
            new_node.save(validate: false)

            node.medias.map do |media|
              new_media = Media.new(label_translations: media.label_translations,
                                    fileable: new_node)
              new_media.source = media
              new_media.duplicate_file(media)
            end

            if node.is_a?(Question)
              node.answers.each do |answer|
                new_answer = new_node.answers.new(answer.attributes.except('id', 'node_id',
'created_at', 'updated_at'))
                new_answer.source = answer
                new_answer.save(validate: false)
                answers[answer.id] = new_answer
              end
            elsif node.is_a?(QuestionsSequence)
              node.answers.each do |answer|
                new_answer = new_node.answers.new(answer.attributes.except('id', 'node_id',
'created_at', 'updated_at'))
                new_answer.source = answer
                new_answer.save(validate: false)
                answers[answer.id] = new_answer
              end
              qss[node.id] = new_node
            elsif node.is_a?(HealthCares::Drug)
              node.formulations.each do |formulation|
                new_formulation = new_node.formulations.new(formulation.attributes.except('id',
'node_id', 'created_at', 'updated_at'))
                new_formulation.source = formulation
                new_formulation.save(validate: false)
              end
            end

            nodes[node.id] = new_node
          end
        end

        # Recreate QS diagrams
        puts "#{Time.zone.now.strftime("%I:%M")} - Instancing Nodes in QS diagrams ..."
        qss.map do |key, value|
          old_qs = Node.find(key)
          new_qs = value
          old_qs.components.map do |instance|
            new_instance = new_qs.components.create!(
              node: nodes[instance.node_id],
              final_diagnosis: nodes[instance.final_diagnosis_id],
              position_x: instance.position_x,
              position_y: instance.position_y,
              duration_translations: instance.duration_translations,
              description_translations: instance.description_translations,
              source: instance,
              is_pre_referral: instance.is_pre_referral
            )
            instances[instance.id] = new_instance
          end
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Copying Versions and their Diagnoses, along with the Instances in the diagrams..."
        origin_algorithm.versions.active.each do |version|
          # next unless version.id == 83
          # TODO : Add left/right top questions
          # Update medal_r_config and medal_data_config instead of reseting it
          new_version = copied_algorithm.versions.new(version.attributes.except('id', 'name',
'algorithm_id', 'medal_r_config', 'medal_data_config', 'medal_r_json', 'medal_r_json_version', 'created_at', 'updated_at'))
          new_version.name = "Copy of #{version.name}"
          versions[version.id] = new_version
          new_version.source = version

          puts "#{Time.zone.now.strftime("%I:%M")} - Recreating the full ordering of the copied versions..."
          order = JSON.parse(new_version.full_order_json)
          order.each do |step|
            if ['Complaint Categories', 'Medical History', 'Physical Exams'].include?(step['title'])
              step['children'].each do |sub|
                sub['children'].each do |node|
                  node['id'] = nodes[node['id']].id
                end
              end
            else
              step['children'].each do |node|
                node['id'] = nodes[node['id']].id unless %w(
                  first_name last_name
                  birth_date
                ).include?(node['id'])
              end
            end
          end
          new_version.full_order_json = order.to_json

          new_version.save

          version.components.each do |instance|
            new_instance = new_version.components.create!(
              node: nodes[instance.node_id],
              final_diagnosis: nodes[instance.final_diagnosis_id],
              position_x: instance.position_x,
              position_y: instance.position_y,
              duration_translations: instance.duration_translations,
              description_translations: instance.description_translations,
              source: instance,
              is_pre_referral: instance.is_pre_referral
            )
            instances[instance.id] = new_instance
          end

          version.medal_data_config_variables.each do |variable|
            new_version.medal_data_config_variables.create!(api_key: variable.api_key,
                                                            label: variable.label, question: nodes[variable.question_id])
          end

          version.diagnoses.map do |diagnosis|
            new_diagnosis = new_version.diagnoses.create!(
              reference: diagnosis.reference,
              label_translations: diagnosis.label_translations,
              node: nodes[diagnosis.node_id],
              source: diagnosis,
              cut_off_start: diagnosis.cut_off_start,
              cut_off_end: diagnosis .cut_off_end
            )
            diagnoses[diagnosis.id] = new_diagnosis

            diagnosis.final_diagnoses.map do |fd|
              puts "Final diagnosis being copied : #{fd.id}"

              new_fd = copied_algorithm.nodes.new(fd.attributes.except('id', 'algorithm_id',
'diagnosis_id', 'created_at', 'updated_at'))
              new_fd.source = fd
              new_fd.diagnosis_id = new_diagnosis.id
              new_fd.save(validate: false)

              fd.medias.map do |media|
                new_media = Media.new(label_translations: media.label_translations,
                                      fileable: new_fd)
                new_media.source = media
                new_media.duplicate_file(media)
              end

              nodes[fd.id] = new_fd
            end

            diagnosis.components.map do |instance|
              new_instance = new_diagnosis.components.create!(
                node: nodes[instance.node_id],
                final_diagnosis: nodes[instance.final_diagnosis_id],
                position_x: instance.position_x,
                position_y: instance.position_y,
                duration_translations: instance.duration_translations,
                description_translations: instance.description_translations,
                source: instance,
                is_pre_referral: instance.is_pre_referral
              )
              instances[instance.id] = new_instance
            end
          end
          errors.concat(validate_order(order, JSON.parse(version.full_order_json), nodes.keys,
nodes.values.map(&:id)))
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating links between Instances on the copied diagrams..."
        instances.map do |key, value|
          old_instance = Instance.find(key)
          new_instance = value
          old_instance.children.map do |child|
            Child.create!(instance: new_instance, node: nodes[child.node_id])
          end

          old_instance.conditions.map do |condition|
            Condition.create!(
              first_conditionable_type: condition.first_conditionable_type,
              referenceable_type: condition.referenceable_type,
              instance: new_instance,
              answer: answers[condition.answer_id],
              score: condition.score,
              cut_off_start: condition.cut_off_start,
              cut_off_end: condition.cut_off_end,
              source: condition
            )
          end
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Exclusions on the copied Nodes..."
        NodeExclusion.where(excluding_node_id: nodes.keys).map do |exclusion|
          NodeExclusion.create!(node_type: exclusion.node_type,
                                excluding_node: nodes[exclusion.excluding_node_id], excluded_node: nodes[exclusion.excluded_node_id])
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Complaint Category restrictions on the copied nodes..."
        NodeComplaintCategory.where(node_id: nodes.keys).map do |association|
          NodeComplaintCategory.create!(node: nodes[association.node_id],
                                        complaint_category: nodes[association.complaint_category_id])
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Relinking the reference tables to the copied Nodes..."
        copied_algorithm.questions.where.not(reference_table_x_id: nil).map do |reference_table|
          x = nodes[reference_table.reference_table_x_id]
          y = nodes[reference_table.reference_table_y_id]
          z = reference_table.reference_table_z_id.present? ? nodes[reference_table.reference_table_z_id] : nil
          reference_table.update(reference_table_x: x, reference_table_y: y, reference_table_z: z)
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating configs ..."
        config = copied_algorithm.medal_r_config
        config['basic_questions'].map do |k, v|
          config['basic_questions'][k] = nodes[v].id
        end
        config['optional_basic_questions'].map do |k, v|
          config['optional_basic_questions'][k] = nodes[v].id
        end
        copied_algorithm.medal_r_config = config
        copied_algorithm.save(validate: false)

        before_test = Time.zone.now

        errors.concat(validate_algorithm_duplicate(copied_algorithm))
        ##########################################################
        # /!\ If only one version is copied adapt tests below  /!\
        ##########################################################
        errors.concat(validate_count(origin_algorithm, copied_algorithm))

        after_test = Time.zone.now
        if errors.any?
          puts "#######################################"
          puts errors
          puts "#######################################"
          raise ActiveRecord::Rollback, ''
        end
      rescue => e
        puts e
        puts e.backtrace
        raise ActiveRecord::Rollback, ''
      end
      puts("Duplication duration  : #{before_test - start}sec")
      puts("Test duration         : #{after_test - before_test}sec")
      puts("Total duration        : #{after_test - start}sec")
    end
  end

  # Run model counts with every models impacted with the duplication
  # /!\ This should not be called if we're scoping the versions to be duplicated /!\
  def validate_count(origin_algorithm, copied_algorithm)
    errors = []
    puts "Copied nodes : #{copied_algorithm.nodes.count}"
    errors.push("Number of nodes differ from a version to another") if copied_algorithm.nodes.count != origin_algorithm.nodes.count

    copied_instances = copied_algorithm.nodes.map(&:instances).flatten
    origin_instances = origin_algorithm.nodes.map(&:instances).flatten
    puts "Copied instances : #{copied_instances.count}"
    errors.push("Number of instance differ from a version to another") if copied_instances.count != origin_instances.count
    puts "Copied conditions : #{copied_instances.map(&:conditions).flatten.count}"
    errors.push("Number of conditions differ from a version to another") if copied_instances.map(&:conditions).flatten.count != origin_instances.map(&:conditions).flatten.count
    puts "Copied diagnoses : #{copied_algorithm.versions.map(&:diagnoses).flatten.count}"
    errors.push("Number of diagnosis differ from a version to another") if copied_algorithm.versions.map(&:diagnoses).flatten.count != origin_algorithm.versions.map(&:diagnoses).flatten.count
    puts "Copied medal data config variables : #{copied_algorithm.versions.map(&:medal_data_config_variables).flatten.count}"
    errors.push("Number of medal data variables differ from a version to another") if copied_algorithm.versions.map(&:medal_data_config_variables).flatten.count != origin_algorithm.versions.map(&:medal_data_config_variables).flatten.count

    copied_excluded_nodes = NodeExclusion.where(excluded_node: copied_algorithm.nodes)
    copied_excluding_nodes = NodeExclusion.where(excluding_node: copied_algorithm.nodes)
    origin_excluded_nodes = NodeExclusion.where(excluded_node: origin_algorithm.nodes)
    origin_excluding_nodes = NodeExclusion.where(excluding_node: origin_algorithm.nodes)

    puts "Copied nodes exclusion : #{copied_excluded_nodes.count}"
    errors.push("Number of nodes exclusion differ from a version to another") if copied_excluded_nodes.count != origin_excluded_nodes.count || copied_excluding_nodes.count != origin_excluding_nodes.count

    puts "Copied complaint category exclusion : #{NodeComplaintCategory.where(node: copied_algorithm.nodes).count}"
    # Checking the number of node conditioned by complaint category as conditioned node
    errors.push("Number of nodes complaint category differ from a version to another") if NodeComplaintCategory.where(node: copied_algorithm.nodes).count != NodeComplaintCategory.where(node: origin_algorithm.nodes).count
    # Checking the number of node conditioned by complaint category from the complatin_category context
    errors.push("Number of nodes complaint category differ from a version to another") if NodeComplaintCategory.where(complaint_category: copied_algorithm.nodes).count != NodeComplaintCategory.where(complaint_category: origin_algorithm.nodes).count

    puts "Copied children : #{Child.where(node: copied_algorithm.nodes).count}"

    origin_count = Child.where(node: origin_algorithm.nodes).count
    copied_count = Child.where(node: copied_algorithm.nodes).count
    diff = Child.where(node: copied_algorithm.nodes).map{|c| c.node.source.id} - Child.where(node: origin_algorithm.nodes).map{|c| c.node.id}
    errors.push("Number of children differ from a version to another, origin_count: #{origin_count} | copied_count: #{copied_count} | diff: #{diff}") if Child.where(node: copied_algorithm.nodes).count != Child.where(node: origin_algorithm.nodes).count
    errors
  end

  # Compare order json from duplicated versions to ensure they only have node id as difference (and not positions or labels)
  # Ensure aswell that the difference in the node id is in the correct scope of before and after version
  def validate_order(new_order, old_order, old_nodes, new_nodes)
    require "json-diff"
    errors = []
    errors.concat(JsonDiff.diff(new_order, old_order).select do |error|
                    !(error['op'] == 'replace' && old_nodes.include?(error['value']))
                  end)
    errors.concat(JsonDiff.diff(old_order, new_order).select do |error|
                    !(error['op'] == 'replace' && new_nodes.include?(error['value']))
                  end)
    errors
  end

  # Execute multiple comparison between the 2 algorithms and log errors if there is any difference
  def validate_algorithm_duplicate(new_algorithm)
    errors = []
    new_algorithm.nodes.includes([
      :source,
      instances: [:source, conditions: :source],
    ]).each do |node|
      # For each node we are going to compare the values exept the the algorithm id the diagnosis_id (if DF) and reference tables
      # If it's a final diagnosis we check that they are both related to the same final diagnosis
      if clean_attributes(node).except('algorithm_id', 'diagnosis_id', 'reference_table_x_id',
'reference_table_y_id', 'reference_table_z_id') !=
        clean_attributes(node.source).except('algorithm_id', 'diagnosis_id', 'reference_table_x_id',
'reference_table_y_id', 'reference_table_z_id') ||
         (node.is_a?(FinalDiagnosis) && node.diagnosis.source_id != node.source.diagnosis_id)
        errors.push("Missing match between nodes #{node.id} and #{node.source_id}")
      end

      # If the current node is a question we are going to check if it's related to a reference table,
      # if yes we check that the related node are the same (but from original algorithm)
      if node.is_a?(Question)

        if (node.reference_table_x_id.nil? && node.source.reference_table_x_id.present?) ||
              (node.reference_table_x_id.present? && node.reference_table_x.source_id != node.source.reference_table_x_id) || # table X
           (node.reference_table_y_id.nil? && node.source.reference_table_y_id.present?) ||
              (node.reference_table_y_id.present? && node.reference_table_y.source_id != node.source.reference_table_y_id) || # table Y
           (node.reference_table_z_id.nil? && node.source.reference_table_z_id.present?) ||
              (node.reference_table_z_id.present? && node.reference_table_z.source_id != node.source.reference_table_z_id)    # table Z
          errors.push("Missing match between reference tables #{node.id} and #{node.source_id}")
        end
      end

      # If the current node is a Question or a QuestionSequence, we are checking that the freshly created answer have the same attributes as
      # the answers from the original algorithm.
      # We also check that the new answer is related to the same question (but from original algorithm)
      if node.is_a?(Question) || node.is_a?(QuestionsSequence)
        node.answers.each do |answer|
          if clean_attributes(answer).except('node_id') != clean_attributes(answer.source).except('node_id') || answer.source.node_id != answer.node.source_id
            errors.push("Missing match between answers #{answer.id} and #{answer.source_id}")
          end
        end
      end

      # We check that the newly created media have the same label as the one from the original
      # We also check that the new media is related to the same fileable (but from original algorithm)
      node.medias.each do |media|
        if media.label_translations != media.label_translations || media.source.fileable_id != media.fileable.source_id
          errors.push("Missing match between medias #{media.id} and #{media.source_id}")
        end
      end

      # If the node is a Drug, we compare all the values for the formulations between the new and the original formulations except for the node_id
      # We also check that the drug related the formulation are the same drug (but from original algorithm)
      if node.is_a?(HealthCares::Drug)
        node.formulations.each do |formulation|
          if clean_attributes(formulation).except('node_id') != clean_attributes(formulation.source).except('node_id') || formulation.node.source_id != formulation.source.node_id
            errors.push("Missing match between Version formulations #{formulation.id} and #{formulation.source_id}")
          end
        end
      end

      # For each node we are going to go through each instance and we are going to compare the values of the original object and the newly created one.
      node.instances.each do |instance|
        if clean_attributes(instance).except('node_id', 'instanceable_id',
'final_diagnosis_id') != clean_attributes(instance.source).except('node_id', 'instanceable_id',
'final_diagnosis_id') ||
          instance.source.instanceable_id != instance.instanceable.source_id || # We check that the instance is related to the same instanceable (Version, Diagnosis, Node)
          (instance.final_diagnosis_id.nil? && instance.source.final_diagnosis_id.present?) || # If the original instance is related to a final diagnosis we make sure that the copy also is
          (instance.final_diagnosis_id.present? && instance.final_diagnosis.source_id != instance.source.final_diagnosis_id) || # If the origianl instance is related to a final diagnosis we make sure that it's the same (but from original algorithm)
          instance.source.node_id != instance.node.source_id # We make sure that the node related to the instance is the same (but from original algorithm)
          errors.push("Missing match between instances #{instance.id} and #{instance.source_id}")
        end

        # For each instance we check the newly created and compare them with the old algortithm
        instance.conditions.each do |condition|
          if clean_attributes(condition).except('answer_id', 'instance_id', 'referenceable_id',
'first_conditionable_id') != clean_attributes(condition.source).except('answer_id', 'instance_id',
'referenceable_id', 'first_conditionable_id') ||
            condition.instance.source_id != condition.source.instance_id || # We make sure that the sintace related to the condition is the same (but from original algorithm)
            condition.answer.source_id != condition.source.answer_id # We make sure that the answer set in the condition is the same (but from original algorithm)
            errors.push("Missing match between conditions #{condition.id} and #{condition.source_id}")
          end
        end
      end
    end

    # We retreive all the diagnoses from the different versions
    new_algorithm.versions.map(&:diagnoses).flatten.each do |diagnosis|
      if clean_attributes(diagnosis).except('version_id',
'node_id') != clean_attributes(diagnosis.source).except('version_id', 'node_id') ||
        diagnosis.node.source_id != diagnosis.source.node_id # we make sure that the diagosis is related to the same CC
        errors.push("Missing match between diagnosis #{diagnosis.id} and #{diagnosis.source_id}")
      end
    end
    errors
  end

  # Remove fields not to compare between new and origin models since we are not expecting them to be the same ever
  def clean_attributes(object)
    object.attributes.except('id', 'source_id', 'created_at', 'updated_at')
  end

  desc "24.11.2021: Some managements where added after the copy to india was made so we need to retreive those"
  task retreive_missing_managemnts: :environment do
    Node.skip_callback(:create, :after, :generate_reference)

    ActiveRecord::Base.transaction(requires_new: true) do
      old_algorithm = Algorithm.find(8)
      new_algorithm = Algorithm.find(29)
      managements = old_algorithm.nodes.where(type: "HealthCares::Management").where(
        "reference > ?", 241
      )
      managements.map do |management|
        new_node = new_algorithm.nodes.create!(management.attributes.except('id', 'algorithm_id',
'created_at', 'updated_at'))
      end
    rescue => e
      puts e
      puts e.backtrace
      raise ActiveRecord::Rollback, ''
    end
  end

  def values_from_conditions(conditions)
    values = []
    answers = Answer.find(conditions)
    answers.each do |answer|
      answer.value.split(',').each do |value|
        values.push(value.to_i)
      end
    end
    values.sort!
    values.push(values.first) if values.count == 1
    values.insert(0, nil) if answers.select { |a| a.less? }.any?
    values.push(nil) if answers.select { |a| a.more_or_equal? }.any?
    values
  end

  task update_cut_offs: :environment do
    ActiveRecord::Base.transaction(requires_new: true) do
      impossible_diagram_to_manage = []
      i = 0
      Algorithm.all.each do |algorithm|
        puts '#######################################'
        puts algorithm.name
        puts '#######################################'
        algorithm.questions.where('formula LIKE ?', '%To%').each do |cut_off_question|
          cut_off_question.instances.each do |cut_off_instance|
            i += 1
            next if cut_off_instance.instanceable.is_a?(Version)
            if cut_off_instance.final_diagnosis_id.present? || cut_off_instance.instanceable.is_a?(QuestionsSequences::Scored)

              impossible_diagram_to_manage.push(cut_off_instance.instanceable)
              next
            end

            if cut_off_instance.conditions.any? # Cut off to put in conditions (because not in the top)
              next
              cut_off_instance.children.each do |child|
                child_instance = cut_off_instance.instanceable.components.where(node: child.node,
                                                                                final_diagnosis_id: nil).first
                conditions = []
                child_instance.conditions.each do |cond|
                  if cond.answer.node == cut_off_question
                    conditions.push(cond)
                  end
                end
                values = values_from_conditions(conditions.map(&:answer_id))
                cut_off_instance.conditions.each do |parent_cond|
                  if parent_cond.answer.node.formula.present? && parent_cond.answer.node.formula.include?('To')
                    impossible_diagram_to_manage.push(cut_off_instance.instanceable)
                  else
                    child_instance.conditions.create(answer_id: parent_cond.answer_id,
                                                     cut_off_start: values.first, cut_off_end: values.last, cut_off_value_type: 'months')
                  end
                end
              end
            else
              if cut_off_instance.instanceable.components.select do |component|
                   component.conditions.empty? && component.final_diagnosis_id.nil?
                 end .count > 1
                impossible_diagram_to_manage.push(cut_off_instance.instanceable)
              else
                first_child_conditions = cut_off_instance.instanceable.components.where(
                  node: cut_off_instance.children.first.node, final_diagnosis_id: nil
                ).first.conditions.map(&:answer_id).sort

                impossible_to_manage = false
                cut_off_instance.children.each do |child|
                  impossible_to_manage = true if child.node.formula.present? && child.node.formula.include?('To')
                  impossible_to_manage = true unless first_child_conditions == cut_off_instance.instanceable.components.where(
                    node: child.node, final_diagnosis_id: nil
                  ).first.conditions.map(&:answer_id).sort
                end
                if impossible_to_manage
                  impossible_diagram_to_manage.push(cut_off_instance.instanceable)
                else
                  values = values_from_conditions(first_child_conditions)
                  cut_off_instance.instanceable.update!(cut_off_start: values.first,
                                                        cut_off_end: values.last, cut_off_value_type: 'months')
                  # cut_off_instance.destroy
                end
              end
            end
          end
        end
      end
      puts '##################################'
      puts 'Diagrams that were impossible to automatically process and need to be handled : '
      impossible_diagram_to_manage.uniq.each do |diagram|
        puts "#{diagram.id} #{diagram.reference_label}"
      end
      puts '##################################'
    rescue => e
      puts e
      puts e.backtrace
      raise ActiveRecord::Rollback, ''
    end
  end
end
