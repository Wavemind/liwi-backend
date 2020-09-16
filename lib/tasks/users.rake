namespace :users do
  desc "Create clinicians only available in test env (liwi-test.wavelab.top)"
  task seed_clinicians: :environment do
    User.where(deactivated: true).update(password: '123456', password_confirmation: '123456', deactivated: false)
  end

end
