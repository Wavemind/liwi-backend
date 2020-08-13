namespace :users do
  desc "Create clinicians only available in test env (liwi-test.wavelab.top)"
  task seed_clinicians: :environment do
    User.create!(first_name: 'Fen', last_name: 'Beynon', email: 'fenella.beynon@swisstph.ch', password: 'Med@lC123', password_confirmation: 'Med@lC123') unless User.find_by_email('fenella.beynon@swisstph.ch')
    User.create!(first_name: 'Gillian', last_name: 'Levine', email: 'gillian.levine@swisstph.ch', password: 'Med@lC123', password_confirmation: 'Med@lC123') unless User.find_by_email('gillian.levine@swisstph.ch')
    User.create!(first_name: 'Hélène', last_name: 'Langet', email: 'helene.langet@swisstph.ch', password: 'Med@lC123', password_confirmation: 'Med@lC123') unless User.find_by_email('helene.langet@swisstph.ch')
    User.create!(first_name: 'MedAl-C', last_name: 'Generic user', email: 'dynamic.study.tz@gmail.com', password: 'Med@lC123', password_confirmation: 'Med@lC123') unless User.find_by_email('dynamic.study.tz@gmail.com')
  end

end
