namespace :translations do
  desc "Migrate values in string format to new fields in hstore format"
  task migrate_data: :environment do
    puts 'Start Algos'
    Algorithm.all.each do |algorithm|
      algorithm.update!(age_limit_message_en: algorithm.old_age_limit_message)
    end
    puts 'Finish Algos'
    puts 'Start AR'

    AdministrationRoute.all.each do |ar|
      ar.update!(name_en: ar.old_name)
    end
    puts 'Finish AR'
    puts 'Start Version'

    Version.all.each do |version|
      version.update!(description_en: version.old_description)
    end
    puts 'Finish Version'
    puts 'Start Instance'

    Instance.all.each do |instance|
      instance.update!(duration_en: instance.old_duration, description_en: instance.old_description)
    end
    puts 'Finish Instance'
    puts 'Start Node'
    puts Node.all.count

    Node.all.each do |question|
      question.update!(min_message_error_en: question.old_min_message_error, max_message_error_en: question.old_max_message_error, min_message_warning_en: question.old_min_message_warning, max_message_warning_en: question.old_max_message_warning)
    end
    puts 'Finish Node'
  end
end
