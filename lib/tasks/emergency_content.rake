namespace :emergency_content do
  desc "Load emergency content from file to trad"
  task load: :environment do
    ec = File.read(File.join(Rails.root.join "public", "ec_fr.txt"))
    Algorithm.find(6).update(emergency_content_fr: ec)
  end
end
