# Languages (english is basic)
Language.create!(name: 'French', code: 'fr')
Language.create!(name: 'Swahili', code: 'sw')

# Group
group_wavemind = Group.create!(name: 'Wavemind')
group_unicorne = Group.create!(name: 'Unicorne')
group_pmu = Group.create!(name: 'PMU')

# Role
role_administrator = Role.create!(name: 'Administrator')
role_student = Role.create!(name: 'Student')
role_teacher = Role.create!(name: 'Teacher')

# Device
device_blackberry = Device.create!(mac_address: 'C5:CA:9C:17:7A:36', model: 'Q10', brand: 'BlackBerry',os: 'Android', os_version: '8.0', name: 'MedicalCenter 1', group: group_wavemind )
device_sony_ericsson = Device.create!(mac_address: 'A6:91:D4:0E:ED:EF', model: '3310', brand: 'Sony Ericsson', os: 'Android', os_version: '8.0', name: 'MedicalCenter 2', group: group_wavemind)
device_apple = Device.create!(mac_address: '35:BC:4A:28:82:4C', model: 'Iphone XYZ', brand: 'Apple', os: 'Android', os_version: '8.0', name: 'MedicalCenter 3', group: group_pmu)
device_sagem = Device.create!(mac_address: 'BB:3B:AA:69:8F:74', model: 'J302', brand: 'Sagem', os: 'Android', os_version: '8.0', name: 'MedicalCenter 4', group: group_unicorne)
device_lenovo = Device.create!(mac_address: '64:DB:43:D5:31:5C', group: group_wavemind)

# User
quentin = User.create!(first_name: 'Quentin', last_name: 'Girard', email: 'quentin.girard@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
alain = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
mickael = User.create!(first_name: 'Mickael', last_name: 'Lacombe', email: 'mickael.lacombe@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
julien = User.create!(first_name: 'Julien', last_name: 'Thabard', email: 'julien.thabard@hospvd.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
vincent = User.create!(first_name: 'Vincent', last_name: 'Faivre', email: 'vincent.faivre@hospvd.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
valerie = User.create!(first_name: 'Valérie', last_name: 'D\'Acremont', email: 'valerie.dacremont@hospvd.ch', password: '123456', password_confirmation: '123456', role: role_teacher)
ludovico = User.create!(first_name: 'Ludovico', last_name: 'Cabuccio', email: 'ludovico.cobuccio@chuv.ch', password: '123456', password_confirmation: '123456', role: role_teacher)
olga = User.create!(first_name: 'Olga', last_name: 'De Santis', email: 'olga.desantis80@gmail.com', password: '123456', password_confirmation: '123456', role: role_teacher)

# Activity
Activity.create!(user: alain, device: device_sony_ericsson, latitude: -33.918861, longitude: 18.423300, created_at: '2018-12-01 07:22:00', updated_at: '2018-12-01 07:22:00', timezone: 'Berne', version: '1.0.0')
Activity.create!(user: alain, device: device_sony_ericsson, latitude: -29.087217, longitude: 26.154898, created_at: '2018-11-17 15:44:00', updated_at: '2018-11-17 15:44:00', timezone: 'Berne', version: '1.0.0')
Activity.create!(user: alain, device: device_sony_ericsson, latitude: -33.958252, longitude: 25.619022, created_at: '2018-11-15 13:43:00', updated_at: '2018-11-15 13:43:00', timezone: 'Berne', version: '1.0.0')
Activity.create!(user: alain, device: device_sony_ericsson, latitude: -25.872782, longitude: 29.255323, created_at: '2018-11-15 09:00:00', updated_at: '2018-11-15 09:00:00', timezone: 'Berne', version: '1.0.0')
Activity.create!(user: ludovico, device: device_apple, latitude: -33.918861, longitude: 18.423300, created_at: Time.zone.now.yesterday, updated_at: Time.zone.now.yesterday, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: julien, device: device_apple, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now.tomorrow, updated_at: Time.zone.now.tomorrow, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: julien, device: device_apple, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now.last_month, updated_at: Time.zone.now.last_month, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: valerie, device: device_apple, latitude: -33.918861, longitude: 18.423300, created_at: Time.zone.now, updated_at: Time.zone.now, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: valerie, device: device_blackberry, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 1.hour, updated_at: Time.zone.now + 1.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: olga, device: device_blackberry, latitude: -33.918861, longitude: 18.423300, created_at: Time.zone.now + 2.hour, updated_at: Time.zone.now + 2.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: vincent, device: device_blackberry, latitude: -26.958405, longitude: 18.423300, created_at: Time.zone.now + 3.hour, updated_at: Time.zone.now + 3.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: valerie, device: device_blackberry, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 4.hour, updated_at: Time.zone.now + 4.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: olga, device: device_blackberry, latitude: -26.958405, longitude: 18.423300, created_at: Time.zone.now + 5.hour, updated_at: Time.zone.now + 5.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: olga, device: device_sagem, latitude: -33.918861, longitude: 18.423300, created_at: Time.zone.now + 6.hour, updated_at: Time.zone.now + 6.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: valerie, device: device_sagem, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 6.hour, updated_at: Time.zone.now + 6.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: vincent, device: device_sagem, latitude: -26.958405, longitude: 27.901464, created_at: Time.zone.now + 7.hour, updated_at: Time.zone.now + 7.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: quentin, device: device_sagem, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 8.hour, updated_at: Time.zone.now + 8.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: mickael, device: device_lenovo, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 8.hour, updated_at: Time.zone.now + 8.hour, timezone: 'Berne', version: '1.0.0')

# Algorithms
epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: emmanuel)
fever_travel = Algorithm.create!(name: 'FeverTravel', description: 'loremp ipsum', user: quentin)
ods = Algorithm.create!(name: "ePOCT_ODS_1", description: "first modellisation of ePOCT from the draw.io doc", archived: false, user: olga)

epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)
ft_1_0 = Version.create!(name: '1.0', algorithm: fever_travel, user: mickael)
ft_1_2 = Version.create!(name: '1.2', algorithm: fever_travel, user: vincent)
ods_1 = Version.create!(name: "ePOCT_ODS_1", archived: false, user_id: 9, algorithm_id: 1)
ods_3 = Version.create!(name: "ePOCT_ODS_1_version 1", archived: false, user_id: 9, algorithm_id: 3)

# Answer types
boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')

john = Patient.create!(first_name: 'John', last_name: 'Do', birth_date: Date.new(1970,1,1))
marc = Patient.create!(first_name: 'Marc', last_name: 'Do', birth_date: Date.new(1970,1,1))
kantaing = Patient.create!(first_name: 'Quentin', last_name: 'Girard', birth_date: Date.new(1970,3,2))
idefix = Patient.create!(first_name: 'Idefix', last_name: 'Wouf', birth_date: Date.new(1970,1,1))
mick = Patient.create!(first_name: 'Mickael', last_name: 'Lacombe', birth_date: Date.new(1970,3,20))

# Medical cases
MedicalCase.create!(patient: john, version: epoc_first)
MedicalCase.create!(patient: marc, version: epoc_first)
MedicalCase.create!(patient: mick, version: ft_1_0)
MedicalCase.create!(patient: kantaing, version: ft_1_0)
MedicalCase.create!(patient: idefix, version: ft_1_2)
MedicalCase.create!(patient: john, version: ft_1_2)

# Assign version to group
group_wavemind.versions << epoc_first
group_wavemind.save

# Generate from Olga's data
Node.create!([
  {label_translations: {"en"=>"mRDT"}, reference: "1", priority: "mandatory", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>"malaria rapid diagnostic test"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2, unavailable: 1},
  {label_translations: {"en"=>"malaria microscopy"}, reference: "10", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2, unavailable: 1},
  {label_translations: {"en"=>"assessment of hydration status after one hour"}, reference: "11", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"CRP"}, reference: "3bis", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3, unavailable: 1},
  {label_translations: {"en"=>"trail of bronchodilator"}, reference: "5", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2, unavailable: 1},
  {label_translations: {"en"=>"skin lesion description and picture"}, reference: "7", priority: "basic", stage: "triage", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"tolerates PO liquid"}, reference: "8", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"urinary dipstick"}, reference: "9", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2, unavailable: 1},
  {label_translations: {"en"=>"Hb"}, reference: "2", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"CRP"}, reference: "3", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"Blood sugar"}, reference: "4", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 4},
  {label_translations: {"en"=>"PCT"}, reference: "6", priority: "basic", stage: "test", type: "Questions::AssessmentTest", diagnostic_id: nil, description_translations: {"en"=>"procalcitonin"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"Respiratory complaint"}, reference: "1", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"cough, trouble breathing"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Prevention"}, reference: "10", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Ear/Nose/Mouth/Throat complaint"}, reference: "2", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"ear, nose, mouth or thrat pain or secretions"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Digestive/gastro-intestinal complaint"}, reference: "3", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"eg. abdominal pain, diarrhea"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Genital/Urinary complaint"}, reference: "4", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"eg. abnormal urination or secretions from genitals, pain"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Eye complaint"}, reference: "5", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"eg. red eye, pain"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Neurological complaint"}, reference: "6", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"eg. headache, convulsion"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Bone or joint pain, accident, burn"}, reference: "7", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Skin and hair complaint"}, reference: "8", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"eg. rash, papules, abscess"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Fever"}, reference: "9", priority: "mandatory", stage: "triage", type: "Questions::ChiefComplaint", diagnostic_id: nil, description_translations: {"en"=>"fever only"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Age"}, reference: "1", priority: "mandatory", stage: "registration", type: "Questions::Demographic", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"village"}, reference: "2", priority: "basic", stage: "registration", type: "Questions::Demographic", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"vit A in the past month"}, reference: "1", priority: "basic", stage: "consultation", type: "Questions::Exposure", diagnostic_id: nil, description_translations: {"en"=>"the child has reveived one dose of vit A in the past month"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Any known disease in past medical history"}, reference: "2", priority: "mandatory", stage: "triage", type: "Questions::Exposure", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"weight for age"}, reference: "1", priority: "mandatory", stage: "registration", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>"weight for age according to WHO reference tables"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"Blotchy rash"}, reference: "10", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"red, watery eyes"}, reference: "11", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"koplik spots"}, reference: "12", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"lower chest indrawing\t"}, reference: "13", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"severe respiratory distress"}, reference: "14", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"clouding of cornea"}, reference: "15", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"severe mouth ulcers"}, reference: "17", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"tender neck mass > 2cm"}, reference: "18", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"dental abscess"}, reference: "19", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"MUAC"}, reference: "2", priority: "mandatory", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>"Mid upper arm circonference to be mesures only in children >/= 6 months of age"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 4},
  {label_translations: {"en"=>"skin exam: lesion description"}, reference: "20", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"detailled aspect of vesicles and/or crusts"}, reference: "20.2", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"skin exam: lesion location"}, reference: "22", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"skin exam: lesion associated signs"}, reference: "23", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"Joint swelling"}, reference: "24", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"tender cervical node"}, reference: "25", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"refer for malaria testing"}, reference: "6", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"First Look: appearence"}, reference: "26", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"First Look: work of breathing"}, reference: "27", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"First Look: circulation"}, reference: "28", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"axillary temperature > 37.5 °C"}, reference: "3", priority: "mandatory", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>"axillary temperature must be measured in all children. A > 37.5 °C is considered as fever"}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 4},
  {label_translations: {"en"=>"SaO2"}, reference: "4", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"heart rate (HR)"}, reference: "5", priority: "basic", stage: "triage", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"respiratory rate (RR)"}, reference: "6", priority: "basic", stage: "triage", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"Convulsing now"}, reference: "7", priority: "basic", stage: "triage", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Stiff neck"}, reference: "9", priority: "basic", stage: "triage", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Lethargic or unconscious"}, reference: "8", priority: "basic", stage: "triage", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"History of fever"}, reference: "1", priority: "mandatory", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Unable to tolerate PO liquids"}, reference: "10", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"headache"}, reference: "12", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"abdominal pain"}, reference: "13", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"sudden onset"}, reference: "14", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"coryza"}, reference: "15", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"cough"}, reference: "2", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"fever duration"}, reference: "11", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>">/= 2 convulsions in the present illness"}, reference: "3", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"drink as usual"}, reference: "4", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Emesis"}, reference: "5", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"looser stools than usual"}, reference: "6", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Blood in stool"}, reference: "7", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"extremity pain"}, reference: "8", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"Skin issue"}, reference: "9", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"MMR: 2 doses completed"}, reference: "1", priority: "basic", stage: "registration", type: "Questions::Vaccine", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 1},
  {label_translations: {"en"=>"nb of emesis episods"}, reference: "5.1", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"nb of loose stools over past 24 hours"}, reference: "6.1", priority: "basic", stage: "consultation", type: "Questions::Symptom", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 3},
  {label_translations: {"en"=>"oral rehydration / severe dehydration"}, reference: "10", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"paracetamol"}, reference: "11", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"amoxicillin regular dose"}, reference: "1.1", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"vit A"}, reference: "12", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"amoxicillin high dose"}, reference: "1.2", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"moderate asthma protocol"}, reference: "13", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"abscess care, general"}, reference: "14", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"bronchodiator"}, reference: "15", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"sublingual sugar"}, reference: "16", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"symptomatic care"}, reference: "17", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"zinc"}, reference: "18", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"local treatment, antiseptic"}, reference: "19", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"ceftriaxone IM"}, reference: "2", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"skin, symptomatic care"}, reference: "20", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"local antifungal"}, reference: "21", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"scabies treatment"}, reference: "22", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"ciprofloxacin"}, reference: "3", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"cephalexin"}, reference: "4", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"erythromycin eye ointment"}, reference: "5", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"Alu"}, reference: "6", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"artesunate IM"}, reference: "7", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"home rehydration"}, reference: "8", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"oral rehydration / moderate dehydration protocol"}, reference: "9", priority: nil, stage: nil, type: "HealthCares::Treatment", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"reasons to return to clinic"}, reference: "1", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"refer"}, reference: "2", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"assessment after one hour"}, reference: "3", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"refer to the nearest nutrition program"}, reference: "4", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"return the following day to clinic for assessment"}, reference: "5", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
  {label_translations: {"en"=>"follow-up in 2 days is still febrile"}, reference: "7", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil}
])
Answer.create!([
                 {reference: "1", label_translations: {"en"=>"positive"}, operator: nil, value: nil, node_id: 1},
                 {reference: "2", label_translations: {"en"=>"negative"}, operator: nil, value: nil, node_id: 1},
                 {reference: "1", label_translations: {"en"=>"positive"}, operator: nil, value: nil, node_id: 2},
                 {reference: "2", label_translations: {"en"=>"negative"}, operator: nil, value: nil, node_id: 2},
                 {reference: "1", label_translations: {"en"=>"improvement"}, operator: nil, value: nil, node_id: 3},
                 {reference: "2", label_translations: {"en"=>"no improvement"}, operator: nil, value: nil, node_id: 3},
                 {reference: "1", label_translations: {"en"=>"< 10 mg/l"}, operator: "less", value: "10", node_id: 4},
                 {reference: "2", label_translations: {"en"=>">= 10 < 40 mg/l"}, operator: "between", value: "10, 40", node_id: 4},
                 {reference: "3", label_translations: {"en"=>">= 40 < 80 mg/l"}, operator: "between", value: "40, 80", node_id: 4},
                 {reference: "4", label_translations: {"en"=>">= 80 mg/l"}, operator: "more_or_equal", value: "80", node_id: 4},
                 {reference: "1", label_translations: {"en"=>"improvement"}, operator: nil, value: nil, node_id: 5},
                 {reference: "2", label_translations: {"en"=>"no improvement"}, operator: nil, value: nil, node_id: 5},
                 {reference: "1", label_translations: {"en"=>"cellulitis description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "2", label_translations: {"en"=>"impetigo description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "3", label_translations: {"en"=>"chicken pox description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "4", label_translations: {"en"=>"herpes description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "5", label_translations: {"en"=>"shingles description to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "6", label_translations: {"en"=>"tinea corporis description and picture to confirm diangosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "7", label_translations: {"en"=>"scabies description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "8", label_translations: {"en"=>"urticaria description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "9", label_translations: {"en"=>"ecthyma/pyoderma description and picture to confirm diagnosis"}, operator: nil, value: nil, node_id: 6},
                 {reference: "1", label_translations: {"en"=>"positive"}, operator: nil, value: nil, node_id: 8},
                 {reference: "2", label_translations: {"en"=>"negative"}, operator: nil, value: nil, node_id: 8},
                 {reference: "1", label_translations: {"en"=>"< 6 g/dl"}, operator: "less", value: "6", node_id: 9},
                 {reference: "2", label_translations: {"en"=>">= 6 g/dl"}, operator: "more_or_equal", value: "6", node_id: 9},
                 {reference: "1", label_translations: {"en"=>"< 10 mg/L"}, operator: "less", value: "10", node_id: 10},
                 {reference: "2", label_translations: {"en"=>">= 10 < 40 mg/L"}, operator: "between", value: "10, 40", node_id: 10},
                 {reference: "3", label_translations: {"en"=>">= 40 < 80 mg/L"}, operator: "between", value: "40, 80", node_id: 10},
                 {reference: "4", label_translations: {"en"=>">= 80 mg/L"}, operator: "more_or_equal", value: "80", node_id: 10},
                 {reference: "1", label_translations: {"en"=>"< 3.3 mmol/l"}, operator: "less", value: "3.3", node_id: 11},
                 {reference: "2", label_translations: {"en"=>">= 3.3 mmol/l"}, operator: "more_or_equal", value: "3.3", node_id: 11},
                 {reference: "1", label_translations: {"en"=>"Less then 4 PCT in ug/l"}, operator: "less", value: "4", node_id: 12},
                 {reference: "2", label_translations: {"en"=>"More then 4 PCT in ug/l"}, operator: "more_or_equal", value: "4", node_id: 12},
                 {reference: "1", label_translations: {"en"=>"< 2 months"}, operator: "less", value: "2", node_id: 23},
                 {reference: "2", label_translations: {"en"=>">=2 < 6 months"}, operator: "between", value: "2, 6", node_id: 23},
                 {reference: "3", label_translations: {"en"=>">=6 < 12 months"}, operator: "between", value: "6, 12", node_id: 23},
                 {reference: "4", label_translations: {"en"=>">= 12 < 24 months"}, operator: "between", value: "12, 24", node_id: 23},
                 {reference: "5", label_translations: {"en"=>">=24 months < 5 years"}, operator: "between", value: "24, 60", node_id: 23},
                 {reference: "6", label_translations: {"en"=>">= 5 years"}, operator: "more_or_equal", value: "60", node_id: 23},
                 {reference: "x", label_translations: {"en"=>"list of villages "}, operator: nil, value: nil, node_id: 24},
                 {reference: "1", label_translations: {"en"=>"cerebral palsy"}, operator: nil, value: nil, node_id: 26},
                 {reference: "2", label_translations: {"en"=>"HIV"}, operator: nil, value: nil, node_id: 26},
                 {reference: "3", label_translations: {"en"=>"sickle cell"}, operator: nil, value: nil, node_id: 26},
                 {reference: "1", label_translations: {"en"=>"< -3 z-score"}, operator: nil, value: nil, node_id: 27},
                 {reference: "2", label_translations: {"en"=>"between -3 z-score and -2 z-score"}, operator: nil, value: nil, node_id: 27},
                 {reference: "1", label_translations: {"en"=>"< 11.5 cm"}, operator: "less", value: "11.5", node_id: 37},
                 {reference: "2", label_translations: {"en"=>">=11.5 < 12.5 cm"}, operator: "between", value: "11.5, 12.5", node_id: 37},
                 {reference: "1", label_translations: {"en"=>"abscess"}, operator: nil, value: nil, node_id: 38},
                 {reference: "2", label_translations: {"en"=>"vesicles and/or crusts"}, operator: nil, value: nil, node_id: 38},
                 {reference: "3", label_translations: {"en"=>"hyperpigmented or hypopigmented macules and patches"}, operator: nil, value: nil, node_id: 38},
                 {reference: "4", label_translations: {"en"=>"alopecia and scale"}, operator: nil, value: nil, node_id: 38},
                 {reference: "5", label_translations: {"en"=>"erythematous scaly plaque"}, operator: nil, value: nil, node_id: 38},
                 {reference: "6", label_translations: {"en"=>"red serpiginous (snake-like), curvilinear trails"}, operator: nil, value: nil, node_id: 38},
                 {reference: "1", label_translations: {"en"=>"honey colored crusted lesions"}, operator: nil, value: nil, node_id: 39},
                 {reference: "2", label_translations: {"en"=>"rounded erythematous plaque rounded with little vesicles"}, operator: nil, value: nil, node_id: 39},
                 {reference: "3", label_translations: {"en"=>"other"}, operator: nil, value: nil, node_id: 39},
                 {reference: "1", label_translations: {"en"=>"on face"}, operator: nil, value: nil, node_id: 40},
                 {reference: "2", label_translations: {"en"=>"perioral"}, operator: nil, value: nil, node_id: 40},
                 {reference: "3", label_translations: {"en"=>"located on one side of the body"}, operator: nil, value: nil, node_id: 40},
                 {reference: "4", label_translations: {"en"=>"lower extremities"}, operator: nil, value: nil, node_id: 40},
                 {reference: "5", label_translations: {"en"=>"diaper area"}, operator: nil, value: nil, node_id: 40},
                 {reference: "6", label_translations: {"en"=>"chest"}, operator: nil, value: nil, node_id: 40},
                 {reference: "7", label_translations: {"en"=>"back"}, operator: nil, value: nil, node_id: 40},
                 {reference: "8", label_translations: {"en"=>"upper arms"}, operator: nil, value: nil, node_id: 40},
                 {reference: "9", label_translations: {"en"=>"scalp"}, operator: nil, value: nil, node_id: 40},
                 {reference: "10", label_translations: {"en"=>"flexural aspects of extremities"}, operator: nil, value: nil, node_id: 40},
                 {reference: "1", label_translations: {"en"=>"large surrounding cellulitis (warm, red, tender)"}, operator: nil, value: nil, node_id: 41},
                 {reference: "2", label_translations: {"en"=>"war, red, tender (cellulits)"}, operator: nil, value: nil, node_id: 41},
                 {reference: "3", label_translations: {"en"=>"itching"}, operator: nil, value: nil, node_id: 41},
                 {reference: "4", label_translations: {"en"=>"painful"}, operator: nil, value: nil, node_id: 41},
                 {reference: "1", label_translations: {"en"=>"worrying "}, operator: nil, value: nil, node_id: 45},
                 {reference: "2", label_translations: {"en"=>"not worrying"}, operator: nil, value: nil, node_id: 45},
                 {reference: "1", label_translations: {"en"=>"worrying"}, operator: nil, value: nil, node_id: 46},
                 {reference: "2", label_translations: {"en"=>"not worrying"}, operator: nil, value: nil, node_id: 46},
                 {reference: "1", label_translations: {"en"=>"worrying"}, operator: nil, value: nil, node_id: 47},
                 {reference: "2", label_translations: {"en"=>"not worrying"}, operator: nil, value: nil, node_id: 47},
                 {reference: "1", label_translations: {"en"=>"°C"}, operator: "more_or_equal", value: "37.6", node_id: 48},
                 {reference: "1", label_translations: {"en"=>"< 90 %"}, operator: "less", value: "90", node_id: 49},
                 {reference: "2", label_translations: {"en"=>">= 90%"}, operator: "more_or_equal", value: "90", node_id: 49},
                 {reference: "1", label_translations: {"en"=>"severe tachycardia >= 90 percentile"}, operator: "more_or_equal", value: "90", node_id: 50},
                 {reference: "1", label_translations: {"en"=>"< 75 percentile"}, operator: "less", value: "75", node_id: 51},
                 {reference: "2", label_translations: {"en"=>">= 75 < 97 percentile"}, operator: "between", value: "75, 97", node_id: 51},
                 {reference: "3", label_translations: {"en"=>">= 97 percentile"}, operator: "more_or_equal", value: "97", node_id: 51},
                 {reference: "4", label_translations: {"en"=>">= 40 cycle/min"}, operator: "between", value: "40, 50", node_id: 51},
                 {reference: "5", label_translations: {"en"=>">= 50 cycle/min"}, operator: "more_or_equal", value: "50", node_id: 51},
                 {reference: "1", label_translations: {"en"=>"fever duration in days"}, operator: "less", value: "2", node_id: 62},
                 {reference: "2", label_translations: {"en"=>"fever duration in days"}, operator: "between", value: "2, 4", node_id: 62},
                 {reference: "3", label_translations: {"en"=>"fever duration in days"}, operator: "between", value: "4, 6", node_id: 62},
                 {reference: "4", label_translations: {"en"=>"fever duration in days"}, operator: "more_or_equal", value: "6", node_id: 62},
                 {reference: "1", label_translations: {"en"=>"< 4"}, operator: "less", value: "4", node_id: 71},
                 {reference: "2", label_translations: {"en"=>">=4"}, operator: "more_or_equal", value: "4", node_id: 71},
                 {reference: "1", label_translations: {"en"=>">= 11 loose stools over past 24hrs"}, operator: "more_or_equal", value: "11", node_id: 72},
                 {reference: "2", label_translations: {"en"=>">= 3 < 11 loose stools over past 24hrs"}, operator: "between", value: "3, 11", node_id: 72},
                 {reference: "3", label_translations: {"en"=>"< 3 loose stools over past 24hrs"}, operator: "less", value: "3", node_id: 72}
               ])

# Instance some questions to create some QS
a2 = Node.find(9)
a4 = Node.find(11)
d1 = Node.find(23)
pe1 = Node.find(27)
pe2 = Node.find(37)
pe4 = Node.find(49)
pe5 = Node.find(50)
pe6 = Node.find(51)
pe8 = Node.find(54)
pe9 = Node.find(53)
pe7 = Node.find(52)
pe25 = Node.find(43)
s1 = Node.find(55)
s3 = Node.find(63)
s4 = Node.find(64)

ps6 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: ods, reference: '6', label_en: 'Able to drink')
ps6_1 = ps6.answers.first
ps6_2 = ps6.answers.second

# PS6
ps6_s4 = Instance.create!(instanceable: ps6, node: s4)
ps6_p25 = Instance.create!(instanceable: ps6, node: pe25)
ps6_ps6 = Instance.create!(instanceable: ps6, node: ps6)

Condition.create!(referenceable: ps6_p25, first_conditionable: s4.answers.second, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: s4.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: pe25.answers.first, operator: nil, second_conditionable: nil)

ps1 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: ods, reference: '1', label_en: 'Fever')
ps1_1 = ps1.answers.first

ps2 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: ods, reference: '2', label_en: 'Danger signs')
ps2_1 = ps2.answers.first

dc1 = QuestionsSequences::Comorbidity.create!(algorithm: ods, reference: '1', label_en: 'Severe malnutrition')
dc1_1 = dc1.answers.first

dc2 = QuestionsSequences::Comorbidity.create!(algorithm: ods, reference: '2', label_en: 'Moderate malnutrition')
dc2_1 = dc2.answers.first

dc3 = QuestionsSequences::Comorbidity.create!(algorithm: ods, reference: '3', label_en: 'Severe anemia')
dc3_1 = dc3.answers.first

dc4 = QuestionsSequences::Comorbidity.create!(algorithm: ods, reference: '4', label_en: 'Hypoglycemia')
dc4_1 = dc4.answers.first

ps7 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: ods, reference: '7', label_en: 'Severe malnutrition')
ps7_1 = ps7.answers.first


# PS1
ps1_s1 = Instance.create!(instanceable: ps1, node: s1)
ps1_p4 = Instance.create!(instanceable: ps1, node: pe4)
ps1_ps1 = Instance.create!(instanceable: ps1, node: ps1)

Condition.create!(referenceable: ps1_ps1, first_conditionable: s1.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps1_ps1, first_conditionable: pe4.answers.first, operator: nil, second_conditionable: nil)

# PS2
ps2_s3 = Instance.create!(instanceable: ps2, node: s3)
ps2_p7 = Instance.create!(instanceable: ps2, node: pe7)
ps2_p8 = Instance.create!(instanceable: ps2, node: pe8)
ps2_p9 = Instance.create!(instanceable: ps2, node: pe9)
ps2_p1 = Instance.create!(instanceable: ps2, node: pe1)
ps2_p2 = Instance.create!(instanceable: ps2, node: pe2)
ps2_ps2 = Instance.create!(instanceable: ps2, node: ps2)

Condition.create!(referenceable: ps2_ps2, first_conditionable: s3.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: pe7.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: pe8.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: pe1.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: pe2.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: pe9.answers.first, operator: nil, second_conditionable: nil)

# DC1
dc1_e1 = Instance.create!(instanceable: dc1, node: d1)
dc1_p5 = Instance.create!(instanceable: dc1, node: pe5)
dc1_p6 = Instance.create!(instanceable: dc1, node: pe6)
dc1_dc1 = Instance.create!(instanceable: dc1, node: dc1)

Condition.create!(referenceable: dc1_p6, first_conditionable: d1.answers.third, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc1_dc1, first_conditionable: pe5.answers.first, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc1_dc1, first_conditionable: pe6.answers.first, operator: nil, second_conditionable: nil)

# # DC2
# dc2_e1 = Instance.create!(instanceable: dc2, node: d1)
# dc2_p5 = Instance.create!(instanceable: dc2, node: pe5)
# dc2_p6 = Instance.create!(instanceable: dc2, node: pe6)
# dc2_dc2 = Instance.create!(instanceable: dc2, node: dc2)
#
# Condition.create!(referenceable: dc2_p6, first_conditionable: d1.answers.third, operator: nil, second_conditionable: nil)
# Condition.create!(referenceable: dc2_dc2, first_conditionable: pe5.answers.second, operator: nil, second_conditionable: nil)
# Condition.create!(referenceable: dc2_dc2, first_conditionable: pe6.answers.second, operator: nil, second_conditionable: nil)

# DC3
dc3_a2 = Instance.create!(instanceable: dc3, node: a2)
dc3_dc3 = Instance.create!(instanceable: dc3, node: dc3)

Condition.create!(referenceable: dc3_dc3, first_conditionable: a2.answers.first, operator: nil, second_conditionable: nil)

# DC4
dc4_a4 = Instance.create!(instanceable: dc4, node: a4)
dc4_dc4 = Instance.create!(instanceable: dc4, node: dc4)

Condition.create!(referenceable: dc4_dc4, first_conditionable: a4.answers.first, operator: nil, second_conditionable: nil)

# C1
ps7_ps2 = Instance.create!(instanceable: ps7, node: ps2)
ps7_ps6 = Instance.create!(instanceable: ps7, node: ps6)
ps7_dc1 = Instance.create!(instanceable: ps7, node: dc1)
ps7_dc2 = Instance.create!(instanceable: ps7, node: dc2)
ps7_dc3 = Instance.create!(instanceable: ps7, node: dc3)
ps7_dc4 = Instance.create!(instanceable: ps7, node: dc4)
ps7_ps7 = Instance.create!(instanceable: ps7, node: ps7)

Condition.create!(referenceable: ps7_ps7, first_conditionable: ps2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps7_ps7, first_conditionable: ps6_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps7_ps7, first_conditionable: dc1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps7_ps7, first_conditionable: dc2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps7_ps7, first_conditionable: dc3_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps7_ps7, first_conditionable: dc4_1, operator: nil, second_conditionable: nil)

reference_table_male = '[
  0 : {
     "Day":0
    ,"SD4neg":1.701
    ,"SD3neg":2.080
    ,"SD2neg":2.459
    ,"SD1neg":2.881
    ,"SD0":3.346
    ,"SD1":3.859
    ,"SD2":4.419
    ,"SD3":5.031
    ,"SD4":5.642
  },
  1 : {
     "Day":1
    ,"SD4neg":1.692
    ,"SD3neg":2.065
    ,"SD2neg":2.437
    ,"SD1neg":2.854
    ,"SD0":3.317
    ,"SD1":3.830
    ,"SD2":4.394
    ,"SD3":5.013
    ,"SD4":5.633
  },
  2 : {
     "Day":2
    ,"SD4neg":1.707
    ,"SD3neg":2.080
    ,"SD2neg":2.454
    ,"SD1neg":2.872
    ,"SD0":3.337
    ,"SD1":3.852
    ,"SD2":4.421
    ,"SD3":5.045
    ,"SD4":5.669
  },
  3 : {
     "Day":3
    ,"SD4neg":1.725
    ,"SD3neg":2.100
    ,"SD2neg":2.475
    ,"SD1neg":2.895
    ,"SD0":3.363
    ,"SD1":3.881
    ,"SD2":4.453
    ,"SD3":5.083
    ,"SD4":5.712
  },
  4 : {
     "Day":4
    ,"SD4neg":1.745
    ,"SD3neg":2.122
    ,"SD2neg":2.499
    ,"SD1neg":2.921
    ,"SD0":3.392
    ,"SD1":3.913
    ,"SD2":4.490
    ,"SD3":5.124
    ,"SD4":5.758
  },
  5 : {
     "Day":5
    ,"SD4neg":1.767
    ,"SD3neg":2.146
    ,"SD2neg":2.525
    ,"SD1neg":2.949
    ,"SD0":3.422
    ,"SD1":3.947
    ,"SD2":4.528
    ,"SD3":5.167
    ,"SD4":5.806
  },
  6 : {
     "Day":6
    ,"SD4neg":1.789
    ,"SD3neg":2.170
    ,"SD2neg":2.551
    ,"SD1neg":2.978
    ,"SD0":3.454
    ,"SD1":3.983
    ,"SD2":4.568
    ,"SD3":5.211
    ,"SD4":5.855
  },
  7 : {
     "Day":7
    ,"SD4neg":1.812
    ,"SD3neg":2.195
    ,"SD2neg":2.579
    ,"SD1neg":3.009
    ,"SD0":3.488
    ,"SD1":4.020
    ,"SD2":4.609
    ,"SD3":5.257
    ,"SD4":5.905
  },
  8 : {
     "Day":8
    ,"SD4neg":1.835
    ,"SD3neg":2.221
    ,"SD2neg":2.607
    ,"SD1neg":3.040
    ,"SD0":3.522
    ,"SD1":4.058
    ,"SD2":4.650
    ,"SD3":5.303
    ,"SD4":5.956
  },
  9 : {
     "Day":9
    ,"SD4neg":1.859
    ,"SD3neg":2.248
    ,"SD2neg":2.637
    ,"SD1neg":3.072
    ,"SD0":3.558
    ,"SD1":4.097
    ,"SD2":4.693
    ,"SD3":5.351
    ,"SD4":6.009
  },
  10 : {
     "Day":10
    ,"SD4neg":1.884
    ,"SD3neg":2.276
    ,"SD2neg":2.667
    ,"SD1neg":3.105
    ,"SD0":3.594
    ,"SD1":4.137
    ,"SD2":4.738
    ,"SD3":5.400
    ,"SD4":6.062
  },
  11 : {
     "Day":11
    ,"SD4neg":1.910
    ,"SD3neg":2.304
    ,"SD2neg":2.698
    ,"SD1neg":3.140
    ,"SD0":3.632
    ,"SD1":4.179
    ,"SD2":4.784
    ,"SD3":5.451
    ,"SD4":6.118
  },
  12 : {
     "Day":12
    ,"SD4neg":1.936
    ,"SD3neg":2.333
    ,"SD2neg":2.730
    ,"SD1neg":3.175
    ,"SD0":3.671
    ,"SD1":4.222
    ,"SD2":4.831
    ,"SD3":5.503
    ,"SD4":6.175
  },
  13 : {
     "Day":13
    ,"SD4neg":1.963
    ,"SD3neg":2.363
    ,"SD2neg":2.764
    ,"SD1neg":3.212
    ,"SD0":3.711
    ,"SD1":4.266
    ,"SD2":4.880
    ,"SD3":5.558
    ,"SD4":6.235
  },
  14 : {
     "Day":14
    ,"SD4neg":1.991
    ,"SD3neg":2.395
    ,"SD2neg":2.798
    ,"SD1neg":3.249
    ,"SD0":3.753
    ,"SD1":4.312
    ,"SD2":4.931
    ,"SD3":5.613
    ,"SD4":6.296
  },
  15 : {
     "Day":15
    ,"SD4neg":2.020
    ,"SD3neg":2.426
    ,"SD2neg":2.833
    ,"SD1neg":3.288
    ,"SD0":3.796
    ,"SD1":4.359
    ,"SD2":4.983
    ,"SD3":5.671
    ,"SD4":6.358
  },
  16 : {
     "Day":16
    ,"SD4neg":2.049
    ,"SD3neg":2.459
    ,"SD2neg":2.869
    ,"SD1neg":3.327
    ,"SD0":3.839
    ,"SD1":4.407
    ,"SD2":5.035
    ,"SD3":5.729
    ,"SD4":6.422
  },
  17 : {
     "Day":17
    ,"SD4neg":2.078
    ,"SD3neg":2.491
    ,"SD2neg":2.905
    ,"SD1neg":3.367
    ,"SD0":3.883
    ,"SD1":4.455
    ,"SD2":5.089
    ,"SD3":5.787
    ,"SD4":6.486
  },
  18 : {
     "Day":18
    ,"SD4neg":2.107
    ,"SD3neg":2.524
    ,"SD2neg":2.941
    ,"SD1neg":3.407
    ,"SD0":3.927
    ,"SD1":4.504
    ,"SD2":5.143
    ,"SD3":5.847
    ,"SD4":6.551
  },
  19 : {
     "Day":19
    ,"SD4neg":2.137
    ,"SD3neg":2.557
    ,"SD2neg":2.977
    ,"SD1neg":3.448
    ,"SD0":3.971
    ,"SD1":4.553
    ,"SD2":5.196
    ,"SD3":5.906
    ,"SD4":6.615
  },
  20 : {
     "Day":20
    ,"SD4neg":2.167
    ,"SD3neg":2.590
    ,"SD2neg":3.014
    ,"SD1neg":3.488
    ,"SD0":4.016
    ,"SD1":4.602
    ,"SD2":5.250
    ,"SD3":5.965
    ,"SD4":6.680
  },
  21 : {
     "Day":21
    ,"SD4neg":2.197
    ,"SD3neg":2.624
    ,"SD2neg":3.051
    ,"SD1neg":3.528
    ,"SD0":4.060
    ,"SD1":4.651
    ,"SD2":5.304
    ,"SD3":6.024
    ,"SD4":6.745
  },
  22 : {
     "Day":22
    ,"SD4neg":2.226
    ,"SD3neg":2.657
    ,"SD2neg":3.087
    ,"SD1neg":3.569
    ,"SD0":4.105
    ,"SD1":4.700
    ,"SD2":5.358
    ,"SD3":6.083
    ,"SD4":6.809
  },
  23 : {
     "Day":23
    ,"SD4neg":2.256
    ,"SD3neg":2.690
    ,"SD2neg":3.124
    ,"SD1neg":3.609
    ,"SD0":4.149
    ,"SD1":4.748
    ,"SD2":5.411
    ,"SD3":6.142
    ,"SD4":6.873
  },
  24 : {
     "Day":24
    ,"SD4neg":2.286
    ,"SD3neg":2.723
    ,"SD2neg":3.160
    ,"SD1neg":3.649
    ,"SD0":4.193
    ,"SD1":4.797
    ,"SD2":5.464
    ,"SD3":6.200
    ,"SD4":6.937
  },
  25 : {
     "Day":25
    ,"SD4neg":2.316
    ,"SD3neg":2.756
    ,"SD2neg":3.197
    ,"SD1neg":3.689
    ,"SD0":4.237
    ,"SD1":4.845
    ,"SD2":5.517
    ,"SD3":6.259
    ,"SD4":7.000
  },
  26 : {
     "Day":26
    ,"SD4neg":2.345
    ,"SD3neg":2.789
    ,"SD2neg":3.233
    ,"SD1neg":3.729
    ,"SD0":4.281
    ,"SD1":4.893
    ,"SD2":5.570
    ,"SD3":6.316
    ,"SD4":7.063
  },
  27 : {
     "Day":27
    ,"SD4neg":2.375
    ,"SD3neg":2.822
    ,"SD2neg":3.269
    ,"SD1neg":3.768
    ,"SD0":4.324
    ,"SD1":4.940
    ,"SD2":5.622
    ,"SD3":6.373
    ,"SD4":7.125
  },
  28 : {
     "Day":28
    ,"SD4neg":2.404
    ,"SD3neg":2.854
    ,"SD2neg":3.305
    ,"SD1neg":3.807
    ,"SD0":4.367
    ,"SD1":4.988
    ,"SD2":5.674
    ,"SD3":6.430
    ,"SD4":7.187
  },
  29 : {
     "Day":29
    ,"SD4neg":2.433
    ,"SD3neg":2.887
    ,"SD2neg":3.340
    ,"SD1neg":3.847
    ,"SD0":4.410
    ,"SD1":5.035
    ,"SD2":5.725
    ,"SD3":6.487
    ,"SD4":7.248
  },
  30 : {
     "Day":30
    ,"SD4neg":2.462
    ,"SD3neg":2.919
    ,"SD2neg":3.376
    ,"SD1neg":3.885
    ,"SD0":4.452
    ,"SD1":5.081
    ,"SD2":5.776
    ,"SD3":6.542
    ,"SD4":7.308
  },
  31 : {
     "Day":31
    ,"SD4neg":2.491
    ,"SD3neg":2.951
    ,"SD2neg":3.411
    ,"SD1neg":3.924
    ,"SD0":4.495
    ,"SD1":5.127
    ,"SD2":5.827
    ,"SD3":6.597
    ,"SD4":7.368
  },
  32 : {
     "Day":32
    ,"SD4neg":2.520
    ,"SD3neg":2.982
    ,"SD2neg":3.445
    ,"SD1neg":3.962
    ,"SD0":4.536
    ,"SD1":5.173
    ,"SD2":5.877
    ,"SD3":6.652
    ,"SD4":7.427
  },
  33 : {
     "Day":33
    ,"SD4neg":2.548
    ,"SD3neg":3.014
    ,"SD2neg":3.480
    ,"SD1neg":4.000
    ,"SD0":4.578
    ,"SD1":5.218
    ,"SD2":5.926
    ,"SD3":6.706
    ,"SD4":7.486
  },
  34 : {
     "Day":34
    ,"SD4neg":2.576
    ,"SD3neg":3.045
    ,"SD2neg":3.514
    ,"SD1neg":4.037
    ,"SD0":4.618
    ,"SD1":5.263
    ,"SD2":5.975
    ,"SD3":6.759
    ,"SD4":7.543
  },
  35 : {
     "Day":35
    ,"SD4neg":2.604
    ,"SD3neg":3.076
    ,"SD2neg":3.548
    ,"SD1neg":4.074
    ,"SD0":4.659
    ,"SD1":5.307
    ,"SD2":6.023
    ,"SD3":6.812
    ,"SD4":7.600
  },
  36 : {
     "Day":36
    ,"SD4neg":2.632
    ,"SD3neg":3.107
    ,"SD2neg":3.581
    ,"SD1neg":4.111
    ,"SD0":4.699
    ,"SD1":5.351
    ,"SD2":6.071
    ,"SD3":6.864
    ,"SD4":7.657
  },
  37 : {
     "Day":37
    ,"SD4neg":2.660
    ,"SD3neg":3.137
    ,"SD2neg":3.615
    ,"SD1neg":4.147
    ,"SD0":4.739
    ,"SD1":5.394
    ,"SD2":6.118
    ,"SD3":6.915
    ,"SD4":7.712
  },
  38 : {
     "Day":38
    ,"SD4neg":2.687
    ,"SD3neg":3.167
    ,"SD2neg":3.648
    ,"SD1neg":4.183
    ,"SD0":4.778
    ,"SD1":5.437
    ,"SD2":6.164
    ,"SD3":6.965
    ,"SD4":7.767
  },
  39 : {
     "Day":39
    ,"SD4neg":2.714
    ,"SD3neg":3.197
    ,"SD2neg":3.680
    ,"SD1neg":4.219
    ,"SD0":4.817
    ,"SD1":5.479
    ,"SD2":6.210
    ,"SD3":7.016
    ,"SD4":7.821
  },
  40 : {
     "Day":40
    ,"SD4neg":2.741
    ,"SD3neg":3.227
    ,"SD2neg":3.712
    ,"SD1neg":4.254
    ,"SD0":4.855
    ,"SD1":5.521
    ,"SD2":6.256
    ,"SD3":7.065
    ,"SD4":7.874
  },
  41 : {
     "Day":41
    ,"SD4neg":2.768
    ,"SD3neg":3.256
    ,"SD2neg":3.744
    ,"SD1neg":4.289
    ,"SD0":4.893
    ,"SD1":5.562
    ,"SD2":6.300
    ,"SD3":7.114
    ,"SD4":7.927
  },
  42 : {
     "Day":42
    ,"SD4neg":2.794
    ,"SD3neg":3.285
    ,"SD2neg":3.776
    ,"SD1neg":4.323
    ,"SD0":4.930
    ,"SD1":5.603
    ,"SD2":6.345
    ,"SD3":7.162
    ,"SD4":7.979
  },
  43 : {
     "Day":43
    ,"SD4neg":2.820
    ,"SD3neg":3.314
    ,"SD2neg":3.807
    ,"SD1neg":4.357
    ,"SD0":4.967
    ,"SD1":5.643
    ,"SD2":6.388
    ,"SD3":7.209
    ,"SD4":8.030
  },
  44 : {
     "Day":44
    ,"SD4neg":2.846
    ,"SD3neg":3.342
    ,"SD2neg":3.838
    ,"SD1neg":4.391
    ,"SD0":5.004
    ,"SD1":5.683
    ,"SD2":6.432
    ,"SD3":7.256
    ,"SD4":8.081
  },
  45 : {
     "Day":45
    ,"SD4neg":2.872
    ,"SD3neg":3.370
    ,"SD2neg":3.869
    ,"SD1neg":4.424
    ,"SD0":5.040
    ,"SD1":5.722
    ,"SD2":6.475
    ,"SD3":7.303
    ,"SD4":8.131
  },
  46 : {
     "Day":46
    ,"SD4neg":2.897
    ,"SD3neg":3.398
    ,"SD2neg":3.900
    ,"SD1neg":4.457
    ,"SD0":5.076
    ,"SD1":5.761
    ,"SD2":6.517
    ,"SD3":7.349
    ,"SD4":8.180
  },
  47 : {
     "Day":47
    ,"SD4neg":2.923
    ,"SD3neg":3.426
    ,"SD2neg":3.930
    ,"SD1neg":4.490
    ,"SD0":5.112
    ,"SD1":5.800
    ,"SD2":6.558
    ,"SD3":7.394
    ,"SD4":8.229
  },
  48 : {
     "Day":48
    ,"SD4neg":2.948
    ,"SD3neg":3.454
    ,"SD2neg":3.960
    ,"SD1neg":4.522
    ,"SD0":5.147
    ,"SD1":5.838
    ,"SD2":6.600
    ,"SD3":7.438
    ,"SD4":8.277
  },
  49 : {
     "Day":49
    ,"SD4neg":2.972
    ,"SD3neg":3.481
    ,"SD2neg":3.989
    ,"SD1neg":4.555
    ,"SD0":5.182
    ,"SD1":5.875
    ,"SD2":6.641
    ,"SD3":7.483
    ,"SD4":8.325
  },
  50 : {
     "Day":50
    ,"SD4neg":2.997
    ,"SD3neg":3.508
    ,"SD2neg":4.018
    ,"SD1neg":4.586
    ,"SD0":5.216
    ,"SD1":5.913
    ,"SD2":6.681
    ,"SD3":7.526
    ,"SD4":8.372
  },
  51 : {
     "Day":51
    ,"SD4neg":3.021
    ,"SD3neg":3.534
    ,"SD2neg":4.047
    ,"SD1neg":4.618
    ,"SD0":5.250
    ,"SD1":5.949
    ,"SD2":6.721
    ,"SD3":7.569
    ,"SD4":8.418
  },
  52 : {
     "Day":52
    ,"SD4neg":3.045
    ,"SD3neg":3.561
    ,"SD2neg":4.076
    ,"SD1neg":4.649
    ,"SD0":5.284
    ,"SD1":5.986
    ,"SD2":6.760
    ,"SD3":7.612
    ,"SD4":8.464
  },
  53 : {
     "Day":53
    ,"SD4neg":3.070
    ,"SD3neg":3.587
    ,"SD2neg":4.104
    ,"SD1neg":4.680
    ,"SD0":5.317
    ,"SD1":6.022
    ,"SD2":6.799
    ,"SD3":7.654
    ,"SD4":8.509
  },
  54 : {
     "Day":54
    ,"SD4neg":3.093
    ,"SD3neg":3.613
    ,"SD2neg":4.133
    ,"SD1neg":4.710
    ,"SD0":5.350
    ,"SD1":6.057
    ,"SD2":6.837
    ,"SD3":7.696
    ,"SD4":8.554
  },
  55 : {
     "Day":55
    ,"SD4neg":3.117
    ,"SD3neg":3.639
    ,"SD2neg":4.160
    ,"SD1neg":4.740
    ,"SD0":5.383
    ,"SD1":6.093
    ,"SD2":6.876
    ,"SD3":7.737
    ,"SD4":8.598
  },
  56 : {
     "Day":56
    ,"SD4neg":3.140
    ,"SD3neg":3.664
    ,"SD2neg":4.188
    ,"SD1neg":4.770
    ,"SD0":5.415
    ,"SD1":6.128
    ,"SD2":6.913
    ,"SD3":7.777
    ,"SD4":8.642
  },
  57 : {
     "Day":57
    ,"SD4neg":3.164
    ,"SD3neg":3.689
    ,"SD2neg":4.215
    ,"SD1neg":4.800
    ,"SD0":5.447
    ,"SD1":6.162
    ,"SD2":6.950
    ,"SD3":7.817
    ,"SD4":8.684
  },
  58 : {
     "Day":58
    ,"SD4neg":3.187
    ,"SD3neg":3.714
    ,"SD2neg":4.242
    ,"SD1neg":4.829
    ,"SD0":5.478
    ,"SD1":6.196
    ,"SD2":6.987
    ,"SD3":7.857
    ,"SD4":8.727
  },
  59 : {
     "Day":59
    ,"SD4neg":3.209
    ,"SD3neg":3.739
    ,"SD2neg":4.269
    ,"SD1neg":4.858
    ,"SD0":5.510
    ,"SD1":6.230
    ,"SD2":7.024
    ,"SD3":7.896
    ,"SD4":8.769
  },
  60 : {
     "Day":60
    ,"SD4neg":3.232
    ,"SD3neg":3.764
    ,"SD2neg":4.296
    ,"SD1neg":4.887
    ,"SD0":5.541
    ,"SD1":6.263
    ,"SD2":7.060
    ,"SD3":7.935
    ,"SD4":8.811
  },
  61 : {
     "Day":61
    ,"SD4neg":3.254
    ,"SD3neg":3.788
    ,"SD2neg":4.322
    ,"SD1neg":4.915
    ,"SD0":5.571
    ,"SD1":6.296
    ,"SD2":7.095
    ,"SD3":7.974
    ,"SD4":8.852
  },
  62 : {
     "Day":62
    ,"SD4neg":3.276
    ,"SD3neg":3.812
    ,"SD2neg":4.348
    ,"SD1neg":4.943
    ,"SD0":5.602
    ,"SD1":6.329
    ,"SD2":7.131
    ,"SD3":8.012
    ,"SD4":8.893
  },
  63 : {
     "Day":63
    ,"SD4neg":3.298
    ,"SD3neg":3.836
    ,"SD2neg":4.374
    ,"SD1neg":4.971
    ,"SD0":5.632
    ,"SD1":6.362
    ,"SD2":7.166
    ,"SD3":8.049
    ,"SD4":8.933
  },
  64 : {
     "Day":64
    ,"SD4neg":3.320
    ,"SD3neg":3.860
    ,"SD2neg":4.400
    ,"SD1neg":4.999
    ,"SD0":5.662
    ,"SD1":6.394
    ,"SD2":7.200
    ,"SD3":8.087
    ,"SD4":8.973
  },
  65 : {
     "Day":65
    ,"SD4neg":3.342
    ,"SD3neg":3.884
    ,"SD2neg":4.425
    ,"SD1neg":5.026
    ,"SD0":5.691
    ,"SD1":6.426
    ,"SD2":7.234
    ,"SD3":8.123
    ,"SD4":9.013
  },
  66 : {
     "Day":66
    ,"SD4neg":3.364
    ,"SD3neg":3.907
    ,"SD2neg":4.450
    ,"SD1neg":5.053
    ,"SD0":5.720
    ,"SD1":6.457
    ,"SD2":7.268
    ,"SD3":8.160
    ,"SD4":9.052
  },
  67 : {
     "Day":67
    ,"SD4neg":3.385
    ,"SD3neg":3.930
    ,"SD2neg":4.475
    ,"SD1neg":5.080
    ,"SD0":5.749
    ,"SD1":6.488
    ,"SD2":7.302
    ,"SD3":8.196
    ,"SD4":9.090
  },
  68 : {
     "Day":68
    ,"SD4neg":3.406
    ,"SD3neg":3.953
    ,"SD2neg":4.500
    ,"SD1neg":5.107
    ,"SD0":5.778
    ,"SD1":6.519
    ,"SD2":7.335
    ,"SD3":8.232
    ,"SD4":9.128
  },
  69 : {
     "Day":69
    ,"SD4neg":3.427
    ,"SD3neg":3.976
    ,"SD2neg":4.525
    ,"SD1neg":5.133
    ,"SD0":5.806
    ,"SD1":6.550
    ,"SD2":7.368
    ,"SD3":8.267
    ,"SD4":9.166
  },
  70 : {
     "Day":70
    ,"SD4neg":3.448
    ,"SD3neg":3.998
    ,"SD2neg":4.549
    ,"SD1neg":5.159
    ,"SD0":5.835
    ,"SD1":6.580
    ,"SD2":7.400
    ,"SD3":8.302
    ,"SD4":9.203
  },
  71 : {
     "Day":71
    ,"SD4neg":3.468
    ,"SD3neg":4.021
    ,"SD2neg":4.573
    ,"SD1neg":5.185
    ,"SD0":5.862
    ,"SD1":6.610
    ,"SD2":7.433
    ,"SD3":8.337
    ,"SD4":9.240
  },
  72 : {
     "Day":72
    ,"SD4neg":3.489
    ,"SD3neg":4.043
    ,"SD2neg":4.597
    ,"SD1neg":5.211
    ,"SD0":5.890
    ,"SD1":6.639
    ,"SD2":7.464
    ,"SD3":8.371
    ,"SD4":9.277
  },
  73 : {
     "Day":73
    ,"SD4neg":3.509
    ,"SD3neg":4.065
    ,"SD2neg":4.620
    ,"SD1neg":5.236
    ,"SD0":5.917
    ,"SD1":6.669
    ,"SD2":7.496
    ,"SD3":8.405
    ,"SD4":9.313
  },
  74 : {
     "Day":74
    ,"SD4neg":3.529
    ,"SD3neg":4.087
    ,"SD2neg":4.644
    ,"SD1neg":5.262
    ,"SD0":5.944
    ,"SD1":6.698
    ,"SD2":7.527
    ,"SD3":8.438
    ,"SD4":9.349
  },
  75 : {
     "Day":75
    ,"SD4neg":3.549
    ,"SD3neg":4.108
    ,"SD2neg":4.667
    ,"SD1neg":5.287
    ,"SD0":5.971
    ,"SD1":6.727
    ,"SD2":7.558
    ,"SD3":8.471
    ,"SD4":9.385
  },
  76 : {
     "Day":76
    ,"SD4neg":3.569
    ,"SD3neg":4.130
    ,"SD2neg":4.690
    ,"SD1neg":5.311
    ,"SD0":5.998
    ,"SD1":6.755
    ,"SD2":7.589
    ,"SD3":8.504
    ,"SD4":9.420
  },
  77 : {
     "Day":77
    ,"SD4neg":3.588
    ,"SD3neg":4.151
    ,"SD2neg":4.713
    ,"SD1neg":5.336
    ,"SD0":6.024
    ,"SD1":6.783
    ,"SD2":7.619
    ,"SD3":8.537
    ,"SD4":9.455
  },
  78 : {
     "Day":78
    ,"SD4neg":3.608
    ,"SD3neg":4.172
    ,"SD2neg":4.736
    ,"SD1neg":5.360
    ,"SD0":6.050
    ,"SD1":6.811
    ,"SD2":7.649
    ,"SD3":8.569
    ,"SD4":9.489
  },
  79 : {
     "Day":79
    ,"SD4neg":3.627
    ,"SD3neg":4.193
    ,"SD2neg":4.758
    ,"SD1neg":5.384
    ,"SD0":6.076
    ,"SD1":6.839
    ,"SD2":7.679
    ,"SD3":8.601
    ,"SD4":9.523
  },
  80 : {
     "Day":80
    ,"SD4neg":3.646
    ,"SD3neg":4.213
    ,"SD2neg":4.780
    ,"SD1neg":5.408
    ,"SD0":6.102
    ,"SD1":6.867
    ,"SD2":7.709
    ,"SD3":8.633
    ,"SD4":9.557
  },
  81 : {
     "Day":81
    ,"SD4neg":3.665
    ,"SD3neg":4.234
    ,"SD2neg":4.802
    ,"SD1neg":5.432
    ,"SD0":6.127
    ,"SD1":6.894
    ,"SD2":7.738
    ,"SD3":8.664
    ,"SD4":9.590
  },
  82 : {
     "Day":82
    ,"SD4neg":3.684
    ,"SD3neg":4.254
    ,"SD2neg":4.824
    ,"SD1neg":5.455
    ,"SD0":6.152
    ,"SD1":6.921
    ,"SD2":7.767
    ,"SD3":8.695
    ,"SD4":9.624
  },
  83 : {
     "Day":83
    ,"SD4neg":3.703
    ,"SD3neg":4.274
    ,"SD2neg":4.846
    ,"SD1neg":5.478
    ,"SD0":6.177
    ,"SD1":6.948
    ,"SD2":7.795
    ,"SD3":8.726
    ,"SD4":9.657
  },
  84 : {
     "Day":84
    ,"SD4neg":3.721
    ,"SD3neg":4.294
    ,"SD2neg":4.867
    ,"SD1neg":5.501
    ,"SD0":6.202
    ,"SD1":6.974
    ,"SD2":7.824
    ,"SD3":8.756
    ,"SD4":9.689
  },
  85 : {
     "Day":85
    ,"SD4neg":3.739
    ,"SD3neg":4.314
    ,"SD2neg":4.888
    ,"SD1neg":5.524
    ,"SD0":6.226
    ,"SD1":7.000
    ,"SD2":7.852
    ,"SD3":8.787
    ,"SD4":9.721
  },
  86 : {
     "Day":86
    ,"SD4neg":3.758
    ,"SD3neg":4.334
    ,"SD2neg":4.909
    ,"SD1neg":5.547
    ,"SD0":6.251
    ,"SD1":7.027
    ,"SD2":7.880
    ,"SD3":8.817
    ,"SD4":9.753
  },
  87 : {
     "Day":87
    ,"SD4neg":3.776
    ,"SD3neg":4.353
    ,"SD2neg":4.930
    ,"SD1neg":5.569
    ,"SD0":6.275
    ,"SD1":7.052
    ,"SD2":7.907
    ,"SD3":8.846
    ,"SD4":9.785
  },
  88 : {
     "Day":88
    ,"SD4neg":3.794
    ,"SD3neg":4.372
    ,"SD2neg":4.951
    ,"SD1neg":5.591
    ,"SD0":6.299
    ,"SD1":7.078
    ,"SD2":7.935
    ,"SD3":8.876
    ,"SD4":9.816
  },
  89 : {
     "Day":89
    ,"SD4neg":3.811
    ,"SD3neg":4.392
    ,"SD2neg":4.972
    ,"SD1neg":5.614
    ,"SD0":6.322
    ,"SD1":7.103
    ,"SD2":7.962
    ,"SD3":8.905
    ,"SD4":9.848
  },
  90 : {
     "Day":90
    ,"SD4neg":3.829
    ,"SD3neg":4.410
    ,"SD2neg":4.992
    ,"SD1neg":5.635
    ,"SD0":6.346
    ,"SD1":7.128
    ,"SD2":7.989
    ,"SD3":8.934
    ,"SD4":9.879
  },
  91 : {
     "Day":91
    ,"SD4neg":3.846
    ,"SD3neg":4.429
    ,"SD2neg":5.012
    ,"SD1neg":5.657
    ,"SD0":6.369
    ,"SD1":7.153
    ,"SD2":8.016
    ,"SD3":8.962
    ,"SD4":9.909
  },
  92 : {
     "Day":92
    ,"SD4neg":3.864
    ,"SD3neg":4.448
    ,"SD2neg":5.032
    ,"SD1neg":5.679
    ,"SD0":6.392
    ,"SD1":7.178
    ,"SD2":8.042
    ,"SD3":8.991
    ,"SD4":9.940
  },
  93 : {
     "Day":93
    ,"SD4neg":3.881
    ,"SD3neg":4.466
    ,"SD2neg":5.052
    ,"SD1neg":5.700
    ,"SD0":6.415
    ,"SD1":7.203
    ,"SD2":8.069
    ,"SD3":9.019
    ,"SD4":9.970
  },
  94 : {
     "Day":94
    ,"SD4neg":3.898
    ,"SD3neg":4.485
    ,"SD2neg":5.072
    ,"SD1neg":5.721
    ,"SD0":6.438
    ,"SD1":7.227
    ,"SD2":8.095
    ,"SD3":9.047
    ,"SD4":10.000
  },
  95 : {
     "Day":95
    ,"SD4neg":3.915
    ,"SD3neg":4.503
    ,"SD2neg":5.091
    ,"SD1neg":5.742
    ,"SD0":6.460
    ,"SD1":7.251
    ,"SD2":8.121
    ,"SD3":9.075
    ,"SD4":10.029
  },
  96 : {
     "Day":96
    ,"SD4neg":3.931
    ,"SD3neg":4.521
    ,"SD2neg":5.111
    ,"SD1neg":5.763
    ,"SD0":6.482
    ,"SD1":7.275
    ,"SD2":8.146
    ,"SD3":9.102
    ,"SD4":10.058
  },
  97 : {
     "Day":97
    ,"SD4neg":3.948
    ,"SD3neg":4.539
    ,"SD2neg":5.130
    ,"SD1neg":5.783
    ,"SD0":6.505
    ,"SD1":7.299
    ,"SD2":8.172
    ,"SD3":9.130
    ,"SD4":10.088
  },
  98 : {
     "Day":98
    ,"SD4neg":3.965
    ,"SD3neg":4.557
    ,"SD2neg":5.149
    ,"SD1neg":5.804
    ,"SD0":6.526
    ,"SD1":7.322
    ,"SD2":8.197
    ,"SD3":9.157
    ,"SD4":10.117
  },
  99 : {
     "Day":99
    ,"SD4neg":3.981
    ,"SD3neg":4.574
    ,"SD2neg":5.168
    ,"SD1neg":5.824
    ,"SD0":6.548
    ,"SD1":7.346
    ,"SD2":8.222
    ,"SD3":9.184
    ,"SD4":10.146
  },
  100 : {
     "Day":100
    ,"SD4neg":3.997
    ,"SD3neg":4.592
    ,"SD2neg":5.187
    ,"SD1neg":5.844
    ,"SD0":6.570
    ,"SD1":7.369
    ,"SD2":8.247
    ,"SD3":9.211
    ,"SD4":10.174
  },
  101 : {
     "Day":101
    ,"SD4neg":4.013
    ,"SD3neg":4.609
    ,"SD2neg":5.205
    ,"SD1neg":5.864
    ,"SD0":6.591
    ,"SD1":7.392
    ,"SD2":8.272
    ,"SD3":9.237
    ,"SD4":10.203
  },
  102 : {
     "Day":102
    ,"SD4neg":4.029
    ,"SD3neg":4.626
    ,"SD2neg":5.224
    ,"SD1neg":5.884
    ,"SD0":6.613
    ,"SD1":7.415
    ,"SD2":8.296
    ,"SD3":9.263
    ,"SD4":10.230
  },
  103 : {
     "Day":103
    ,"SD4neg":4.045
    ,"SD3neg":4.644
    ,"SD2neg":5.242
    ,"SD1neg":5.904
    ,"SD0":6.634
    ,"SD1":7.437
    ,"SD2":8.321
    ,"SD3":9.290
    ,"SD4":10.259
  },
  104 : {
     "Day":104
    ,"SD4neg":4.061
    ,"SD3neg":4.660
    ,"SD2neg":5.260
    ,"SD1neg":5.923
    ,"SD0":6.655
    ,"SD1":7.460
    ,"SD2":8.345
    ,"SD3":9.315
    ,"SD4":10.286
  },
  105 : {
     "Day":105
    ,"SD4neg":4.076
    ,"SD3neg":4.677
    ,"SD2neg":5.278
    ,"SD1neg":5.943
    ,"SD0":6.676
    ,"SD1":7.482
    ,"SD2":8.369
    ,"SD3":9.341
    ,"SD4":10.314
  },
  106 : {
     "Day":106
    ,"SD4neg":4.092
    ,"SD3neg":4.694
    ,"SD2neg":5.296
    ,"SD1neg":5.962
    ,"SD0":6.696
    ,"SD1":7.504
    ,"SD2":8.392
    ,"SD3":9.367
    ,"SD4":10.341
  },
  107 : {
     "Day":107
    ,"SD4neg":4.107
    ,"SD3neg":4.711
    ,"SD2neg":5.314
    ,"SD1neg":5.981
    ,"SD0":6.717
    ,"SD1":7.526
    ,"SD2":8.416
    ,"SD3":9.392
    ,"SD4":10.368
  },
  108 : {
     "Day":108
    ,"SD4neg":4.122
    ,"SD3neg":4.727
    ,"SD2neg":5.332
    ,"SD1neg":6.000
    ,"SD0":6.737
    ,"SD1":7.548
    ,"SD2":8.440
    ,"SD3":9.418
    ,"SD4":10.395
  },
  109 : {
     "Day":109
    ,"SD4neg":4.137
    ,"SD3neg":4.743
    ,"SD2neg":5.349
    ,"SD1neg":6.019
    ,"SD0":6.757
    ,"SD1":7.570
    ,"SD2":8.463
    ,"SD3":9.443
    ,"SD4":10.422
  },
  110 : {
     "Day":110
    ,"SD4neg":4.152
    ,"SD3neg":4.759
    ,"SD2neg":5.367
    ,"SD1neg":6.037
    ,"SD0":6.777
    ,"SD1":7.591
    ,"SD2":8.486
    ,"SD3":9.467
    ,"SD4":10.449
  },
  111 : {
     "Day":111
    ,"SD4neg":4.167
    ,"SD3neg":4.775
    ,"SD2neg":5.384
    ,"SD1neg":6.056
    ,"SD0":6.797
    ,"SD1":7.613
    ,"SD2":8.509
    ,"SD3":9.492
    ,"SD4":10.475
  },
  112 : {
     "Day":112
    ,"SD4neg":4.182
    ,"SD3neg":4.791
    ,"SD2neg":5.401
    ,"SD1neg":6.074
    ,"SD0":6.817
    ,"SD1":7.634
    ,"SD2":8.532
    ,"SD3":9.516
    ,"SD4":10.501
  },
  113 : {
     "Day":113
    ,"SD4neg":4.197
    ,"SD3neg":4.807
    ,"SD2neg":5.418
    ,"SD1neg":6.093
    ,"SD0":6.836
    ,"SD1":7.655
    ,"SD2":8.555
    ,"SD3":9.541
    ,"SD4":10.528
  },
  114 : {
     "Day":114
    ,"SD4neg":4.211
    ,"SD3neg":4.823
    ,"SD2neg":5.435
    ,"SD1neg":6.111
    ,"SD0":6.856
    ,"SD1":7.676
    ,"SD2":8.577
    ,"SD3":9.565
    ,"SD4":10.553
  },
  115 : {
     "Day":115
    ,"SD4neg":4.225
    ,"SD3neg":4.838
    ,"SD2neg":5.452
    ,"SD1neg":6.129
    ,"SD0":6.875
    ,"SD1":7.697
    ,"SD2":8.600
    ,"SD3":9.590
    ,"SD4":10.580
  },
  116 : {
     "Day":116
    ,"SD4neg":4.240
    ,"SD3neg":4.854
    ,"SD2neg":5.468
    ,"SD1neg":6.147
    ,"SD0":6.894
    ,"SD1":7.717
    ,"SD2":8.622
    ,"SD3":9.613
    ,"SD4":10.605
  },
  117 : {
     "Day":117
    ,"SD4neg":4.254
    ,"SD3neg":4.869
    ,"SD2neg":5.485
    ,"SD1neg":6.164
    ,"SD0":6.914
    ,"SD1":7.738
    ,"SD2":8.644
    ,"SD3":9.637
    ,"SD4":10.630
  },
  118 : {
     "Day":118
    ,"SD4neg":4.268
    ,"SD3neg":4.884
    ,"SD2neg":5.501
    ,"SD1neg":6.182
    ,"SD0":6.932
    ,"SD1":7.758
    ,"SD2":8.666
    ,"SD3":9.661
    ,"SD4":10.656
  },
  119 : {
     "Day":119
    ,"SD4neg":4.282
    ,"SD3neg":4.900
    ,"SD2neg":5.517
    ,"SD1neg":6.199
    ,"SD0":6.951
    ,"SD1":7.779
    ,"SD2":8.688
    ,"SD3":9.684
    ,"SD4":10.681
  },
  120 : {
     "Day":120
    ,"SD4neg":4.296
    ,"SD3neg":4.915
    ,"SD2neg":5.533
    ,"SD1neg":6.217
    ,"SD0":6.970
    ,"SD1":7.799
    ,"SD2":8.709
    ,"SD3":9.707
    ,"SD4":10.706
  },
  121 : {
     "Day":121
    ,"SD4neg":4.310
    ,"SD3neg":4.929
    ,"SD2neg":5.549
    ,"SD1neg":6.234
    ,"SD0":6.988
    ,"SD1":7.819
    ,"SD2":8.731
    ,"SD3":9.731
    ,"SD4":10.731
  },
  122 : {
     "Day":122
    ,"SD4neg":4.323
    ,"SD3neg":4.944
    ,"SD2neg":5.565
    ,"SD1neg":6.251
    ,"SD0":7.007
    ,"SD1":7.838
    ,"SD2":8.752
    ,"SD3":9.754
    ,"SD4":10.756
  },
  123 : {
     "Day":123
    ,"SD4neg":4.337
    ,"SD3neg":4.959
    ,"SD2neg":5.581
    ,"SD1neg":6.268
    ,"SD0":7.025
    ,"SD1":7.858
    ,"SD2":8.773
    ,"SD3":9.777
    ,"SD4":10.780
  },
  124 : {
     "Day":124
    ,"SD4neg":4.350
    ,"SD3neg":4.974
    ,"SD2neg":5.597
    ,"SD1neg":6.285
    ,"SD0":7.043
    ,"SD1":7.878
    ,"SD2":8.794
    ,"SD3":9.800
    ,"SD4":10.805
  },
  125 : {
     "Day":125
    ,"SD4neg":4.364
    ,"SD3neg":4.988
    ,"SD2neg":5.613
    ,"SD1neg":6.302
    ,"SD0":7.062
    ,"SD1":7.897
    ,"SD2":8.815
    ,"SD3":9.822
    ,"SD4":10.829
  },
  126 : {
     "Day":126
    ,"SD4neg":4.377
    ,"SD3neg":5.002
    ,"SD2neg":5.628
    ,"SD1neg":6.318
    ,"SD0":7.079
    ,"SD1":7.917
    ,"SD2":8.836
    ,"SD3":9.845
    ,"SD4":10.854
  },
  127 : {
     "Day":127
    ,"SD4neg":4.390
    ,"SD3neg":5.017
    ,"SD2neg":5.643
    ,"SD1neg":6.335
    ,"SD0":7.097
    ,"SD1":7.936
    ,"SD2":8.857
    ,"SD3":9.867
    ,"SD4":10.878
  },
  128 : {
     "Day":128
    ,"SD4neg":4.403
    ,"SD3neg":5.031
    ,"SD2neg":5.658
    ,"SD1neg":6.351
    ,"SD0":7.115
    ,"SD1":7.955
    ,"SD2":8.878
    ,"SD3":9.889
    ,"SD4":10.901
  },
  129 : {
     "Day":129
    ,"SD4neg":4.416
    ,"SD3neg":5.045
    ,"SD2neg":5.674
    ,"SD1neg":6.368
    ,"SD0":7.132
    ,"SD1":7.974
    ,"SD2":8.898
    ,"SD3":9.912
    ,"SD4":10.925
  },
  130 : {
     "Day":130
    ,"SD4neg":4.429
    ,"SD3neg":5.059
    ,"SD2neg":5.689
    ,"SD1neg":6.384
    ,"SD0":7.150
    ,"SD1":7.993
    ,"SD2":8.919
    ,"SD3":9.934
    ,"SD4":10.949
  },
  131 : {
     "Day":131
    ,"SD4neg":4.442
    ,"SD3neg":5.073
    ,"SD2neg":5.704
    ,"SD1neg":6.400
    ,"SD0":7.167
    ,"SD1":8.012
    ,"SD2":8.939
    ,"SD3":9.956
    ,"SD4":10.973
  },
  132 : {
     "Day":132
    ,"SD4neg":4.454
    ,"SD3neg":5.086
    ,"SD2neg":5.718
    ,"SD1neg":6.416
    ,"SD0":7.185
    ,"SD1":8.030
    ,"SD2":8.959
    ,"SD3":9.978
    ,"SD4":10.996
  },
  133 : {
     "Day":133
    ,"SD4neg":4.467
    ,"SD3neg":5.100
    ,"SD2neg":5.733
    ,"SD1neg":6.432
    ,"SD0":7.202
    ,"SD1":8.049
    ,"SD2":8.979
    ,"SD3":9.999
    ,"SD4":11.020
  },
  134 : {
     "Day":134
    ,"SD4neg":4.479
    ,"SD3neg":5.113
    ,"SD2neg":5.748
    ,"SD1neg":6.448
    ,"SD0":7.219
    ,"SD1":8.067
    ,"SD2":8.999
    ,"SD3":10.021
    ,"SD4":11.043
  },
  135 : {
     "Day":135
    ,"SD4neg":4.492
    ,"SD3neg":5.127
    ,"SD2neg":5.762
    ,"SD1neg":6.463
    ,"SD0":7.236
    ,"SD1":8.085
    ,"SD2":9.019
    ,"SD3":10.042
    ,"SD4":11.066
  },
  136 : {
     "Day":136
    ,"SD4neg":4.504
    ,"SD3neg":5.140
    ,"SD2neg":5.777
    ,"SD1neg":6.479
    ,"SD0":7.252
    ,"SD1":8.104
    ,"SD2":9.038
    ,"SD3":10.064
    ,"SD4":11.089
  },
  137 : {
     "Day":137
    ,"SD4neg":4.516
    ,"SD3neg":5.154
    ,"SD2neg":5.791
    ,"SD1neg":6.494
    ,"SD0":7.269
    ,"SD1":8.122
    ,"SD2":9.058
    ,"SD3":10.085
    ,"SD4":11.112
  },
  138 : {
     "Day":138
    ,"SD4neg":4.528
    ,"SD3neg":5.167
    ,"SD2neg":5.805
    ,"SD1neg":6.510
    ,"SD0":7.286
    ,"SD1":8.140
    ,"SD2":9.077
    ,"SD3":10.106
    ,"SD4":11.134
  },
  139 : {
     "Day":139
    ,"SD4neg":4.540
    ,"SD3neg":5.180
    ,"SD2neg":5.819
    ,"SD1neg":6.525
    ,"SD0":7.302
    ,"SD1":8.158
    ,"SD2":9.097
    ,"SD3":10.127
    ,"SD4":11.157
  },
  140 : {
     "Day":140
    ,"SD4neg":4.552
    ,"SD3neg":5.193
    ,"SD2neg":5.833
    ,"SD1neg":6.540
    ,"SD0":7.319
    ,"SD1":8.175
    ,"SD2":9.116
    ,"SD3":10.148
    ,"SD4":11.180
  },
  141 : {
     "Day":141
    ,"SD4neg":4.564
    ,"SD3neg":5.206
    ,"SD2neg":5.847
    ,"SD1neg":6.555
    ,"SD0":7.335
    ,"SD1":8.193
    ,"SD2":9.135
    ,"SD3":10.168
    ,"SD4":11.202
  },
  142 : {
     "Day":142
    ,"SD4neg":4.576
    ,"SD3neg":5.219
    ,"SD2neg":5.861
    ,"SD1neg":6.570
    ,"SD0":7.351
    ,"SD1":8.210
    ,"SD2":9.154
    ,"SD3":10.189
    ,"SD4":11.224
  },
  143 : {
     "Day":143
    ,"SD4neg":4.588
    ,"SD3neg":5.231
    ,"SD2neg":5.875
    ,"SD1neg":6.585
    ,"SD0":7.367
    ,"SD1":8.228
    ,"SD2":9.173
    ,"SD3":10.210
    ,"SD4":11.247
  },
  144 : {
     "Day":144
    ,"SD4neg":4.599
    ,"SD3neg":5.244
    ,"SD2neg":5.888
    ,"SD1neg":6.600
    ,"SD0":7.383
    ,"SD1":8.245
    ,"SD2":9.192
    ,"SD3":10.230
    ,"SD4":11.269
  },
  145 : {
     "Day":145
    ,"SD4neg":4.611
    ,"SD3neg":5.256
    ,"SD2neg":5.902
    ,"SD1neg":6.614
    ,"SD0":7.399
    ,"SD1":8.262
    ,"SD2":9.211
    ,"SD3":10.251
    ,"SD4":11.291
  },
  146 : {
     "Day":146
    ,"SD4neg":4.622
    ,"SD3neg":5.269
    ,"SD2neg":5.915
    ,"SD1neg":6.629
    ,"SD0":7.415
    ,"SD1":8.280
    ,"SD2":9.229
    ,"SD3":10.271
    ,"SD4":11.313
  },
  147 : {
     "Day":147
    ,"SD4neg":4.633
    ,"SD3neg":5.281
    ,"SD2neg":5.929
    ,"SD1neg":6.643
    ,"SD0":7.431
    ,"SD1":8.297
    ,"SD2":9.248
    ,"SD3":10.291
    ,"SD4":11.335
  },
  148 : {
     "Day":148
    ,"SD4neg":4.645
    ,"SD3neg":5.294
    ,"SD2neg":5.942
    ,"SD1neg":6.658
    ,"SD0":7.446
    ,"SD1":8.314
    ,"SD2":9.266
    ,"SD3":10.311
    ,"SD4":11.356
  },
  149 : {
     "Day":149
    ,"SD4neg":4.656
    ,"SD3neg":5.306
    ,"SD2neg":5.955
    ,"SD1neg":6.672
    ,"SD0":7.462
    ,"SD1":8.330
    ,"SD2":9.285
    ,"SD3":10.331
    ,"SD4":11.378
  },
  150 : {
     "Day":150
    ,"SD4neg":4.667
    ,"SD3neg":5.318
    ,"SD2neg":5.968
    ,"SD1neg":6.686
    ,"SD0":7.477
    ,"SD1":8.347
    ,"SD2":9.303
    ,"SD3":10.351
    ,"SD4":11.399
  },
  151 : {
     "Day":151
    ,"SD4neg":4.678
    ,"SD3neg":5.330
    ,"SD2neg":5.981
    ,"SD1neg":6.700
    ,"SD0":7.492
    ,"SD1":8.364
    ,"SD2":9.321
    ,"SD3":10.371
    ,"SD4":11.421
  },
  152 : {
     "Day":152
    ,"SD4neg":4.689
    ,"SD3neg":5.342
    ,"SD2neg":5.994
    ,"SD1neg":6.714
    ,"SD0":7.508
    ,"SD1":8.380
    ,"SD2":9.339
    ,"SD3":10.390
    ,"SD4":11.442
  },
  153 : {
     "Day":153
    ,"SD4neg":4.700
    ,"SD3neg":5.354
    ,"SD2neg":6.007
    ,"SD1neg":6.728
    ,"SD0":7.523
    ,"SD1":8.397
    ,"SD2":9.357
    ,"SD3":10.410
    ,"SD4":11.463
  },
  154 : {
     "Day":154
    ,"SD4neg":4.711
    ,"SD3neg":5.365
    ,"SD2neg":6.020
    ,"SD1neg":6.742
    ,"SD0":7.538
    ,"SD1":8.413
    ,"SD2":9.375
    ,"SD3":10.429
    ,"SD4":11.484
  },
  155 : {
     "Day":155
    ,"SD4neg":4.721
    ,"SD3neg":5.377
    ,"SD2neg":6.033
    ,"SD1neg":6.756
    ,"SD0":7.553
    ,"SD1":8.429
    ,"SD2":9.392
    ,"SD3":10.449
    ,"SD4":11.505
  },
  156 : {
     "Day":156
    ,"SD4neg":4.732
    ,"SD3neg":5.389
    ,"SD2neg":6.045
    ,"SD1neg":6.770
    ,"SD0":7.568
    ,"SD1":8.446
    ,"SD2":9.410
    ,"SD3":10.468
    ,"SD4":11.526
  },
  157 : {
     "Day":157
    ,"SD4neg":4.743
    ,"SD3neg":5.400
    ,"SD2neg":6.058
    ,"SD1neg":6.783
    ,"SD0":7.582
    ,"SD1":8.462
    ,"SD2":9.427
    ,"SD3":10.487
    ,"SD4":11.546
  },
  158 : {
     "Day":158
    ,"SD4neg":4.753
    ,"SD3neg":5.412
    ,"SD2neg":6.070
    ,"SD1neg":6.797
    ,"SD0":7.597
    ,"SD1":8.478
    ,"SD2":9.445
    ,"SD3":10.506
    ,"SD4":11.567
  },
  159 : {
     "Day":159
    ,"SD4neg":4.764
    ,"SD3neg":5.423
    ,"SD2neg":6.082
    ,"SD1neg":6.810
    ,"SD0":7.612
    ,"SD1":8.494
    ,"SD2":9.462
    ,"SD3":10.525
    ,"SD4":11.588
  },
  160 : {
     "Day":160
    ,"SD4neg":4.774
    ,"SD3neg":5.434
    ,"SD2neg":6.095
    ,"SD1neg":6.823
    ,"SD0":7.626
    ,"SD1":8.509
    ,"SD2":9.480
    ,"SD3":10.544
    ,"SD4":11.608
  },
  161 : {
     "Day":161
    ,"SD4neg":4.784
    ,"SD3neg":5.445
    ,"SD2neg":6.107
    ,"SD1neg":6.837
    ,"SD0":7.641
    ,"SD1":8.525
    ,"SD2":9.497
    ,"SD3":10.563
    ,"SD4":11.629
  },
  162 : {
     "Day":162
    ,"SD4neg":4.794
    ,"SD3neg":5.457
    ,"SD2neg":6.119
    ,"SD1neg":6.850
    ,"SD0":7.655
    ,"SD1":8.541
    ,"SD2":9.514
    ,"SD3":10.582
    ,"SD4":11.649
  },
  163 : {
     "Day":163
    ,"SD4neg":4.804
    ,"SD3neg":5.468
    ,"SD2neg":6.131
    ,"SD1neg":6.863
    ,"SD0":7.669
    ,"SD1":8.556
    ,"SD2":9.531
    ,"SD3":10.600
    ,"SD4":11.669
  },
  164 : {
     "Day":164
    ,"SD4neg":4.814
    ,"SD3neg":5.479
    ,"SD2neg":6.143
    ,"SD1neg":6.876
    ,"SD0":7.683
    ,"SD1":8.572
    ,"SD2":9.548
    ,"SD3":10.619
    ,"SD4":11.689
  },
  165 : {
     "Day":165
    ,"SD4neg":4.824
    ,"SD3neg":5.490
    ,"SD2neg":6.155
    ,"SD1neg":6.889
    ,"SD0":7.698
    ,"SD1":8.587
    ,"SD2":9.565
    ,"SD3":10.637
    ,"SD4":11.710
  },
  166 : {
     "Day":166
    ,"SD4neg":4.834
    ,"SD3neg":5.500
    ,"SD2neg":6.167
    ,"SD1neg":6.902
    ,"SD0":7.712
    ,"SD1":8.602
    ,"SD2":9.581
    ,"SD3":10.655
    ,"SD4":11.729
  },
  167 : {
     "Day":167
    ,"SD4neg":4.844
    ,"SD3neg":5.511
    ,"SD2neg":6.178
    ,"SD1neg":6.915
    ,"SD0":7.726
    ,"SD1":8.618
    ,"SD2":9.598
    ,"SD3":10.674
    ,"SD4":11.749
  },
  168 : {
     "Day":168
    ,"SD4neg":4.854
    ,"SD3neg":5.522
    ,"SD2neg":6.190
    ,"SD1neg":6.927
    ,"SD0":7.739
    ,"SD1":8.633
    ,"SD2":9.615
    ,"SD3":10.692
    ,"SD4":11.769
  },
  169 : {
     "Day":169
    ,"SD4neg":4.864
    ,"SD3neg":5.533
    ,"SD2neg":6.202
    ,"SD1neg":6.940
    ,"SD0":7.753
    ,"SD1":8.648
    ,"SD2":9.631
    ,"SD3":10.710
    ,"SD4":11.789
  },
  170 : {
     "Day":170
    ,"SD4neg":4.873
    ,"SD3neg":5.543
    ,"SD2neg":6.213
    ,"SD1neg":6.952
    ,"SD0":7.767
    ,"SD1":8.663
    ,"SD2":9.648
    ,"SD3":10.728
    ,"SD4":11.809
  },
  171 : {
     "Day":171
    ,"SD4neg":4.883
    ,"SD3neg":5.554
    ,"SD2neg":6.225
    ,"SD1neg":6.965
    ,"SD0":7.780
    ,"SD1":8.678
    ,"SD2":9.664
    ,"SD3":10.746
    ,"SD4":11.828
  },
  172 : {
     "Day":172
    ,"SD4neg":4.892
    ,"SD3neg":5.564
    ,"SD2neg":6.236
    ,"SD1neg":6.977
    ,"SD0":7.794
    ,"SD1":8.693
    ,"SD2":9.680
    ,"SD3":10.764
    ,"SD4":11.848
  },
  173 : {
     "Day":173
    ,"SD4neg":4.902
    ,"SD3neg":5.575
    ,"SD2neg":6.247
    ,"SD1neg":6.990
    ,"SD0":7.808
    ,"SD1":8.708
    ,"SD2":9.696
    ,"SD3":10.782
    ,"SD4":11.867
  },
  174 : {
     "Day":174
    ,"SD4neg":4.911
    ,"SD3neg":5.585
    ,"SD2neg":6.259
    ,"SD1neg":7.002
    ,"SD0":7.821
    ,"SD1":8.722
    ,"SD2":9.713
    ,"SD3":10.799
    ,"SD4":11.886
  },
  175 : {
     "Day":175
    ,"SD4neg":4.921
    ,"SD3neg":5.595
    ,"SD2neg":6.270
    ,"SD1neg":7.014
    ,"SD0":7.834
    ,"SD1":8.737
    ,"SD2":9.729
    ,"SD3":10.817
    ,"SD4":11.905
  },
  176 : {
     "Day":176
    ,"SD4neg":4.930
    ,"SD3neg":5.605
    ,"SD2neg":6.281
    ,"SD1neg":7.026
    ,"SD0":7.848
    ,"SD1":8.751
    ,"SD2":9.745
    ,"SD3":10.835
    ,"SD4":11.925
  },
  177 : {
     "Day":177
    ,"SD4neg":4.939
    ,"SD3neg":5.616
    ,"SD2neg":6.292
    ,"SD1neg":7.038
    ,"SD0":7.861
    ,"SD1":8.766
    ,"SD2":9.761
    ,"SD3":10.852
    ,"SD4":11.944
  },
  178 : {
     "Day":178
    ,"SD4neg":4.948
    ,"SD3neg":5.626
    ,"SD2neg":6.303
    ,"SD1neg":7.050
    ,"SD0":7.874
    ,"SD1":8.780
    ,"SD2":9.776
    ,"SD3":10.870
    ,"SD4":11.963
  },
  179 : {
     "Day":179
    ,"SD4neg":4.957
    ,"SD3neg":5.636
    ,"SD2neg":6.314
    ,"SD1neg":7.062
    ,"SD0":7.887
    ,"SD1":8.795
    ,"SD2":9.792
    ,"SD3":10.887
    ,"SD4":11.982
  },
  180 : {
     "Day":180
    ,"SD4neg":4.966
    ,"SD3neg":5.646
    ,"SD2neg":6.325
    ,"SD1neg":7.074
    ,"SD0":7.900
    ,"SD1":8.809
    ,"SD2":9.808
    ,"SD3":10.904
    ,"SD4":12.001
  },
  181 : {
     "Day":181
    ,"SD4neg":4.975
    ,"SD3neg":5.656
    ,"SD2neg":6.336
    ,"SD1neg":7.086
    ,"SD0":7.913
    ,"SD1":8.823
    ,"SD2":9.823
    ,"SD3":10.921
    ,"SD4":12.019
  },
  182 : {
     "Day":182
    ,"SD4neg":4.984
    ,"SD3neg":5.665
    ,"SD2neg":6.346
    ,"SD1neg":7.098
    ,"SD0":7.926
    ,"SD1":8.837
    ,"SD2":9.839
    ,"SD3":10.939
    ,"SD4":12.038
  },
  183 : {
     "Day":183
    ,"SD4neg":4.993
    ,"SD3neg":5.675
    ,"SD2neg":6.357
    ,"SD1neg":7.110
    ,"SD0":7.939
    ,"SD1":8.852
    ,"SD2":9.855
    ,"SD3":10.956
    ,"SD4":12.057
  },
  184 : {
     "Day":184
    ,"SD4neg":5.002
    ,"SD3neg":5.685
    ,"SD2neg":6.368
    ,"SD1neg":7.121
    ,"SD0":7.952
    ,"SD1":8.866
    ,"SD2":9.870
    ,"SD3":10.973
    ,"SD4":12.076
  },
  185 : {
     "Day":185
    ,"SD4neg":5.011
    ,"SD3neg":5.695
    ,"SD2neg":6.378
    ,"SD1neg":7.133
    ,"SD0":7.964
    ,"SD1":8.879
    ,"SD2":9.885
    ,"SD3":10.990
    ,"SD4":12.094
  },
  186 : {
     "Day":186
    ,"SD4neg":5.020
    ,"SD3neg":5.704
    ,"SD2neg":6.389
    ,"SD1neg":7.144
    ,"SD0":7.977
    ,"SD1":8.893
    ,"SD2":9.901
    ,"SD3":11.007
    ,"SD4":12.113
  },
  187 : {
     "Day":187
    ,"SD4neg":5.028
    ,"SD3neg":5.714
    ,"SD2neg":6.399
    ,"SD1neg":7.156
    ,"SD0":7.990
    ,"SD1":8.907
    ,"SD2":9.916
    ,"SD3":11.023
    ,"SD4":12.131
  },
  188 : {
     "Day":188
    ,"SD4neg":5.037
    ,"SD3neg":5.723
    ,"SD2neg":6.410
    ,"SD1neg":7.167
    ,"SD0":8.002
    ,"SD1":8.921
    ,"SD2":9.931
    ,"SD3":11.040
    ,"SD4":12.149
  },
  189 : {
     "Day":189
    ,"SD4neg":5.045
    ,"SD3neg":5.733
    ,"SD2neg":6.420
    ,"SD1neg":7.178
    ,"SD0":8.014
    ,"SD1":8.935
    ,"SD2":9.946
    ,"SD3":11.057
    ,"SD4":12.168
  },
  190 : {
     "Day":190
    ,"SD4neg":5.054
    ,"SD3neg":5.742
    ,"SD2neg":6.430
    ,"SD1neg":7.190
    ,"SD0":8.027
    ,"SD1":8.948
    ,"SD2":9.961
    ,"SD3":11.074
    ,"SD4":12.186
  },
  191 : {
     "Day":191
    ,"SD4neg":5.062
    ,"SD3neg":5.751
    ,"SD2neg":6.441
    ,"SD1neg":7.201
    ,"SD0":8.039
    ,"SD1":8.962
    ,"SD2":9.976
    ,"SD3":11.090
    ,"SD4":12.204
  },
  192 : {
     "Day":192
    ,"SD4neg":5.071
    ,"SD3neg":5.761
    ,"SD2neg":6.451
    ,"SD1neg":7.212
    ,"SD0":8.052
    ,"SD1":8.975
    ,"SD2":9.991
    ,"SD3":11.106
    ,"SD4":12.222
  },
  193 : {
     "Day":193
    ,"SD4neg":5.079
    ,"SD3neg":5.770
    ,"SD2neg":6.461
    ,"SD1neg":7.223
    ,"SD0":8.064
    ,"SD1":8.989
    ,"SD2":10.006
    ,"SD3":11.123
    ,"SD4":12.240
  },
  194 : {
     "Day":194
    ,"SD4neg":5.088
    ,"SD3neg":5.779
    ,"SD2neg":6.471
    ,"SD1neg":7.234
    ,"SD0":8.076
    ,"SD1":9.002
    ,"SD2":10.021
    ,"SD3":11.139
    ,"SD4":12.258
  },
  195 : {
     "Day":195
    ,"SD4neg":5.096
    ,"SD3neg":5.788
    ,"SD2neg":6.481
    ,"SD1neg":7.245
    ,"SD0":8.088
    ,"SD1":9.015
    ,"SD2":10.035
    ,"SD3":11.155
    ,"SD4":12.275
  },
  196 : {
     "Day":196
    ,"SD4neg":5.104
    ,"SD3neg":5.797
    ,"SD2neg":6.491
    ,"SD1neg":7.256
    ,"SD0":8.100
    ,"SD1":9.029
    ,"SD2":10.050
    ,"SD3":11.172
    ,"SD4":12.293
  },
  197 : {
     "Day":197
    ,"SD4neg":5.112
    ,"SD3neg":5.807
    ,"SD2neg":6.501
    ,"SD1neg":7.267
    ,"SD0":8.112
    ,"SD1":9.042
    ,"SD2":10.065
    ,"SD3":11.188
    ,"SD4":12.311
  },
  198 : {
     "Day":198
    ,"SD4neg":5.120
    ,"SD3neg":5.815
    ,"SD2neg":6.511
    ,"SD1neg":7.278
    ,"SD0":8.124
    ,"SD1":9.055
    ,"SD2":10.079
    ,"SD3":11.204
    ,"SD4":12.329
  },
  199 : {
     "Day":199
    ,"SD4neg":5.128
    ,"SD3neg":5.824
    ,"SD2neg":6.520
    ,"SD1neg":7.289
    ,"SD0":8.136
    ,"SD1":9.068
    ,"SD2":10.094
    ,"SD3":11.220
    ,"SD4":12.346
  },
  200 : {
     "Day":200
    ,"SD4neg":5.136
    ,"SD3neg":5.833
    ,"SD2neg":6.530
    ,"SD1neg":7.299
    ,"SD0":8.148
    ,"SD1":9.081
    ,"SD2":10.108
    ,"SD3":11.236
    ,"SD4":12.364
  },
  201 : {
     "Day":201
    ,"SD4neg":5.144
    ,"SD3neg":5.842
    ,"SD2neg":6.540
    ,"SD1neg":7.310
    ,"SD0":8.159
    ,"SD1":9.094
    ,"SD2":10.123
    ,"SD3":11.252
    ,"SD4":12.382
  },
  202 : {
     "Day":202
    ,"SD4neg":5.152
    ,"SD3neg":5.851
    ,"SD2neg":6.550
    ,"SD1neg":7.321
    ,"SD0":8.171
    ,"SD1":9.107
    ,"SD2":10.137
    ,"SD3":11.268
    ,"SD4":12.399
  },
  203 : {
     "Day":203
    ,"SD4neg":5.160
    ,"SD3neg":5.860
    ,"SD2neg":6.559
    ,"SD1neg":7.331
    ,"SD0":8.183
    ,"SD1":9.120
    ,"SD2":10.151
    ,"SD3":11.283
    ,"SD4":12.416
  },
  204 : {
     "Day":204
    ,"SD4neg":5.168
    ,"SD3neg":5.868
    ,"SD2neg":6.569
    ,"SD1neg":7.342
    ,"SD0":8.194
    ,"SD1":9.133
    ,"SD2":10.165
    ,"SD3":11.299
    ,"SD4":12.433
  },
  205 : {
     "Day":205
    ,"SD4neg":5.176
    ,"SD3neg":5.877
    ,"SD2neg":6.578
    ,"SD1neg":7.352
    ,"SD0":8.206
    ,"SD1":9.146
    ,"SD2":10.179
    ,"SD3":11.315
    ,"SD4":12.451
  },
  206 : {
     "Day":206
    ,"SD4neg":5.184
    ,"SD3neg":5.886
    ,"SD2neg":6.588
    ,"SD1neg":7.363
    ,"SD0":8.217
    ,"SD1":9.158
    ,"SD2":10.193
    ,"SD3":11.331
    ,"SD4":12.468
  },
  207 : {
     "Day":207
    ,"SD4neg":5.191
    ,"SD3neg":5.894
    ,"SD2neg":6.597
    ,"SD1neg":7.373
    ,"SD0":8.229
    ,"SD1":9.171
    ,"SD2":10.207
    ,"SD3":11.346
    ,"SD4":12.485
  },
  208 : {
     "Day":208
    ,"SD4neg":5.199
    ,"SD3neg":5.903
    ,"SD2neg":6.607
    ,"SD1neg":7.383
    ,"SD0":8.240
    ,"SD1":9.184
    ,"SD2":10.221
    ,"SD3":11.361
    ,"SD4":12.502
  },
  209 : {
     "Day":209
    ,"SD4neg":5.207
    ,"SD3neg":5.911
    ,"SD2neg":6.616
    ,"SD1neg":7.394
    ,"SD0":8.251
    ,"SD1":9.196
    ,"SD2":10.235
    ,"SD3":11.377
    ,"SD4":12.519
  },
  210 : {
     "Day":210
    ,"SD4neg":5.214
    ,"SD3neg":5.920
    ,"SD2neg":6.625
    ,"SD1neg":7.404
    ,"SD0":8.263
    ,"SD1":9.209
    ,"SD2":10.249
    ,"SD3":11.392
    ,"SD4":12.536
  },
  211 : {
     "Day":211
    ,"SD4neg":5.222
    ,"SD3neg":5.928
    ,"SD2neg":6.634
    ,"SD1neg":7.414
    ,"SD0":8.274
    ,"SD1":9.221
    ,"SD2":10.263
    ,"SD3":11.408
    ,"SD4":12.553
  },
  212 : {
     "Day":212
    ,"SD4neg":5.230
    ,"SD3neg":5.937
    ,"SD2neg":6.644
    ,"SD1neg":7.424
    ,"SD0":8.285
    ,"SD1":9.233
    ,"SD2":10.276
    ,"SD3":11.423
    ,"SD4":12.569
  },
  213 : {
     "Day":213
    ,"SD4neg":5.237
    ,"SD3neg":5.945
    ,"SD2neg":6.653
    ,"SD1neg":7.434
    ,"SD0":8.296
    ,"SD1":9.246
    ,"SD2":10.290
    ,"SD3":11.438
    ,"SD4":12.586
  },
  214 : {
     "Day":214
    ,"SD4neg":5.244
    ,"SD3neg":5.953
    ,"SD2neg":6.662
    ,"SD1neg":7.444
    ,"SD0":8.307
    ,"SD1":9.258
    ,"SD2":10.304
    ,"SD3":11.453
    ,"SD4":12.603
  },
  215 : {
     "Day":215
    ,"SD4neg":5.252
    ,"SD3neg":5.961
    ,"SD2neg":6.671
    ,"SD1neg":7.454
    ,"SD0":8.318
    ,"SD1":9.270
    ,"SD2":10.317
    ,"SD3":11.468
    ,"SD4":12.619
  },
  216 : {
     "Day":216
    ,"SD4neg":5.259
    ,"SD3neg":5.970
    ,"SD2neg":6.680
    ,"SD1neg":7.464
    ,"SD0":8.329
    ,"SD1":9.282
    ,"SD2":10.331
    ,"SD3":11.483
    ,"SD4":12.636
  },
  217 : {
     "Day":217
    ,"SD4neg":5.267
    ,"SD3neg":5.978
    ,"SD2neg":6.689
    ,"SD1neg":7.474
    ,"SD0":8.340
    ,"SD1":9.295
    ,"SD2":10.345
    ,"SD3":11.499
    ,"SD4":12.652
  },
  218 : {
     "Day":218
    ,"SD4neg":5.274
    ,"SD3neg":5.986
    ,"SD2neg":6.698
    ,"SD1neg":7.484
    ,"SD0":8.351
    ,"SD1":9.307
    ,"SD2":10.358
    ,"SD3":11.513
    ,"SD4":12.669
  },
  219 : {
     "Day":219
    ,"SD4neg":5.281
    ,"SD3neg":5.994
    ,"SD2neg":6.707
    ,"SD1neg":7.494
    ,"SD0":8.362
    ,"SD1":9.319
    ,"SD2":10.371
    ,"SD3":11.528
    ,"SD4":12.685
  },
  220 : {
     "Day":220
    ,"SD4neg":5.288
    ,"SD3neg":6.002
    ,"SD2neg":6.716
    ,"SD1neg":7.504
    ,"SD0":8.373
    ,"SD1":9.331
    ,"SD2":10.384
    ,"SD3":11.543
    ,"SD4":12.701
  },
  221 : {
     "Day":221
    ,"SD4neg":5.296
    ,"SD3neg":6.010
    ,"SD2neg":6.724
    ,"SD1neg":7.513
    ,"SD0":8.384
    ,"SD1":9.343
    ,"SD2":10.398
    ,"SD3":11.558
    ,"SD4":12.718
  },
  222 : {
     "Day":222
    ,"SD4neg":5.303
    ,"SD3neg":6.018
    ,"SD2neg":6.733
    ,"SD1neg":7.523
    ,"SD0":8.394
    ,"SD1":9.355
    ,"SD2":10.411
    ,"SD3":11.573
    ,"SD4":12.734
  },
  223 : {
     "Day":223
    ,"SD4neg":5.310
    ,"SD3neg":6.026
    ,"SD2neg":6.742
    ,"SD1neg":7.533
    ,"SD0":8.405
    ,"SD1":9.366
    ,"SD2":10.424
    ,"SD3":11.587
    ,"SD4":12.750
  },
  224 : {
     "Day":224
    ,"SD4neg":5.317
    ,"SD3neg":6.034
    ,"SD2neg":6.751
    ,"SD1neg":7.542
    ,"SD0":8.416
    ,"SD1":9.378
    ,"SD2":10.437
    ,"SD3":11.602
    ,"SD4":12.766
  },
  225 : {
     "Day":225
    ,"SD4neg":5.324
    ,"SD3neg":6.042
    ,"SD2neg":6.759
    ,"SD1neg":7.552
    ,"SD0":8.426
    ,"SD1":9.390
    ,"SD2":10.450
    ,"SD3":11.616
    ,"SD4":12.782
  },
  226 : {
     "Day":226
    ,"SD4neg":5.331
    ,"SD3neg":6.049
    ,"SD2neg":6.768
    ,"SD1neg":7.561
    ,"SD0":8.437
    ,"SD1":9.402
    ,"SD2":10.464
    ,"SD3":11.631
    ,"SD4":12.799
  },
  227 : {
     "Day":227
    ,"SD4neg":5.338
    ,"SD3neg":6.057
    ,"SD2neg":6.776
    ,"SD1neg":7.571
    ,"SD0":8.447
    ,"SD1":9.413
    ,"SD2":10.476
    ,"SD3":11.646
    ,"SD4":12.815
  },
  228 : {
     "Day":228
    ,"SD4neg":5.345
    ,"SD3neg":6.065
    ,"SD2neg":6.785
    ,"SD1neg":7.580
    ,"SD0":8.458
    ,"SD1":9.425
    ,"SD2":10.489
    ,"SD3":11.660
    ,"SD4":12.830
  },
  229 : {
     "Day":229
    ,"SD4neg":5.352
    ,"SD3neg":6.073
    ,"SD2neg":6.793
    ,"SD1neg":7.590
    ,"SD0":8.468
    ,"SD1":9.437
    ,"SD2":10.502
    ,"SD3":11.674
    ,"SD4":12.847
  },
  230 : {
     "Day":230
    ,"SD4neg":5.359
    ,"SD3neg":6.080
    ,"SD2neg":6.802
    ,"SD1neg":7.599
    ,"SD0":8.479
    ,"SD1":9.448
    ,"SD2":10.515
    ,"SD3":11.689
    ,"SD4":12.862
  },
  231 : {
     "Day":231
    ,"SD4neg":5.366
    ,"SD3neg":6.088
    ,"SD2neg":6.810
    ,"SD1neg":7.608
    ,"SD0":8.489
    ,"SD1":9.459
    ,"SD2":10.528
    ,"SD3":11.703
    ,"SD4":12.878
  },
  232 : {
     "Day":232
    ,"SD4neg":5.372
    ,"SD3neg":6.096
    ,"SD2neg":6.819
    ,"SD1neg":7.618
    ,"SD0":8.499
    ,"SD1":9.471
    ,"SD2":10.541
    ,"SD3":11.717
    ,"SD4":12.894
  },
  233 : {
     "Day":233
    ,"SD4neg":5.379
    ,"SD3neg":6.103
    ,"SD2neg":6.827
    ,"SD1neg":7.627
    ,"SD0":8.510
    ,"SD1":9.482
    ,"SD2":10.553
    ,"SD3":11.731
    ,"SD4":12.909
  },
  234 : {
     "Day":234
    ,"SD4neg":5.386
    ,"SD3neg":6.111
    ,"SD2neg":6.836
    ,"SD1neg":7.636
    ,"SD0":8.520
    ,"SD1":9.494
    ,"SD2":10.566
    ,"SD3":11.746
    ,"SD4":12.925
  },
  235 : {
     "Day":235
    ,"SD4neg":5.393
    ,"SD3neg":6.118
    ,"SD2neg":6.844
    ,"SD1neg":7.645
    ,"SD0":8.530
    ,"SD1":9.505
    ,"SD2":10.579
    ,"SD3":11.759
    ,"SD4":12.940
  },
  236 : {
     "Day":236
    ,"SD4neg":5.399
    ,"SD3neg":6.126
    ,"SD2neg":6.852
    ,"SD1neg":7.655
    ,"SD0":8.540
    ,"SD1":9.516
    ,"SD2":10.591
    ,"SD3":11.774
    ,"SD4":12.956
  },
  237 : {
     "Day":237
    ,"SD4neg":5.406
    ,"SD3neg":6.133
    ,"SD2neg":6.860
    ,"SD1neg":7.664
    ,"SD0":8.550
    ,"SD1":9.527
    ,"SD2":10.604
    ,"SD3":11.787
    ,"SD4":12.971
  },
  238 : {
     "Day":238
    ,"SD4neg":5.413
    ,"SD3neg":6.141
    ,"SD2neg":6.869
    ,"SD1neg":7.673
    ,"SD0":8.560
    ,"SD1":9.539
    ,"SD2":10.616
    ,"SD3":11.802
    ,"SD4":12.987
  },
  239 : {
     "Day":239
    ,"SD4neg":5.419
    ,"SD3neg":6.148
    ,"SD2neg":6.877
    ,"SD1neg":7.682
    ,"SD0":8.570
    ,"SD1":9.550
    ,"SD2":10.629
    ,"SD3":11.816
    ,"SD4":13.003
  },
  240 : {
     "Day":240
    ,"SD4neg":5.426
    ,"SD3neg":6.156
    ,"SD2neg":6.885
    ,"SD1neg":7.691
    ,"SD0":8.580
    ,"SD1":9.561
    ,"SD2":10.641
    ,"SD3":11.829
    ,"SD4":13.018
  },
  241 : {
     "Day":241
    ,"SD4neg":5.433
    ,"SD3neg":6.163
    ,"SD2neg":6.893
    ,"SD1neg":7.700
    ,"SD0":8.590
    ,"SD1":9.572
    ,"SD2":10.654
    ,"SD3":11.843
    ,"SD4":13.033
  },
  242 : {
     "Day":242
    ,"SD4neg":5.439
    ,"SD3neg":6.170
    ,"SD2neg":6.901
    ,"SD1neg":7.709
    ,"SD0":8.600
    ,"SD1":9.583
    ,"SD2":10.666
    ,"SD3":11.857
    ,"SD4":13.048
  },
  243 : {
     "Day":243
    ,"SD4neg":5.446
    ,"SD3neg":6.177
    ,"SD2neg":6.909
    ,"SD1neg":7.718
    ,"SD0":8.610
    ,"SD1":9.594
    ,"SD2":10.678
    ,"SD3":11.871
    ,"SD4":13.063
  },
  244 : {
     "Day":244
    ,"SD4neg":5.452
    ,"SD3neg":6.185
    ,"SD2neg":6.917
    ,"SD1neg":7.727
    ,"SD0":8.620
    ,"SD1":9.605
    ,"SD2":10.690
    ,"SD3":11.884
    ,"SD4":13.079
  },
  245 : {
     "Day":245
    ,"SD4neg":5.459
    ,"SD3neg":6.192
    ,"SD2neg":6.925
    ,"SD1neg":7.735
    ,"SD0":8.630
    ,"SD1":9.616
    ,"SD2":10.703
    ,"SD3":11.898
    ,"SD4":13.094
  },
  246 : {
     "Day":246
    ,"SD4neg":5.465
    ,"SD3neg":6.199
    ,"SD2neg":6.933
    ,"SD1neg":7.744
    ,"SD0":8.640
    ,"SD1":9.627
    ,"SD2":10.715
    ,"SD3":11.912
    ,"SD4":13.109
  },
  247 : {
     "Day":247
    ,"SD4neg":5.472
    ,"SD3neg":6.206
    ,"SD2neg":6.941
    ,"SD1neg":7.753
    ,"SD0":8.649
    ,"SD1":9.638
    ,"SD2":10.727
    ,"SD3":11.925
    ,"SD4":13.124
  },
  248 : {
     "Day":248
    ,"SD4neg":5.478
    ,"SD3neg":6.213
    ,"SD2neg":6.949
    ,"SD1neg":7.762
    ,"SD0":8.659
    ,"SD1":9.649
    ,"SD2":10.739
    ,"SD3":11.939
    ,"SD4":13.139
  },
  249 : {
     "Day":249
    ,"SD4neg":5.484
    ,"SD3neg":6.221
    ,"SD2neg":6.957
    ,"SD1neg":7.771
    ,"SD0":8.669
    ,"SD1":9.660
    ,"SD2":10.751
    ,"SD3":11.953
    ,"SD4":13.154
  },
  250 : {
     "Day":250
    ,"SD4neg":5.491
    ,"SD3neg":6.228
    ,"SD2neg":6.965
    ,"SD1neg":7.779
    ,"SD0":8.678
    ,"SD1":9.670
    ,"SD2":10.763
    ,"SD3":11.966
    ,"SD4":13.169
  },
  251 : {
     "Day":251
    ,"SD4neg":5.497
    ,"SD3neg":6.235
    ,"SD2neg":6.973
    ,"SD1neg":7.788
    ,"SD0":8.688
    ,"SD1":9.681
    ,"SD2":10.775
    ,"SD3":11.979
    ,"SD4":13.183
  },
  252 : {
     "Day":252
    ,"SD4neg":5.503
    ,"SD3neg":6.242
    ,"SD2neg":6.980
    ,"SD1neg":7.797
    ,"SD0":8.698
    ,"SD1":9.692
    ,"SD2":10.787
    ,"SD3":11.993
    ,"SD4":13.198
  },
  253 : {
     "Day":253
    ,"SD4neg":5.510
    ,"SD3neg":6.249
    ,"SD2neg":6.988
    ,"SD1neg":7.805
    ,"SD0":8.707
    ,"SD1":9.702
    ,"SD2":10.799
    ,"SD3":12.006
    ,"SD4":13.213
  },
  254 : {
     "Day":254
    ,"SD4neg":5.516
    ,"SD3neg":6.256
    ,"SD2neg":6.996
    ,"SD1neg":7.814
    ,"SD0":8.717
    ,"SD1":9.713
    ,"SD2":10.811
    ,"SD3":12.020
    ,"SD4":13.228
  },
  255 : {
     "Day":255
    ,"SD4neg":5.522
    ,"SD3neg":6.263
    ,"SD2neg":7.003
    ,"SD1neg":7.822
    ,"SD0":8.726
    ,"SD1":9.724
    ,"SD2":10.823
    ,"SD3":12.033
    ,"SD4":13.243
  },
  256 : {
     "Day":256
    ,"SD4neg":5.528
    ,"SD3neg":6.270
    ,"SD2neg":7.011
    ,"SD1neg":7.831
    ,"SD0":8.736
    ,"SD1":9.734
    ,"SD2":10.835
    ,"SD3":12.046
    ,"SD4":13.258
  },
  257 : {
     "Day":257
    ,"SD4neg":5.534
    ,"SD3neg":6.277
    ,"SD2neg":7.019
    ,"SD1neg":7.839
    ,"SD0":8.745
    ,"SD1":9.745
    ,"SD2":10.847
    ,"SD3":12.059
    ,"SD4":13.272
  },
  258 : {
     "Day":258
    ,"SD4neg":5.541
    ,"SD3neg":6.283
    ,"SD2neg":7.026
    ,"SD1neg":7.848
    ,"SD0":8.755
    ,"SD1":9.756
    ,"SD2":10.858
    ,"SD3":12.073
    ,"SD4":13.287
  },
  259 : {
     "Day":259
    ,"SD4neg":5.547
    ,"SD3neg":6.290
    ,"SD2neg":7.034
    ,"SD1neg":7.856
    ,"SD0":8.764
    ,"SD1":9.766
    ,"SD2":10.870
    ,"SD3":12.086
    ,"SD4":13.301
  },
  260 : {
     "Day":260
    ,"SD4neg":5.553
    ,"SD3neg":6.297
    ,"SD2neg":7.042
    ,"SD1neg":7.865
    ,"SD0":8.774
    ,"SD1":9.776
    ,"SD2":10.882
    ,"SD3":12.099
    ,"SD4":13.316
  },
  261 : {
     "Day":261
    ,"SD4neg":5.559
    ,"SD3neg":6.304
    ,"SD2neg":7.049
    ,"SD1neg":7.873
    ,"SD0":8.783
    ,"SD1":9.787
    ,"SD2":10.893
    ,"SD3":12.112
    ,"SD4":13.331
  },
  262 : {
     "Day":262
    ,"SD4neg":5.565
    ,"SD3neg":6.311
    ,"SD2neg":7.057
    ,"SD1neg":7.881
    ,"SD0":8.792
    ,"SD1":9.797
    ,"SD2":10.905
    ,"SD3":12.125
    ,"SD4":13.345
  },
  263 : {
     "Day":263
    ,"SD4neg":5.571
    ,"SD3neg":6.318
    ,"SD2neg":7.064
    ,"SD1neg":7.890
    ,"SD0":8.802
    ,"SD1":9.808
    ,"SD2":10.917
    ,"SD3":12.138
    ,"SD4":13.359
  },
  264 : {
     "Day":264
    ,"SD4neg":5.577
    ,"SD3neg":6.324
    ,"SD2neg":7.072
    ,"SD1neg":7.898
    ,"SD0":8.811
    ,"SD1":9.818
    ,"SD2":10.928
    ,"SD3":12.151
    ,"SD4":13.374
  },
  265 : {
     "Day":265
    ,"SD4neg":5.583
    ,"SD3neg":6.331
    ,"SD2neg":7.079
    ,"SD1neg":7.906
    ,"SD0":8.820
    ,"SD1":9.828
    ,"SD2":10.940
    ,"SD3":12.164
    ,"SD4":13.388
  },
  266 : {
     "Day":266
    ,"SD4neg":5.589
    ,"SD3neg":6.338
    ,"SD2neg":7.087
    ,"SD1neg":7.915
    ,"SD0":8.829
    ,"SD1":9.839
    ,"SD2":10.951
    ,"SD3":12.177
    ,"SD4":13.402
  },
  267 : {
     "Day":267
    ,"SD4neg":5.595
    ,"SD3neg":6.345
    ,"SD2neg":7.094
    ,"SD1neg":7.923
    ,"SD0":8.838
    ,"SD1":9.849
    ,"SD2":10.963
    ,"SD3":12.190
    ,"SD4":13.417
  },
  268 : {
     "Day":268
    ,"SD4neg":5.601
    ,"SD3neg":6.351
    ,"SD2neg":7.101
    ,"SD1neg":7.931
    ,"SD0":8.848
    ,"SD1":9.859
    ,"SD2":10.974
    ,"SD3":12.203
    ,"SD4":13.431
  },
  269 : {
     "Day":269
    ,"SD4neg":5.607
    ,"SD3neg":6.358
    ,"SD2neg":7.109
    ,"SD1neg":7.939
    ,"SD0":8.857
    ,"SD1":9.869
    ,"SD2":10.986
    ,"SD3":12.215
    ,"SD4":13.445
  },
  270 : {
     "Day":270
    ,"SD4neg":5.613
    ,"SD3neg":6.365
    ,"SD2neg":7.116
    ,"SD1neg":7.947
    ,"SD0":8.866
    ,"SD1":9.879
    ,"SD2":10.997
    ,"SD3":12.228
    ,"SD4":13.459
  },
  271 : {
     "Day":271
    ,"SD4neg":5.619
    ,"SD3neg":6.371
    ,"SD2neg":7.123
    ,"SD1neg":7.955
    ,"SD0":8.875
    ,"SD1":9.889
    ,"SD2":11.008
    ,"SD3":12.241
    ,"SD4":13.473
  },
  272 : {
     "Day":272
    ,"SD4neg":5.625
    ,"SD3neg":6.378
    ,"SD2neg":7.131
    ,"SD1neg":7.964
    ,"SD0":8.884
    ,"SD1":9.900
    ,"SD2":11.020
    ,"SD3":12.254
    ,"SD4":13.488
  },
  273 : {
     "Day":273
    ,"SD4neg":5.630
    ,"SD3neg":6.384
    ,"SD2neg":7.138
    ,"SD1neg":7.972
    ,"SD0":8.893
    ,"SD1":9.910
    ,"SD2":11.031
    ,"SD3":12.267
    ,"SD4":13.502
  },
  274 : {
     "Day":274
    ,"SD4neg":5.636
    ,"SD3neg":6.391
    ,"SD2neg":7.145
    ,"SD1neg":7.980
    ,"SD0":8.902
    ,"SD1":9.920
    ,"SD2":11.042
    ,"SD3":12.279
    ,"SD4":13.516
  },
  275 : {
     "Day":275
    ,"SD4neg":5.642
    ,"SD3neg":6.397
    ,"SD2neg":7.153
    ,"SD1neg":7.988
    ,"SD0":8.911
    ,"SD1":9.930
    ,"SD2":11.054
    ,"SD3":12.292
    ,"SD4":13.530
  },
  276 : {
     "Day":276
    ,"SD4neg":5.648
    ,"SD3neg":6.404
    ,"SD2neg":7.160
    ,"SD1neg":7.996
    ,"SD0":8.920
    ,"SD1":9.940
    ,"SD2":11.065
    ,"SD3":12.304
    ,"SD4":13.544
  },
  277 : {
     "Day":277
    ,"SD4neg":5.654
    ,"SD3neg":6.410
    ,"SD2neg":7.167
    ,"SD1neg":8.004
    ,"SD0":8.929
    ,"SD1":9.950
    ,"SD2":11.076
    ,"SD3":12.317
    ,"SD4":13.558
  },
  278 : {
     "Day":278
    ,"SD4neg":5.659
    ,"SD3neg":6.417
    ,"SD2neg":7.174
    ,"SD1neg":8.012
    ,"SD0":8.938
    ,"SD1":9.960
    ,"SD2":11.087
    ,"SD3":12.330
    ,"SD4":13.572
  },
  279 : {
     "Day":279
    ,"SD4neg":5.665
    ,"SD3neg":6.423
    ,"SD2neg":7.181
    ,"SD1neg":8.020
    ,"SD0":8.947
    ,"SD1":9.970
    ,"SD2":11.098
    ,"SD3":12.342
    ,"SD4":13.586
  },
  280 : {
     "Day":280
    ,"SD4neg":5.671
    ,"SD3neg":6.430
    ,"SD2neg":7.188
    ,"SD1neg":8.028
    ,"SD0":8.956
    ,"SD1":9.980
    ,"SD2":11.110
    ,"SD3":12.355
    ,"SD4":13.600
  },
  281 : {
     "Day":281
    ,"SD4neg":5.677
    ,"SD3neg":6.436
    ,"SD2neg":7.196
    ,"SD1neg":8.036
    ,"SD0":8.964
    ,"SD1":9.990
    ,"SD2":11.121
    ,"SD3":12.367
    ,"SD4":13.614
  },
  282 : {
     "Day":282
    ,"SD4neg":5.682
    ,"SD3neg":6.442
    ,"SD2neg":7.203
    ,"SD1neg":8.044
    ,"SD0":8.973
    ,"SD1":10.000
    ,"SD2":11.132
    ,"SD3":12.380
    ,"SD4":13.628
  },
  283 : {
     "Day":283
    ,"SD4neg":5.688
    ,"SD3neg":6.449
    ,"SD2neg":7.210
    ,"SD1neg":8.051
    ,"SD0":8.982
    ,"SD1":10.009
    ,"SD2":11.143
    ,"SD3":12.392
    ,"SD4":13.641
  },
  284 : {
     "Day":284
    ,"SD4neg":5.694
    ,"SD3neg":6.455
    ,"SD2neg":7.217
    ,"SD1neg":8.059
    ,"SD0":8.991
    ,"SD1":10.019
    ,"SD2":11.154
    ,"SD3":12.404
    ,"SD4":13.655
  },
  285 : {
     "Day":285
    ,"SD4neg":5.699
    ,"SD3neg":6.461
    ,"SD2neg":7.224
    ,"SD1neg":8.067
    ,"SD0":9.000
    ,"SD1":10.029
    ,"SD2":11.165
    ,"SD3":12.417
    ,"SD4":13.669
  },
  286 : {
     "Day":286
    ,"SD4neg":5.705
    ,"SD3neg":6.468
    ,"SD2neg":7.231
    ,"SD1neg":8.075
    ,"SD0":9.008
    ,"SD1":10.039
    ,"SD2":11.176
    ,"SD3":12.429
    ,"SD4":13.683
  },
  287 : {
     "Day":287
    ,"SD4neg":5.711
    ,"SD3neg":6.474
    ,"SD2neg":7.238
    ,"SD1neg":8.083
    ,"SD0":9.017
    ,"SD1":10.049
    ,"SD2":11.187
    ,"SD3":12.442
    ,"SD4":13.696
  },
  288 : {
     "Day":288
    ,"SD4neg":5.716
    ,"SD3neg":6.481
    ,"SD2neg":7.245
    ,"SD1neg":8.091
    ,"SD0":9.026
    ,"SD1":10.058
    ,"SD2":11.198
    ,"SD3":12.454
    ,"SD4":13.710
  },
  289 : {
     "Day":289
    ,"SD4neg":5.722
    ,"SD3neg":6.487
    ,"SD2neg":7.252
    ,"SD1neg":8.098
    ,"SD0":9.034
    ,"SD1":10.068
    ,"SD2":11.209
    ,"SD3":12.466
    ,"SD4":13.724
  },
  290 : {
     "Day":290
    ,"SD4neg":5.727
    ,"SD3neg":6.493
    ,"SD2neg":7.259
    ,"SD1neg":8.106
    ,"SD0":9.043
    ,"SD1":10.078
    ,"SD2":11.220
    ,"SD3":12.478
    ,"SD4":13.737
  },
  291 : {
     "Day":291
    ,"SD4neg":5.733
    ,"SD3neg":6.499
    ,"SD2neg":7.266
    ,"SD1neg":8.114
    ,"SD0":9.052
    ,"SD1":10.087
    ,"SD2":11.230
    ,"SD3":12.491
    ,"SD4":13.751
  },
  292 : {
     "Day":292
    ,"SD4neg":5.738
    ,"SD3neg":6.505
    ,"SD2neg":7.272
    ,"SD1neg":8.121
    ,"SD0":9.060
    ,"SD1":10.097
    ,"SD2":11.241
    ,"SD3":12.503
    ,"SD4":13.765
  },
  293 : {
     "Day":293
    ,"SD4neg":5.744
    ,"SD3neg":6.512
    ,"SD2neg":7.279
    ,"SD1neg":8.129
    ,"SD0":9.069
    ,"SD1":10.107
    ,"SD2":11.252
    ,"SD3":12.515
    ,"SD4":13.778
  },
  294 : {
     "Day":294
    ,"SD4neg":5.749
    ,"SD3neg":6.518
    ,"SD2neg":7.286
    ,"SD1neg":8.137
    ,"SD0":9.077
    ,"SD1":10.116
    ,"SD2":11.263
    ,"SD3":12.527
    ,"SD4":13.792
  },
  295 : {
     "Day":295
    ,"SD4neg":5.755
    ,"SD3neg":6.524
    ,"SD2neg":7.293
    ,"SD1neg":8.144
    ,"SD0":9.086
    ,"SD1":10.126
    ,"SD2":11.274
    ,"SD3":12.539
    ,"SD4":13.805
  },
  296 : {
     "Day":296
    ,"SD4neg":5.760
    ,"SD3neg":6.530
    ,"SD2neg":7.300
    ,"SD1neg":8.152
    ,"SD0":9.094
    ,"SD1":10.135
    ,"SD2":11.284
    ,"SD3":12.551
    ,"SD4":13.818
  },
  297 : {
     "Day":297
    ,"SD4neg":5.766
    ,"SD3neg":6.536
    ,"SD2neg":7.307
    ,"SD1neg":8.160
    ,"SD0":9.103
    ,"SD1":10.145
    ,"SD2":11.295
    ,"SD3":12.564
    ,"SD4":13.832
  },
  298 : {
     "Day":298
    ,"SD4neg":5.771
    ,"SD3neg":6.542
    ,"SD2neg":7.314
    ,"SD1neg":8.167
    ,"SD0":9.111
    ,"SD1":10.154
    ,"SD2":11.306
    ,"SD3":12.576
    ,"SD4":13.845
  },
  299 : {
     "Day":299
    ,"SD4neg":5.777
    ,"SD3neg":6.549
    ,"SD2neg":7.321
    ,"SD1neg":8.175
    ,"SD0":9.120
    ,"SD1":10.164
    ,"SD2":11.316
    ,"SD3":12.587
    ,"SD4":13.859
  },
  300 : {
     "Day":300
    ,"SD4neg":5.782
    ,"SD3neg":6.555
    ,"SD2neg":7.327
    ,"SD1neg":8.182
    ,"SD0":9.128
    ,"SD1":10.173
    ,"SD2":11.327
    ,"SD3":12.600
    ,"SD4":13.872
  },
  301 : {
     "Day":301
    ,"SD4neg":5.788
    ,"SD3neg":6.561
    ,"SD2neg":7.334
    ,"SD1neg":8.190
    ,"SD0":9.137
    ,"SD1":10.183
    ,"SD2":11.338
    ,"SD3":12.611
    ,"SD4":13.885
  },
  302 : {
     "Day":302
    ,"SD4neg":5.793
    ,"SD3neg":6.567
    ,"SD2neg":7.341
    ,"SD1neg":8.197
    ,"SD0":9.145
    ,"SD1":10.192
    ,"SD2":11.348
    ,"SD3":12.624
    ,"SD4":13.899
  },
  303 : {
     "Day":303
    ,"SD4neg":5.798
    ,"SD3neg":6.573
    ,"SD2neg":7.347
    ,"SD1neg":8.205
    ,"SD0":9.153
    ,"SD1":10.202
    ,"SD2":11.359
    ,"SD3":12.635
    ,"SD4":13.912
  },
  304 : {
     "Day":304
    ,"SD4neg":5.804
    ,"SD3neg":6.579
    ,"SD2neg":7.354
    ,"SD1neg":8.212
    ,"SD0":9.162
    ,"SD1":10.211
    ,"SD2":11.369
    ,"SD3":12.647
    ,"SD4":13.925
  },
  305 : {
     "Day":305
    ,"SD4neg":5.809
    ,"SD3neg":6.585
    ,"SD2neg":7.361
    ,"SD1neg":8.220
    ,"SD0":9.170
    ,"SD1":10.220
    ,"SD2":11.380
    ,"SD3":12.659
    ,"SD4":13.939
  },
  306 : {
     "Day":306
    ,"SD4neg":5.814
    ,"SD3neg":6.591
    ,"SD2neg":7.368
    ,"SD1neg":8.227
    ,"SD0":9.178
    ,"SD1":10.230
    ,"SD2":11.390
    ,"SD3":12.671
    ,"SD4":13.952
  },
  307 : {
     "Day":307
    ,"SD4neg":5.820
    ,"SD3neg":6.597
    ,"SD2neg":7.374
    ,"SD1neg":8.235
    ,"SD0":9.187
    ,"SD1":10.239
    ,"SD2":11.401
    ,"SD3":12.683
    ,"SD4":13.965
  },
  308 : {
     "Day":308
    ,"SD4neg":5.825
    ,"SD3neg":6.603
    ,"SD2neg":7.381
    ,"SD1neg":8.242
    ,"SD0":9.195
    ,"SD1":10.248
    ,"SD2":11.411
    ,"SD3":12.695
    ,"SD4":13.978
  },
  309 : {
     "Day":309
    ,"SD4neg":5.830
    ,"SD3neg":6.609
    ,"SD2neg":7.387
    ,"SD1neg":8.250
    ,"SD0":9.203
    ,"SD1":10.258
    ,"SD2":11.422
    ,"SD3":12.707
    ,"SD4":13.991
  },
  310 : {
     "Day":310
    ,"SD4neg":5.836
    ,"SD3neg":6.615
    ,"SD2neg":7.394
    ,"SD1neg":8.257
    ,"SD0":9.212
    ,"SD1":10.267
    ,"SD2":11.432
    ,"SD3":12.718
    ,"SD4":14.004
  },
  311 : {
     "Day":311
    ,"SD4neg":5.841
    ,"SD3neg":6.621
    ,"SD2neg":7.401
    ,"SD1neg":8.264
    ,"SD0":9.220
    ,"SD1":10.276
    ,"SD2":11.443
    ,"SD3":12.730
    ,"SD4":14.018
  },
  312 : {
     "Day":312
    ,"SD4neg":5.846
    ,"SD3neg":6.627
    ,"SD2neg":7.407
    ,"SD1neg":8.272
    ,"SD0":9.228
    ,"SD1":10.285
    ,"SD2":11.453
    ,"SD3":12.742
    ,"SD4":14.031
  },
  313 : {
     "Day":313
    ,"SD4neg":5.852
    ,"SD3neg":6.633
    ,"SD2neg":7.414
    ,"SD1neg":8.279
    ,"SD0":9.236
    ,"SD1":10.295
    ,"SD2":11.464
    ,"SD3":12.753
    ,"SD4":14.043
  },
  314 : {
     "Day":314
    ,"SD4neg":5.857
    ,"SD3neg":6.639
    ,"SD2neg":7.420
    ,"SD1neg":8.286
    ,"SD0":9.245
    ,"SD1":10.304
    ,"SD2":11.474
    ,"SD3":12.765
    ,"SD4":14.057
  },
  315 : {
     "Day":315
    ,"SD4neg":5.862
    ,"SD3neg":6.645
    ,"SD2neg":7.427
    ,"SD1neg":8.294
    ,"SD0":9.253
    ,"SD1":10.313
    ,"SD2":11.484
    ,"SD3":12.777
    ,"SD4":14.070
  },
  316 : {
     "Day":316
    ,"SD4neg":5.867
    ,"SD3neg":6.650
    ,"SD2neg":7.434
    ,"SD1neg":8.301
    ,"SD0":9.261
    ,"SD1":10.322
    ,"SD2":11.495
    ,"SD3":12.789
    ,"SD4":14.083
  },
  317 : {
     "Day":317
    ,"SD4neg":5.872
    ,"SD3neg":6.656
    ,"SD2neg":7.440
    ,"SD1neg":8.308
    ,"SD0":9.269
    ,"SD1":10.331
    ,"SD2":11.505
    ,"SD3":12.800
    ,"SD4":14.095
  },
  318 : {
     "Day":318
    ,"SD4neg":5.877
    ,"SD3neg":6.662
    ,"SD2neg":7.447
    ,"SD1neg":8.316
    ,"SD0":9.277
    ,"SD1":10.341
    ,"SD2":11.515
    ,"SD3":12.812
    ,"SD4":14.109
  },
  319 : {
     "Day":319
    ,"SD4neg":5.883
    ,"SD3neg":6.668
    ,"SD2neg":7.453
    ,"SD1neg":8.323
    ,"SD0":9.285
    ,"SD1":10.350
    ,"SD2":11.525
    ,"SD3":12.823
    ,"SD4":14.121
  },
  320 : {
     "Day":320
    ,"SD4neg":5.888
    ,"SD3neg":6.674
    ,"SD2neg":7.460
    ,"SD1neg":8.330
    ,"SD0":9.294
    ,"SD1":10.359
    ,"SD2":11.536
    ,"SD3":12.835
    ,"SD4":14.135
  },
  321 : {
     "Day":321
    ,"SD4neg":5.893
    ,"SD3neg":6.680
    ,"SD2neg":7.466
    ,"SD1neg":8.337
    ,"SD0":9.302
    ,"SD1":10.368
    ,"SD2":11.546
    ,"SD3":12.847
    ,"SD4":14.147
  },
  322 : {
     "Day":322
    ,"SD4neg":5.898
    ,"SD3neg":6.685
    ,"SD2neg":7.473
    ,"SD1neg":8.345
    ,"SD0":9.310
    ,"SD1":10.377
    ,"SD2":11.556
    ,"SD3":12.858
    ,"SD4":14.160
  },
  323 : {
     "Day":323
    ,"SD4neg":5.903
    ,"SD3neg":6.691
    ,"SD2neg":7.479
    ,"SD1neg":8.352
    ,"SD0":9.318
    ,"SD1":10.386
    ,"SD2":11.566
    ,"SD3":12.870
    ,"SD4":14.173
  },
  324 : {
     "Day":324
    ,"SD4neg":5.908
    ,"SD3neg":6.697
    ,"SD2neg":7.485
    ,"SD1neg":8.359
    ,"SD0":9.326
    ,"SD1":10.395
    ,"SD2":11.577
    ,"SD3":12.881
    ,"SD4":14.186
  },
  325 : {
     "Day":325
    ,"SD4neg":5.913
    ,"SD3neg":6.703
    ,"SD2neg":7.492
    ,"SD1neg":8.366
    ,"SD0":9.334
    ,"SD1":10.404
    ,"SD2":11.587
    ,"SD3":12.893
    ,"SD4":14.199
  },
  326 : {
     "Day":326
    ,"SD4neg":5.919
    ,"SD3neg":6.708
    ,"SD2neg":7.498
    ,"SD1neg":8.373
    ,"SD0":9.342
    ,"SD1":10.413
    ,"SD2":11.597
    ,"SD3":12.904
    ,"SD4":14.212
  },
  327 : {
     "Day":327
    ,"SD4neg":5.924
    ,"SD3neg":6.714
    ,"SD2neg":7.505
    ,"SD1neg":8.380
    ,"SD0":9.350
    ,"SD1":10.422
    ,"SD2":11.607
    ,"SD3":12.916
    ,"SD4":14.225
  },
  328 : {
     "Day":328
    ,"SD4neg":5.929
    ,"SD3neg":6.720
    ,"SD2neg":7.511
    ,"SD1neg":8.388
    ,"SD0":9.358
    ,"SD1":10.431
    ,"SD2":11.617
    ,"SD3":12.927
    ,"SD4":14.237
  },
  329 : {
     "Day":329
    ,"SD4neg":5.934
    ,"SD3neg":6.726
    ,"SD2neg":7.517
    ,"SD1neg":8.395
    ,"SD0":9.366
    ,"SD1":10.440
    ,"SD2":11.628
    ,"SD3":12.939
    ,"SD4":14.250
  },
  330 : {
     "Day":330
    ,"SD4neg":5.939
    ,"SD3neg":6.731
    ,"SD2neg":7.524
    ,"SD1neg":8.402
    ,"SD0":9.374
    ,"SD1":10.449
    ,"SD2":11.638
    ,"SD3":12.950
    ,"SD4":14.263
  },
  331 : {
     "Day":331
    ,"SD4neg":5.944
    ,"SD3neg":6.737
    ,"SD2neg":7.530
    ,"SD1neg":8.409
    ,"SD0":9.382
    ,"SD1":10.458
    ,"SD2":11.648
    ,"SD3":12.962
    ,"SD4":14.276
  },
  332 : {
     "Day":332
    ,"SD4neg":5.949
    ,"SD3neg":6.743
    ,"SD2neg":7.537
    ,"SD1neg":8.416
    ,"SD0":9.390
    ,"SD1":10.467
    ,"SD2":11.658
    ,"SD3":12.973
    ,"SD4":14.288
  },
  333 : {
     "Day":333
    ,"SD4neg":5.954
    ,"SD3neg":6.749
    ,"SD2neg":7.543
    ,"SD1neg":8.423
    ,"SD0":9.398
    ,"SD1":10.476
    ,"SD2":11.668
    ,"SD3":12.984
    ,"SD4":14.301
  },
  334 : {
     "Day":334
    ,"SD4neg":5.959
    ,"SD3neg":6.754
    ,"SD2neg":7.549
    ,"SD1neg":8.430
    ,"SD0":9.406
    ,"SD1":10.485
    ,"SD2":11.678
    ,"SD3":12.996
    ,"SD4":14.313
  },
  335 : {
     "Day":335
    ,"SD4neg":5.964
    ,"SD3neg":6.760
    ,"SD2neg":7.556
    ,"SD1neg":8.437
    ,"SD0":9.414
    ,"SD1":10.494
    ,"SD2":11.688
    ,"SD3":13.007
    ,"SD4":14.326
  },
  336 : {
     "Day":336
    ,"SD4neg":5.969
    ,"SD3neg":6.765
    ,"SD2neg":7.562
    ,"SD1neg":8.444
    ,"SD0":9.422
    ,"SD1":10.503
    ,"SD2":11.698
    ,"SD3":13.019
    ,"SD4":14.339
  },
  337 : {
     "Day":337
    ,"SD4neg":5.974
    ,"SD3neg":6.771
    ,"SD2neg":7.568
    ,"SD1neg":8.451
    ,"SD0":9.429
    ,"SD1":10.512
    ,"SD2":11.708
    ,"SD3":13.030
    ,"SD4":14.351
  },
  338 : {
     "Day":338
    ,"SD4neg":5.979
    ,"SD3neg":6.777
    ,"SD2neg":7.574
    ,"SD1neg":8.458
    ,"SD0":9.437
    ,"SD1":10.520
    ,"SD2":11.718
    ,"SD3":13.041
    ,"SD4":14.364
  },
  339 : {
     "Day":339
    ,"SD4neg":5.984
    ,"SD3neg":6.783
    ,"SD2neg":7.581
    ,"SD1neg":8.465
    ,"SD0":9.445
    ,"SD1":10.529
    ,"SD2":11.728
    ,"SD3":13.052
    ,"SD4":14.377
  },
  340 : {
     "Day":340
    ,"SD4neg":5.989
    ,"SD3neg":6.788
    ,"SD2neg":7.587
    ,"SD1neg":8.472
    ,"SD0":9.453
    ,"SD1":10.538
    ,"SD2":11.738
    ,"SD3":13.064
    ,"SD4":14.389
  },
  341 : {
     "Day":341
    ,"SD4neg":5.994
    ,"SD3neg":6.794
    ,"SD2neg":7.593
    ,"SD1neg":8.479
    ,"SD0":9.461
    ,"SD1":10.547
    ,"SD2":11.748
    ,"SD3":13.075
    ,"SD4":14.402
  },
  342 : {
     "Day":342
    ,"SD4neg":5.999
    ,"SD3neg":6.799
    ,"SD2neg":7.600
    ,"SD1neg":8.486
    ,"SD0":9.469
    ,"SD1":10.556
    ,"SD2":11.758
    ,"SD3":13.086
    ,"SD4":14.414
  },
  343 : {
     "Day":343
    ,"SD4neg":6.004
    ,"SD3neg":6.805
    ,"SD2neg":7.606
    ,"SD1neg":8.493
    ,"SD0":9.476
    ,"SD1":10.565
    ,"SD2":11.768
    ,"SD3":13.097
    ,"SD4":14.427
  },
  344 : {
     "Day":344
    ,"SD4neg":6.009
    ,"SD3neg":6.811
    ,"SD2neg":7.612
    ,"SD1neg":8.500
    ,"SD0":9.484
    ,"SD1":10.573
    ,"SD2":11.778
    ,"SD3":13.109
    ,"SD4":14.439
  },
  345 : {
     "Day":345
    ,"SD4neg":6.014
    ,"SD3neg":6.816
    ,"SD2neg":7.618
    ,"SD1neg":8.507
    ,"SD0":9.492
    ,"SD1":10.582
    ,"SD2":11.788
    ,"SD3":13.120
    ,"SD4":14.452
  },
  346 : {
     "Day":346
    ,"SD4neg":6.019
    ,"SD3neg":6.822
    ,"SD2neg":7.624
    ,"SD1neg":8.514
    ,"SD0":9.500
    ,"SD1":10.591
    ,"SD2":11.798
    ,"SD3":13.131
    ,"SD4":14.465
  },
  347 : {
     "Day":347
    ,"SD4neg":6.024
    ,"SD3neg":6.827
    ,"SD2neg":7.631
    ,"SD1neg":8.521
    ,"SD0":9.508
    ,"SD1":10.600
    ,"SD2":11.807
    ,"SD3":13.142
    ,"SD4":14.477
  },
  348 : {
     "Day":348
    ,"SD4neg":6.029
    ,"SD3neg":6.833
    ,"SD2neg":7.637
    ,"SD1neg":8.528
    ,"SD0":9.516
    ,"SD1":10.608
    ,"SD2":11.817
    ,"SD3":13.154
    ,"SD4":14.490
  },
  349 : {
     "Day":349
    ,"SD4neg":6.034
    ,"SD3neg":6.838
    ,"SD2neg":7.643
    ,"SD1neg":8.535
    ,"SD0":9.523
    ,"SD1":10.617
    ,"SD2":11.827
    ,"SD3":13.165
    ,"SD4":14.502
  },
  350 : {
     "Day":350
    ,"SD4neg":6.039
    ,"SD3neg":6.844
    ,"SD2neg":7.649
    ,"SD1neg":8.542
    ,"SD0":9.531
    ,"SD1":10.626
    ,"SD2":11.837
    ,"SD3":13.176
    ,"SD4":14.514
  },
  351 : {
     "Day":351
    ,"SD4neg":6.043
    ,"SD3neg":6.849
    ,"SD2neg":7.655
    ,"SD1neg":8.549
    ,"SD0":9.539
    ,"SD1":10.635
    ,"SD2":11.847
    ,"SD3":13.187
    ,"SD4":14.527
  },
  352 : {
     "Day":352
    ,"SD4neg":6.049
    ,"SD3neg":6.855
    ,"SD2neg":7.661
    ,"SD1neg":8.556
    ,"SD0":9.546
    ,"SD1":10.643
    ,"SD2":11.857
    ,"SD3":13.198
    ,"SD4":14.539
  },
  353 : {
     "Day":353
    ,"SD4neg":6.053
    ,"SD3neg":6.860
    ,"SD2neg":7.668
    ,"SD1neg":8.563
    ,"SD0":9.554
    ,"SD1":10.652
    ,"SD2":11.867
    ,"SD3":13.209
    ,"SD4":14.552
  },
  354 : {
     "Day":354
    ,"SD4neg":6.058
    ,"SD3neg":6.866
    ,"SD2neg":7.674
    ,"SD1neg":8.569
    ,"SD0":9.562
    ,"SD1":10.661
    ,"SD2":11.876
    ,"SD3":13.220
    ,"SD4":14.564
  },
  355 : {
     "Day":355
    ,"SD4neg":6.063
    ,"SD3neg":6.872
    ,"SD2neg":7.680
    ,"SD1neg":8.576
    ,"SD0":9.570
    ,"SD1":10.669
    ,"SD2":11.886
    ,"SD3":13.231
    ,"SD4":14.576
  },
  356 : {
     "Day":356
    ,"SD4neg":6.068
    ,"SD3neg":6.877
    ,"SD2neg":7.686
    ,"SD1neg":8.583
    ,"SD0":9.577
    ,"SD1":10.678
    ,"SD2":11.896
    ,"SD3":13.242
    ,"SD4":14.589
  },
  357 : {
     "Day":357
    ,"SD4neg":6.073
    ,"SD3neg":6.882
    ,"SD2neg":7.692
    ,"SD1neg":8.590
    ,"SD0":9.585
    ,"SD1":10.687
    ,"SD2":11.906
    ,"SD3":13.253
    ,"SD4":14.601
  },
  358 : {
     "Day":358
    ,"SD4neg":6.078
    ,"SD3neg":6.888
    ,"SD2neg":7.698
    ,"SD1neg":8.597
    ,"SD0":9.593
    ,"SD1":10.695
    ,"SD2":11.915
    ,"SD3":13.264
    ,"SD4":14.613
  },
  359 : {
     "Day":359
    ,"SD4neg":6.082
    ,"SD3neg":6.893
    ,"SD2neg":7.704
    ,"SD1neg":8.604
    ,"SD0":9.600
    ,"SD1":10.704
    ,"SD2":11.925
    ,"SD3":13.275
    ,"SD4":14.626
  },
  360 : {
     "Day":360
    ,"SD4neg":6.087
    ,"SD3neg":6.899
    ,"SD2neg":7.710
    ,"SD1neg":8.610
    ,"SD0":9.608
    ,"SD1":10.713
    ,"SD2":11.935
    ,"SD3":13.287
    ,"SD4":14.638
  },
  361 : {
     "Day":361
    ,"SD4neg":6.092
    ,"SD3neg":6.904
    ,"SD2neg":7.716
    ,"SD1neg":8.617
    ,"SD0":9.616
    ,"SD1":10.721
    ,"SD2":11.944
    ,"SD3":13.297
    ,"SD4":14.650
  },
  362 : {
     "Day":362
    ,"SD4neg":6.097
    ,"SD3neg":6.910
    ,"SD2neg":7.722
    ,"SD1neg":8.624
    ,"SD0":9.623
    ,"SD1":10.730
    ,"SD2":11.954
    ,"SD3":13.308
    ,"SD4":14.663
  },
  363 : {
     "Day":363
    ,"SD4neg":6.102
    ,"SD3neg":6.915
    ,"SD2neg":7.729
    ,"SD1neg":8.631
    ,"SD0":9.631
    ,"SD1":10.738
    ,"SD2":11.964
    ,"SD3":13.320
    ,"SD4":14.675
  },
  364 : {
     "Day":364
    ,"SD4neg":6.106
    ,"SD3neg":6.920
    ,"SD2neg":7.735
    ,"SD1neg":8.638
    ,"SD0":9.638
    ,"SD1":10.747
    ,"SD2":11.974
    ,"SD3":13.331
    ,"SD4":14.688
  },
  365 : {
     "Day":365
    ,"SD4neg":6.111
    ,"SD3neg":6.926
    ,"SD2neg":7.741
    ,"SD1neg":8.644
    ,"SD0":9.646
    ,"SD1":10.755
    ,"SD2":11.983
    ,"SD3":13.341
    ,"SD4":14.700
  },
  366 : {
     "Day":366
    ,"SD4neg":6.116
    ,"SD3neg":6.931
    ,"SD2neg":7.747
    ,"SD1neg":8.651
    ,"SD0":9.654
    ,"SD1":10.764
    ,"SD2":11.993
    ,"SD3":13.352
    ,"SD4":14.712
  },
  367 : {
     "Day":367
    ,"SD4neg":6.121
    ,"SD3neg":6.937
    ,"SD2neg":7.753
    ,"SD1neg":8.658
    ,"SD0":9.661
    ,"SD1":10.773
    ,"SD2":12.003
    ,"SD3":13.363
    ,"SD4":14.724
  },
  368 : {
     "Day":368
    ,"SD4neg":6.126
    ,"SD3neg":6.942
    ,"SD2neg":7.759
    ,"SD1neg":8.665
    ,"SD0":9.669
    ,"SD1":10.781
    ,"SD2":12.012
    ,"SD3":13.374
    ,"SD4":14.736
  },
  369 : {
     "Day":369
    ,"SD4neg":6.130
    ,"SD3neg":6.948
    ,"SD2neg":7.765
    ,"SD1neg":8.671
    ,"SD0":9.676
    ,"SD1":10.790
    ,"SD2":12.022
    ,"SD3":13.385
    ,"SD4":14.749
  },
  370 : {
     "Day":370
    ,"SD4neg":6.135
    ,"SD3neg":6.953
    ,"SD2neg":7.771
    ,"SD1neg":8.678
    ,"SD0":9.684
    ,"SD1":10.798
    ,"SD2":12.032
    ,"SD3":13.396
    ,"SD4":14.761
  },
  371 : {
     "Day":371
    ,"SD4neg":6.140
    ,"SD3neg":6.958
    ,"SD2neg":7.777
    ,"SD1neg":8.685
    ,"SD0":9.691
    ,"SD1":10.807
    ,"SD2":12.041
    ,"SD3":13.407
    ,"SD4":14.773
  },
  372 : {
     "Day":372
    ,"SD4neg":6.145
    ,"SD3neg":6.964
    ,"SD2neg":7.783
    ,"SD1neg":8.691
    ,"SD0":9.699
    ,"SD1":10.815
    ,"SD2":12.051
    ,"SD3":13.418
    ,"SD4":14.785
  },
  373 : {
     "Day":373
    ,"SD4neg":6.149
    ,"SD3neg":6.969
    ,"SD2neg":7.789
    ,"SD1neg":8.698
    ,"SD0":9.706
    ,"SD1":10.824
    ,"SD2":12.060
    ,"SD3":13.429
    ,"SD4":14.797
  },
  374 : {
     "Day":374
    ,"SD4neg":6.154
    ,"SD3neg":6.974
    ,"SD2neg":7.795
    ,"SD1neg":8.705
    ,"SD0":9.714
    ,"SD1":10.832
    ,"SD2":12.070
    ,"SD3":13.440
    ,"SD4":14.810
  },
  375 : {
     "Day":375
    ,"SD4neg":6.158
    ,"SD3neg":6.979
    ,"SD2neg":7.800
    ,"SD1neg":8.711
    ,"SD0":9.721
    ,"SD1":10.841
    ,"SD2":12.080
    ,"SD3":13.451
    ,"SD4":14.822
  },
  376 : {
     "Day":376
    ,"SD4neg":6.163
    ,"SD3neg":6.985
    ,"SD2neg":7.807
    ,"SD1neg":8.718
    ,"SD0":9.729
    ,"SD1":10.849
    ,"SD2":12.089
    ,"SD3":13.461
    ,"SD4":14.834
  },
  377 : {
     "Day":377
    ,"SD4neg":6.168
    ,"SD3neg":6.990
    ,"SD2neg":7.812
    ,"SD1neg":8.725
    ,"SD0":9.736
    ,"SD1":10.857
    ,"SD2":12.099
    ,"SD3":13.472
    ,"SD4":14.846
  },
  378 : {
     "Day":378
    ,"SD4neg":6.173
    ,"SD3neg":6.995
    ,"SD2neg":7.818
    ,"SD1neg":8.731
    ,"SD0":9.744
    ,"SD1":10.866
    ,"SD2":12.108
    ,"SD3":13.483
    ,"SD4":14.858
  },
  379 : {
     "Day":379
    ,"SD4neg":6.177
    ,"SD3neg":7.001
    ,"SD2neg":7.824
    ,"SD1neg":8.738
    ,"SD0":9.751
    ,"SD1":10.874
    ,"SD2":12.118
    ,"SD3":13.494
    ,"SD4":14.871
  },
  380 : {
     "Day":380
    ,"SD4neg":6.182
    ,"SD3neg":7.006
    ,"SD2neg":7.830
    ,"SD1neg":8.745
    ,"SD0":9.759
    ,"SD1":10.883
    ,"SD2":12.127
    ,"SD3":13.505
    ,"SD4":14.882
  },
  381 : {
     "Day":381
    ,"SD4neg":6.187
    ,"SD3neg":7.011
    ,"SD2neg":7.836
    ,"SD1neg":8.751
    ,"SD0":9.766
    ,"SD1":10.891
    ,"SD2":12.137
    ,"SD3":13.516
    ,"SD4":14.894
  },
  382 : {
     "Day":382
    ,"SD4neg":6.191
    ,"SD3neg":7.017
    ,"SD2neg":7.842
    ,"SD1neg":8.758
    ,"SD0":9.774
    ,"SD1":10.900
    ,"SD2":12.147
    ,"SD3":13.527
    ,"SD4":14.907
  },
  383 : {
     "Day":383
    ,"SD4neg":6.196
    ,"SD3neg":7.022
    ,"SD2neg":7.848
    ,"SD1neg":8.765
    ,"SD0":9.781
    ,"SD1":10.908
    ,"SD2":12.156
    ,"SD3":13.537
    ,"SD4":14.919
  },
  384 : {
     "Day":384
    ,"SD4neg":6.201
    ,"SD3neg":7.027
    ,"SD2neg":7.854
    ,"SD1neg":8.771
    ,"SD0":9.789
    ,"SD1":10.916
    ,"SD2":12.165
    ,"SD3":13.548
    ,"SD4":14.930
  },
  385 : {
     "Day":385
    ,"SD4neg":6.205
    ,"SD3neg":7.033
    ,"SD2neg":7.860
    ,"SD1neg":8.778
    ,"SD0":9.796
    ,"SD1":10.925
    ,"SD2":12.175
    ,"SD3":13.559
    ,"SD4":14.943
  },
  386 : {
     "Day":386
    ,"SD4neg":6.210
    ,"SD3neg":7.038
    ,"SD2neg":7.866
    ,"SD1neg":8.784
    ,"SD0":9.804
    ,"SD1":10.933
    ,"SD2":12.184
    ,"SD3":13.570
    ,"SD4":14.955
  },
  387 : {
     "Day":387
    ,"SD4neg":6.215
    ,"SD3neg":7.043
    ,"SD2neg":7.871
    ,"SD1neg":8.791
    ,"SD0":9.811
    ,"SD1":10.942
    ,"SD2":12.194
    ,"SD3":13.581
    ,"SD4":14.967
  },
  388 : {
     "Day":388
    ,"SD4neg":6.219
    ,"SD3neg":7.048
    ,"SD2neg":7.877
    ,"SD1neg":8.797
    ,"SD0":9.818
    ,"SD1":10.950
    ,"SD2":12.204
    ,"SD3":13.591
    ,"SD4":14.979
  },
  389 : {
     "Day":389
    ,"SD4neg":6.224
    ,"SD3neg":7.054
    ,"SD2neg":7.883
    ,"SD1neg":8.804
    ,"SD0":9.826
    ,"SD1":10.958
    ,"SD2":12.213
    ,"SD3":13.602
    ,"SD4":14.991
  },
  390 : {
     "Day":390
    ,"SD4neg":6.229
    ,"SD3neg":7.059
    ,"SD2neg":7.889
    ,"SD1neg":8.811
    ,"SD0":9.833
    ,"SD1":10.966
    ,"SD2":12.222
    ,"SD3":13.612
    ,"SD4":15.003
  },
  391 : {
     "Day":391
    ,"SD4neg":6.233
    ,"SD3neg":7.064
    ,"SD2neg":7.895
    ,"SD1neg":8.817
    ,"SD0":9.840
    ,"SD1":10.975
    ,"SD2":12.232
    ,"SD3":13.623
    ,"SD4":15.015
  },
  392 : {
     "Day":392
    ,"SD4neg":6.238
    ,"SD3neg":7.069
    ,"SD2neg":7.901
    ,"SD1neg":8.824
    ,"SD0":9.848
    ,"SD1":10.983
    ,"SD2":12.241
    ,"SD3":13.634
    ,"SD4":15.027
  },
  393 : {
     "Day":393
    ,"SD4neg":6.242
    ,"SD3neg":7.074
    ,"SD2neg":7.906
    ,"SD1neg":8.830
    ,"SD0":9.855
    ,"SD1":10.991
    ,"SD2":12.251
    ,"SD3":13.645
    ,"SD4":15.039
  },
  394 : {
     "Day":394
    ,"SD4neg":6.247
    ,"SD3neg":7.079
    ,"SD2neg":7.912
    ,"SD1neg":8.837
    ,"SD0":9.862
    ,"SD1":11.000
    ,"SD2":12.260
    ,"SD3":13.656
    ,"SD4":15.051
  },
  395 : {
     "Day":395
    ,"SD4neg":6.252
    ,"SD3neg":7.085
    ,"SD2neg":7.918
    ,"SD1neg":8.843
    ,"SD0":9.870
    ,"SD1":11.008
    ,"SD2":12.269
    ,"SD3":13.666
    ,"SD4":15.063
  },
  396 : {
     "Day":396
    ,"SD4neg":6.256
    ,"SD3neg":7.090
    ,"SD2neg":7.924
    ,"SD1neg":8.850
    ,"SD0":9.877
    ,"SD1":11.016
    ,"SD2":12.279
    ,"SD3":13.677
    ,"SD4":15.075
  },
  397 : {
     "Day":397
    ,"SD4neg":6.261
    ,"SD3neg":7.095
    ,"SD2neg":7.930
    ,"SD1neg":8.856
    ,"SD0":9.884
    ,"SD1":11.025
    ,"SD2":12.288
    ,"SD3":13.687
    ,"SD4":15.087
  },
  398 : {
     "Day":398
    ,"SD4neg":6.265
    ,"SD3neg":7.100
    ,"SD2neg":7.935
    ,"SD1neg":8.863
    ,"SD0":9.892
    ,"SD1":11.033
    ,"SD2":12.298
    ,"SD3":13.698
    ,"SD4":15.099
  },
  399 : {
     "Day":399
    ,"SD4neg":6.270
    ,"SD3neg":7.105
    ,"SD2neg":7.941
    ,"SD1neg":8.869
    ,"SD0":9.899
    ,"SD1":11.041
    ,"SD2":12.307
    ,"SD3":13.709
    ,"SD4":15.111
  },
  400 : {
     "Day":400
    ,"SD4neg":6.274
    ,"SD3neg":7.111
    ,"SD2neg":7.947
    ,"SD1neg":8.876
    ,"SD0":9.906
    ,"SD1":11.050
    ,"SD2":12.316
    ,"SD3":13.720
    ,"SD4":15.123
  },
  401 : {
     "Day":401
    ,"SD4neg":6.279
    ,"SD3neg":7.116
    ,"SD2neg":7.953
    ,"SD1neg":8.882
    ,"SD0":9.914
    ,"SD1":11.058
    ,"SD2":12.326
    ,"SD3":13.730
    ,"SD4":15.135
  },
  402 : {
     "Day":402
    ,"SD4neg":6.283
    ,"SD3neg":7.121
    ,"SD2neg":7.959
    ,"SD1neg":8.889
    ,"SD0":9.921
    ,"SD1":11.066
    ,"SD2":12.335
    ,"SD3":13.741
    ,"SD4":15.146
  },
  403 : {
     "Day":403
    ,"SD4neg":6.288
    ,"SD3neg":7.126
    ,"SD2neg":7.964
    ,"SD1neg":8.895
    ,"SD0":9.928
    ,"SD1":11.074
    ,"SD2":12.344
    ,"SD3":13.751
    ,"SD4":15.158
  },
  404 : {
     "Day":404
    ,"SD4neg":6.292
    ,"SD3neg":7.131
    ,"SD2neg":7.970
    ,"SD1neg":8.902
    ,"SD0":9.936
    ,"SD1":11.083
    ,"SD2":12.354
    ,"SD3":13.762
    ,"SD4":15.170
  },
  405 : {
     "Day":405
    ,"SD4neg":6.297
    ,"SD3neg":7.136
    ,"SD2neg":7.976
    ,"SD1neg":8.908
    ,"SD0":9.943
    ,"SD1":11.091
    ,"SD2":12.363
    ,"SD3":13.773
    ,"SD4":15.182
  },
  406 : {
     "Day":406
    ,"SD4neg":6.301
    ,"SD3neg":7.141
    ,"SD2neg":7.982
    ,"SD1neg":8.915
    ,"SD0":9.950
    ,"SD1":11.099
    ,"SD2":12.372
    ,"SD3":13.783
    ,"SD4":15.194
  },
  407 : {
     "Day":407
    ,"SD4neg":6.306
    ,"SD3neg":7.147
    ,"SD2neg":7.987
    ,"SD1neg":8.921
    ,"SD0":9.958
    ,"SD1":11.107
    ,"SD2":12.382
    ,"SD3":13.794
    ,"SD4":15.206
  },
  408 : {
     "Day":408
    ,"SD4neg":6.310
    ,"SD3neg":7.152
    ,"SD2neg":7.993
    ,"SD1neg":8.927
    ,"SD0":9.965
    ,"SD1":11.115
    ,"SD2":12.391
    ,"SD3":13.805
    ,"SD4":15.218
  },
  409 : {
     "Day":409
    ,"SD4neg":6.315
    ,"SD3neg":7.157
    ,"SD2neg":7.999
    ,"SD1neg":8.934
    ,"SD0":9.972
    ,"SD1":11.124
    ,"SD2":12.401
    ,"SD3":13.815
    ,"SD4":15.230
  },
  410 : {
     "Day":410
    ,"SD4neg":6.319
    ,"SD3neg":7.162
    ,"SD2neg":8.005
    ,"SD1neg":8.940
    ,"SD0":9.979
    ,"SD1":11.132
    ,"SD2":12.410
    ,"SD3":13.826
    ,"SD4":15.241
  },
  411 : {
     "Day":411
    ,"SD4neg":6.324
    ,"SD3neg":7.167
    ,"SD2neg":8.010
    ,"SD1neg":8.947
    ,"SD0":9.986
    ,"SD1":11.140
    ,"SD2":12.419
    ,"SD3":13.836
    ,"SD4":15.254
  },
  412 : {
     "Day":412
    ,"SD4neg":6.328
    ,"SD3neg":7.172
    ,"SD2neg":8.016
    ,"SD1neg":8.953
    ,"SD0":9.994
    ,"SD1":11.148
    ,"SD2":12.428
    ,"SD3":13.847
    ,"SD4":15.265
  },
  413 : {
     "Day":413
    ,"SD4neg":6.333
    ,"SD3neg":7.177
    ,"SD2neg":8.022
    ,"SD1neg":8.960
    ,"SD0":10.001
    ,"SD1":11.156
    ,"SD2":12.438
    ,"SD3":13.857
    ,"SD4":15.277
  },
  414 : {
     "Day":414
    ,"SD4neg":6.337
    ,"SD3neg":7.182
    ,"SD2neg":8.027
    ,"SD1neg":8.966
    ,"SD0":10.008
    ,"SD1":11.165
    ,"SD2":12.447
    ,"SD3":13.868
    ,"SD4":15.289
  },
  415 : {
     "Day":415
    ,"SD4neg":6.342
    ,"SD3neg":7.187
    ,"SD2neg":8.033
    ,"SD1neg":8.972
    ,"SD0":10.015
    ,"SD1":11.173
    ,"SD2":12.456
    ,"SD3":13.879
    ,"SD4":15.301
  },
  416 : {
     "Day":416
    ,"SD4neg":6.346
    ,"SD3neg":7.192
    ,"SD2neg":8.039
    ,"SD1neg":8.979
    ,"SD0":10.023
    ,"SD1":11.181
    ,"SD2":12.465
    ,"SD3":13.889
    ,"SD4":15.313
  },
  417 : {
     "Day":417
    ,"SD4neg":6.351
    ,"SD3neg":7.198
    ,"SD2neg":8.044
    ,"SD1neg":8.985
    ,"SD0":10.030
    ,"SD1":11.189
    ,"SD2":12.475
    ,"SD3":13.900
    ,"SD4":15.325
  },
  418 : {
     "Day":418
    ,"SD4neg":6.355
    ,"SD3neg":7.203
    ,"SD2neg":8.050
    ,"SD1neg":8.992
    ,"SD0":10.037
    ,"SD1":11.197
    ,"SD2":12.484
    ,"SD3":13.910
    ,"SD4":15.337
  },
  419 : {
     "Day":419
    ,"SD4neg":6.360
    ,"SD3neg":7.208
    ,"SD2neg":8.056
    ,"SD1neg":8.998
    ,"SD0":10.044
    ,"SD1":11.205
    ,"SD2":12.493
    ,"SD3":13.921
    ,"SD4":15.349
  },
  420 : {
     "Day":420
    ,"SD4neg":6.364
    ,"SD3neg":7.213
    ,"SD2neg":8.061
    ,"SD1neg":9.004
    ,"SD0":10.051
    ,"SD1":11.214
    ,"SD2":12.503
    ,"SD3":13.932
    ,"SD4":15.360
  },
  421 : {
     "Day":421
    ,"SD4neg":6.369
    ,"SD3neg":7.218
    ,"SD2neg":8.067
    ,"SD1neg":9.011
    ,"SD0":10.059
    ,"SD1":11.222
    ,"SD2":12.512
    ,"SD3":13.942
    ,"SD4":15.372
  },
  422 : {
     "Day":422
    ,"SD4neg":6.373
    ,"SD3neg":7.223
    ,"SD2neg":8.073
    ,"SD1neg":9.017
    ,"SD0":10.066
    ,"SD1":11.230
    ,"SD2":12.521
    ,"SD3":13.952
    ,"SD4":15.383
  },
  423 : {
     "Day":423
    ,"SD4neg":6.377
    ,"SD3neg":7.228
    ,"SD2neg":8.078
    ,"SD1neg":9.023
    ,"SD0":10.073
    ,"SD1":11.238
    ,"SD2":12.530
    ,"SD3":13.963
    ,"SD4":15.395
  },
  424 : {
     "Day":424
    ,"SD4neg":6.382
    ,"SD3neg":7.233
    ,"SD2neg":8.084
    ,"SD1neg":9.030
    ,"SD0":10.080
    ,"SD1":11.246
    ,"SD2":12.539
    ,"SD3":13.973
    ,"SD4":15.407
  },
  425 : {
     "Day":425
    ,"SD4neg":6.386
    ,"SD3neg":7.238
    ,"SD2neg":8.090
    ,"SD1neg":9.036
    ,"SD0":10.087
    ,"SD1":11.254
    ,"SD2":12.548
    ,"SD3":13.984
    ,"SD4":15.419
  },
  426 : {
     "Day":426
    ,"SD4neg":6.391
    ,"SD3neg":7.243
    ,"SD2neg":8.095
    ,"SD1neg":9.042
    ,"SD0":10.094
    ,"SD1":11.262
    ,"SD2":12.558
    ,"SD3":13.994
    ,"SD4":15.431
  },
  427 : {
     "Day":427
    ,"SD4neg":6.395
    ,"SD3neg":7.248
    ,"SD2neg":8.101
    ,"SD1neg":9.049
    ,"SD0":10.102
    ,"SD1":11.270
    ,"SD2":12.567
    ,"SD3":14.005
    ,"SD4":15.443
  },
  428 : {
     "Day":428
    ,"SD4neg":6.399
    ,"SD3neg":7.253
    ,"SD2neg":8.107
    ,"SD1neg":9.055
    ,"SD0":10.109
    ,"SD1":11.278
    ,"SD2":12.576
    ,"SD3":14.015
    ,"SD4":15.454
  },
  429 : {
     "Day":429
    ,"SD4neg":6.404
    ,"SD3neg":7.258
    ,"SD2neg":8.112
    ,"SD1neg":9.061
    ,"SD0":10.116
    ,"SD1":11.286
    ,"SD2":12.585
    ,"SD3":14.026
    ,"SD4":15.466
  },
  430 : {
     "Day":430
    ,"SD4neg":6.408
    ,"SD3neg":7.263
    ,"SD2neg":8.118
    ,"SD1neg":9.068
    ,"SD0":10.123
    ,"SD1":11.295
    ,"SD2":12.595
    ,"SD3":14.036
    ,"SD4":15.478
  },
  431 : {
     "Day":431
    ,"SD4neg":6.413
    ,"SD3neg":7.268
    ,"SD2neg":8.123
    ,"SD1neg":9.074
    ,"SD0":10.130
    ,"SD1":11.303
    ,"SD2":12.604
    ,"SD3":14.047
    ,"SD4":15.490
  },
  432 : {
     "Day":432
    ,"SD4neg":6.417
    ,"SD3neg":7.273
    ,"SD2neg":8.129
    ,"SD1neg":9.080
    ,"SD0":10.137
    ,"SD1":11.311
    ,"SD2":12.613
    ,"SD3":14.057
    ,"SD4":15.502
  },
  433 : {
     "Day":433
    ,"SD4neg":6.421
    ,"SD3neg":7.278
    ,"SD2neg":8.134
    ,"SD1neg":9.087
    ,"SD0":10.144
    ,"SD1":11.319
    ,"SD2":12.622
    ,"SD3":14.068
    ,"SD4":15.513
  },
  434 : {
     "Day":434
    ,"SD4neg":6.426
    ,"SD3neg":7.283
    ,"SD2neg":8.140
    ,"SD1neg":9.093
    ,"SD0":10.152
    ,"SD1":11.327
    ,"SD2":12.631
    ,"SD3":14.078
    ,"SD4":15.525
  },
  435 : {
     "Day":435
    ,"SD4neg":6.430
    ,"SD3neg":7.288
    ,"SD2neg":8.146
    ,"SD1neg":9.099
    ,"SD0":10.159
    ,"SD1":11.335
    ,"SD2":12.641
    ,"SD3":14.089
    ,"SD4":15.537
  },
  436 : {
     "Day":436
    ,"SD4neg":6.435
    ,"SD3neg":7.293
    ,"SD2neg":8.151
    ,"SD1neg":9.106
    ,"SD0":10.166
    ,"SD1":11.343
    ,"SD2":12.650
    ,"SD3":14.099
    ,"SD4":15.549
  },
  437 : {
     "Day":437
    ,"SD4neg":6.439
    ,"SD3neg":7.298
    ,"SD2neg":8.157
    ,"SD1neg":9.112
    ,"SD0":10.173
    ,"SD1":11.351
    ,"SD2":12.659
    ,"SD3":14.110
    ,"SD4":15.560
  },
  438 : {
     "Day":438
    ,"SD4neg":6.443
    ,"SD3neg":7.303
    ,"SD2neg":8.162
    ,"SD1neg":9.118
    ,"SD0":10.180
    ,"SD1":11.359
    ,"SD2":12.668
    ,"SD3":14.120
    ,"SD4":15.572
  },
  439 : {
     "Day":439
    ,"SD4neg":6.448
    ,"SD3neg":7.308
    ,"SD2neg":8.168
    ,"SD1neg":9.124
    ,"SD0":10.187
    ,"SD1":11.367
    ,"SD2":12.677
    ,"SD3":14.130
    ,"SD4":15.584
  },
  440 : {
     "Day":440
    ,"SD4neg":6.452
    ,"SD3neg":7.313
    ,"SD2neg":8.174
    ,"SD1neg":9.131
    ,"SD0":10.194
    ,"SD1":11.375
    ,"SD2":12.686
    ,"SD3":14.141
    ,"SD4":15.596
  },
  441 : {
     "Day":441
    ,"SD4neg":6.456
    ,"SD3neg":7.318
    ,"SD2neg":8.179
    ,"SD1neg":9.137
    ,"SD0":10.201
    ,"SD1":11.383
    ,"SD2":12.695
    ,"SD3":14.151
    ,"SD4":15.607
  },
  442 : {
     "Day":442
    ,"SD4neg":6.461
    ,"SD3neg":7.323
    ,"SD2neg":8.185
    ,"SD1neg":9.143
    ,"SD0":10.208
    ,"SD1":11.391
    ,"SD2":12.704
    ,"SD3":14.162
    ,"SD4":15.619
  },
  443 : {
     "Day":443
    ,"SD4neg":6.465
    ,"SD3neg":7.328
    ,"SD2neg":8.190
    ,"SD1neg":9.149
    ,"SD0":10.215
    ,"SD1":11.399
    ,"SD2":12.714
    ,"SD3":14.172
    ,"SD4":15.631
  },
  444 : {
     "Day":444
    ,"SD4neg":6.469
    ,"SD3neg":7.333
    ,"SD2neg":8.196
    ,"SD1neg":9.156
    ,"SD0":10.222
    ,"SD1":11.407
    ,"SD2":12.723
    ,"SD3":14.183
    ,"SD4":15.642
  },
  445 : {
     "Day":445
    ,"SD4neg":6.474
    ,"SD3neg":7.337
    ,"SD2neg":8.201
    ,"SD1neg":9.162
    ,"SD0":10.229
    ,"SD1":11.415
    ,"SD2":12.732
    ,"SD3":14.193
    ,"SD4":15.654
  },
  446 : {
     "Day":446
    ,"SD4neg":6.478
    ,"SD3neg":7.342
    ,"SD2neg":8.207
    ,"SD1neg":9.168
    ,"SD0":10.236
    ,"SD1":11.423
    ,"SD2":12.741
    ,"SD3":14.203
    ,"SD4":15.666
  },
  447 : {
     "Day":447
    ,"SD4neg":6.482
    ,"SD3neg":7.347
    ,"SD2neg":8.212
    ,"SD1neg":9.174
    ,"SD0":10.244
    ,"SD1":11.431
    ,"SD2":12.750
    ,"SD3":14.214
    ,"SD4":15.677
  },
  448 : {
     "Day":448
    ,"SD4neg":6.487
    ,"SD3neg":7.352
    ,"SD2neg":8.218
    ,"SD1neg":9.181
    ,"SD0":10.251
    ,"SD1":11.439
    ,"SD2":12.759
    ,"SD3":14.224
    ,"SD4":15.689
  },
  449 : {
     "Day":449
    ,"SD4neg":6.491
    ,"SD3neg":7.357
    ,"SD2neg":8.223
    ,"SD1neg":9.187
    ,"SD0":10.258
    ,"SD1":11.447
    ,"SD2":12.768
    ,"SD3":14.234
    ,"SD4":15.701
  },
  450 : {
     "Day":450
    ,"SD4neg":6.495
    ,"SD3neg":7.362
    ,"SD2neg":8.229
    ,"SD1neg":9.193
    ,"SD0":10.265
    ,"SD1":11.455
    ,"SD2":12.777
    ,"SD3":14.245
    ,"SD4":15.712
  },
  451 : {
     "Day":451
    ,"SD4neg":6.500
    ,"SD3neg":7.367
    ,"SD2neg":8.235
    ,"SD1neg":9.199
    ,"SD0":10.272
    ,"SD1":11.463
    ,"SD2":12.786
    ,"SD3":14.255
    ,"SD4":15.724
  },
  452 : {
     "Day":452
    ,"SD4neg":6.504
    ,"SD3neg":7.372
    ,"SD2neg":8.240
    ,"SD1neg":9.206
    ,"SD0":10.279
    ,"SD1":11.471
    ,"SD2":12.796
    ,"SD3":14.266
    ,"SD4":15.736
  },
  453 : {
     "Day":453
    ,"SD4neg":6.508
    ,"SD3neg":7.377
    ,"SD2neg":8.246
    ,"SD1neg":9.212
    ,"SD0":10.286
    ,"SD1":11.479
    ,"SD2":12.805
    ,"SD3":14.276
    ,"SD4":15.747
  },
  454 : {
     "Day":454
    ,"SD4neg":6.512
    ,"SD3neg":7.382
    ,"SD2neg":8.251
    ,"SD1neg":9.218
    ,"SD0":10.293
    ,"SD1":11.487
    ,"SD2":12.814
    ,"SD3":14.287
    ,"SD4":15.760
  },
  455 : {
     "Day":455
    ,"SD4neg":6.517
    ,"SD3neg":7.386
    ,"SD2neg":8.256
    ,"SD1neg":9.224
    ,"SD0":10.300
    ,"SD1":11.495
    ,"SD2":12.823
    ,"SD3":14.297
    ,"SD4":15.771
  },
  456 : {
     "Day":456
    ,"SD4neg":6.521
    ,"SD3neg":7.391
    ,"SD2neg":8.262
    ,"SD1neg":9.230
    ,"SD0":10.307
    ,"SD1":11.503
    ,"SD2":12.832
    ,"SD3":14.308
    ,"SD4":15.783
  },
  457 : {
     "Day":457
    ,"SD4neg":6.525
    ,"SD3neg":7.396
    ,"SD2neg":8.267
    ,"SD1neg":9.236
    ,"SD0":10.314
    ,"SD1":11.511
    ,"SD2":12.841
    ,"SD3":14.318
    ,"SD4":15.794
  },
  458 : {
     "Day":458
    ,"SD4neg":6.529
    ,"SD3neg":7.401
    ,"SD2neg":8.273
    ,"SD1neg":9.243
    ,"SD0":10.321
    ,"SD1":11.519
    ,"SD2":12.850
    ,"SD3":14.328
    ,"SD4":15.806
  },
  459 : {
     "Day":459
    ,"SD4neg":6.534
    ,"SD3neg":7.406
    ,"SD2neg":8.278
    ,"SD1neg":9.249
    ,"SD0":10.328
    ,"SD1":11.527
    ,"SD2":12.859
    ,"SD3":14.339
    ,"SD4":15.818
  },
  460 : {
     "Day":460
    ,"SD4neg":6.538
    ,"SD3neg":7.411
    ,"SD2neg":8.284
    ,"SD1neg":9.255
    ,"SD0":10.335
    ,"SD1":11.535
    ,"SD2":12.868
    ,"SD3":14.349
    ,"SD4":15.829
  },
  461 : {
     "Day":461
    ,"SD4neg":6.542
    ,"SD3neg":7.416
    ,"SD2neg":8.289
    ,"SD1neg":9.261
    ,"SD0":10.342
    ,"SD1":11.543
    ,"SD2":12.877
    ,"SD3":14.359
    ,"SD4":15.841
  },
  462 : {
     "Day":462
    ,"SD4neg":6.547
    ,"SD3neg":7.421
    ,"SD2neg":8.295
    ,"SD1neg":9.267
    ,"SD0":10.349
    ,"SD1":11.551
    ,"SD2":12.886
    ,"SD3":14.369
    ,"SD4":15.853
  },
  463 : {
     "Day":463
    ,"SD4neg":6.551
    ,"SD3neg":7.426
    ,"SD2neg":8.300
    ,"SD1neg":9.274
    ,"SD0":10.356
    ,"SD1":11.559
    ,"SD2":12.895
    ,"SD3":14.380
    ,"SD4":15.864
  },
  464 : {
     "Day":464
    ,"SD4neg":6.555
    ,"SD3neg":7.431
    ,"SD2neg":8.306
    ,"SD1neg":9.280
    ,"SD0":10.363
    ,"SD1":11.567
    ,"SD2":12.905
    ,"SD3":14.390
    ,"SD4":15.876
  },
  465 : {
     "Day":465
    ,"SD4neg":6.560
    ,"SD3neg":7.435
    ,"SD2neg":8.311
    ,"SD1neg":9.286
    ,"SD0":10.370
    ,"SD1":11.575
    ,"SD2":12.914
    ,"SD3":14.400
    ,"SD4":15.887
  },
  466 : {
     "Day":466
    ,"SD4neg":6.564
    ,"SD3neg":7.440
    ,"SD2neg":8.317
    ,"SD1neg":9.292
    ,"SD0":10.377
    ,"SD1":11.583
    ,"SD2":12.923
    ,"SD3":14.411
    ,"SD4":15.899
  },
  467 : {
     "Day":467
    ,"SD4neg":6.568
    ,"SD3neg":7.445
    ,"SD2neg":8.322
    ,"SD1neg":9.298
    ,"SD0":10.384
    ,"SD1":11.591
    ,"SD2":12.932
    ,"SD3":14.421
    ,"SD4":15.911
  },
  468 : {
     "Day":468
    ,"SD4neg":6.572
    ,"SD3neg":7.450
    ,"SD2neg":8.328
    ,"SD1neg":9.304
    ,"SD0":10.391
    ,"SD1":11.599
    ,"SD2":12.941
    ,"SD3":14.432
    ,"SD4":15.923
  },
  469 : {
     "Day":469
    ,"SD4neg":6.576
    ,"SD3neg":7.455
    ,"SD2neg":8.333
    ,"SD1neg":9.311
    ,"SD0":10.398
    ,"SD1":11.607
    ,"SD2":12.950
    ,"SD3":14.442
    ,"SD4":15.934
  },
  470 : {
     "Day":470
    ,"SD4neg":6.581
    ,"SD3neg":7.460
    ,"SD2neg":8.339
    ,"SD1neg":9.317
    ,"SD0":10.405
    ,"SD1":11.615
    ,"SD2":12.959
    ,"SD3":14.452
    ,"SD4":15.946
  },
  471 : {
     "Day":471
    ,"SD4neg":6.585
    ,"SD3neg":7.465
    ,"SD2neg":8.344
    ,"SD1neg":9.323
    ,"SD0":10.412
    ,"SD1":11.622
    ,"SD2":12.968
    ,"SD3":14.463
    ,"SD4":15.957
  },
  472 : {
     "Day":472
    ,"SD4neg":6.589
    ,"SD3neg":7.469
    ,"SD2neg":8.349
    ,"SD1neg":9.329
    ,"SD0":10.419
    ,"SD1":11.630
    ,"SD2":12.977
    ,"SD3":14.473
    ,"SD4":15.969
  },
  473 : {
     "Day":473
    ,"SD4neg":6.593
    ,"SD3neg":7.474
    ,"SD2neg":8.355
    ,"SD1neg":9.335
    ,"SD0":10.426
    ,"SD1":11.638
    ,"SD2":12.986
    ,"SD3":14.483
    ,"SD4":15.980
  },
  474 : {
     "Day":474
    ,"SD4neg":6.598
    ,"SD3neg":7.479
    ,"SD2neg":8.360
    ,"SD1neg":9.341
    ,"SD0":10.433
    ,"SD1":11.646
    ,"SD2":12.995
    ,"SD3":14.493
    ,"SD4":15.992
  },
  475 : {
     "Day":475
    ,"SD4neg":6.602
    ,"SD3neg":7.484
    ,"SD2neg":8.366
    ,"SD1neg":9.348
    ,"SD0":10.440
    ,"SD1":11.654
    ,"SD2":13.004
    ,"SD3":14.504
    ,"SD4":16.004
  },
  476 : {
     "Day":476
    ,"SD4neg":6.606
    ,"SD3neg":7.488
    ,"SD2neg":8.371
    ,"SD1neg":9.354
    ,"SD0":10.446
    ,"SD1":11.662
    ,"SD2":13.013
    ,"SD3":14.514
    ,"SD4":16.016
  },
  477 : {
     "Day":477
    ,"SD4neg":6.610
    ,"SD3neg":7.493
    ,"SD2neg":8.377
    ,"SD1neg":9.360
    ,"SD0":10.454
    ,"SD1":11.670
    ,"SD2":13.022
    ,"SD3":14.525
    ,"SD4":16.027
  },
  478 : {
     "Day":478
    ,"SD4neg":6.614
    ,"SD3neg":7.498
    ,"SD2neg":8.382
    ,"SD1neg":9.366
    ,"SD0":10.460
    ,"SD1":11.678
    ,"SD2":13.031
    ,"SD3":14.535
    ,"SD4":16.039
  },
  479 : {
     "Day":479
    ,"SD4neg":6.619
    ,"SD3neg":7.503
    ,"SD2neg":8.387
    ,"SD1neg":9.372
    ,"SD0":10.467
    ,"SD1":11.686
    ,"SD2":13.040
    ,"SD3":14.545
    ,"SD4":16.050
  },
  480 : {
     "Day":480
    ,"SD4neg":6.623
    ,"SD3neg":7.508
    ,"SD2neg":8.393
    ,"SD1neg":9.378
    ,"SD0":10.474
    ,"SD1":11.694
    ,"SD2":13.049
    ,"SD3":14.555
    ,"SD4":16.062
  },
  481 : {
     "Day":481
    ,"SD4neg":6.627
    ,"SD3neg":7.513
    ,"SD2neg":8.398
    ,"SD1neg":9.384
    ,"SD0":10.481
    ,"SD1":11.701
    ,"SD2":13.058
    ,"SD3":14.566
    ,"SD4":16.073
  },
  482 : {
     "Day":482
    ,"SD4neg":6.631
    ,"SD3neg":7.518
    ,"SD2neg":8.404
    ,"SD1neg":9.390
    ,"SD0":10.488
    ,"SD1":11.709
    ,"SD2":13.067
    ,"SD3":14.576
    ,"SD4":16.085
  },
  483 : {
     "Day":483
    ,"SD4neg":6.635
    ,"SD3neg":7.522
    ,"SD2neg":8.409
    ,"SD1neg":9.396
    ,"SD0":10.495
    ,"SD1":11.717
    ,"SD2":13.076
    ,"SD3":14.587
    ,"SD4":16.097
  },
  484 : {
     "Day":484
    ,"SD4neg":6.639
    ,"SD3neg":7.527
    ,"SD2neg":8.414
    ,"SD1neg":9.402
    ,"SD0":10.502
    ,"SD1":11.725
    ,"SD2":13.085
    ,"SD3":14.597
    ,"SD4":16.108
  },
  485 : {
     "Day":485
    ,"SD4neg":6.644
    ,"SD3neg":7.532
    ,"SD2neg":8.420
    ,"SD1neg":9.409
    ,"SD0":10.509
    ,"SD1":11.733
    ,"SD2":13.094
    ,"SD3":14.607
    ,"SD4":16.120
  },
  486 : {
     "Day":486
    ,"SD4neg":6.648
    ,"SD3neg":7.537
    ,"SD2neg":8.425
    ,"SD1neg":9.415
    ,"SD0":10.516
    ,"SD1":11.741
    ,"SD2":13.103
    ,"SD3":14.617
    ,"SD4":16.132
  },
  487 : {
     "Day":487
    ,"SD4neg":6.652
    ,"SD3neg":7.541
    ,"SD2neg":8.431
    ,"SD1neg":9.421
    ,"SD0":10.523
    ,"SD1":11.749
    ,"SD2":13.112
    ,"SD3":14.628
    ,"SD4":16.143
  },
  488 : {
     "Day":488
    ,"SD4neg":6.656
    ,"SD3neg":7.546
    ,"SD2neg":8.436
    ,"SD1neg":9.427
    ,"SD0":10.530
    ,"SD1":11.757
    ,"SD2":13.121
    ,"SD3":14.638
    ,"SD4":16.154
  },
  489 : {
     "Day":489
    ,"SD4neg":6.660
    ,"SD3neg":7.551
    ,"SD2neg":8.441
    ,"SD1neg":9.433
    ,"SD0":10.537
    ,"SD1":11.765
    ,"SD2":13.130
    ,"SD3":14.648
    ,"SD4":16.167
  },
  490 : {
     "Day":490
    ,"SD4neg":6.665
    ,"SD3neg":7.556
    ,"SD2neg":8.447
    ,"SD1neg":9.439
    ,"SD0":10.544
    ,"SD1":11.772
    ,"SD2":13.139
    ,"SD3":14.659
    ,"SD4":16.178
  },
  491 : {
     "Day":491
    ,"SD4neg":6.669
    ,"SD3neg":7.561
    ,"SD2neg":8.452
    ,"SD1neg":9.445
    ,"SD0":10.550
    ,"SD1":11.780
    ,"SD2":13.148
    ,"SD3":14.669
    ,"SD4":16.190
  },
  492 : {
     "Day":492
    ,"SD4neg":6.673
    ,"SD3neg":7.565
    ,"SD2neg":8.458
    ,"SD1neg":9.451
    ,"SD0":10.557
    ,"SD1":11.788
    ,"SD2":13.157
    ,"SD3":14.679
    ,"SD4":16.201
  },
  493 : {
     "Day":493
    ,"SD4neg":6.677
    ,"SD3neg":7.570
    ,"SD2neg":8.463
    ,"SD1neg":9.457
    ,"SD0":10.564
    ,"SD1":11.796
    ,"SD2":13.166
    ,"SD3":14.689
    ,"SD4":16.213
  },
  494 : {
     "Day":494
    ,"SD4neg":6.681
    ,"SD3neg":7.575
    ,"SD2neg":8.468
    ,"SD1neg":9.463
    ,"SD0":10.571
    ,"SD1":11.804
    ,"SD2":13.175
    ,"SD3":14.700
    ,"SD4":16.225
  },
  495 : {
     "Day":495
    ,"SD4neg":6.685
    ,"SD3neg":7.580
    ,"SD2neg":8.474
    ,"SD1neg":9.469
    ,"SD0":10.578
    ,"SD1":11.812
    ,"SD2":13.184
    ,"SD3":14.710
    ,"SD4":16.236
  },
  496 : {
     "Day":496
    ,"SD4neg":6.690
    ,"SD3neg":7.584
    ,"SD2neg":8.479
    ,"SD1neg":9.476
    ,"SD0":10.585
    ,"SD1":11.820
    ,"SD2":13.193
    ,"SD3":14.720
    ,"SD4":16.248
  },
  497 : {
     "Day":497
    ,"SD4neg":6.694
    ,"SD3neg":7.589
    ,"SD2neg":8.484
    ,"SD1neg":9.482
    ,"SD0":10.592
    ,"SD1":11.827
    ,"SD2":13.202
    ,"SD3":14.731
    ,"SD4":16.259
  },
  498 : {
     "Day":498
    ,"SD4neg":6.698
    ,"SD3neg":7.594
    ,"SD2neg":8.490
    ,"SD1neg":9.488
    ,"SD0":10.599
    ,"SD1":11.835
    ,"SD2":13.211
    ,"SD3":14.741
    ,"SD4":16.271
  },
  499 : {
     "Day":499
    ,"SD4neg":6.702
    ,"SD3neg":7.599
    ,"SD2neg":8.495
    ,"SD1neg":9.494
    ,"SD0":10.606
    ,"SD1":11.843
    ,"SD2":13.220
    ,"SD3":14.751
    ,"SD4":16.283
  },
  500 : {
     "Day":500
    ,"SD4neg":6.706
    ,"SD3neg":7.603
    ,"SD2neg":8.500
    ,"SD1neg":9.500
    ,"SD0":10.612
    ,"SD1":11.851
    ,"SD2":13.229
    ,"SD3":14.762
    ,"SD4":16.294
  },
  501 : {
     "Day":501
    ,"SD4neg":6.710
    ,"SD3neg":7.608
    ,"SD2neg":8.506
    ,"SD1neg":9.506
    ,"SD0":10.619
    ,"SD1":11.859
    ,"SD2":13.238
    ,"SD3":14.772
    ,"SD4":16.305
  },
  502 : {
     "Day":502
    ,"SD4neg":6.715
    ,"SD3neg":7.613
    ,"SD2neg":8.511
    ,"SD1neg":9.512
    ,"SD0":10.626
    ,"SD1":11.867
    ,"SD2":13.247
    ,"SD3":14.782
    ,"SD4":16.317
  },
  503 : {
     "Day":503
    ,"SD4neg":6.719
    ,"SD3neg":7.618
    ,"SD2neg":8.517
    ,"SD1neg":9.518
    ,"SD0":10.633
    ,"SD1":11.874
    ,"SD2":13.256
    ,"SD3":14.792
    ,"SD4":16.329
  },
  504 : {
     "Day":504
    ,"SD4neg":6.723
    ,"SD3neg":7.622
    ,"SD2neg":8.522
    ,"SD1neg":9.524
    ,"SD0":10.640
    ,"SD1":11.882
    ,"SD2":13.265
    ,"SD3":14.803
    ,"SD4":16.340
  },
  505 : {
     "Day":505
    ,"SD4neg":6.727
    ,"SD3neg":7.627
    ,"SD2neg":8.527
    ,"SD1neg":9.530
    ,"SD0":10.647
    ,"SD1":11.890
    ,"SD2":13.274
    ,"SD3":14.813
    ,"SD4":16.352
  },
  506 : {
     "Day":506
    ,"SD4neg":6.731
    ,"SD3neg":7.632
    ,"SD2neg":8.533
    ,"SD1neg":9.536
    ,"SD0":10.654
    ,"SD1":11.898
    ,"SD2":13.283
    ,"SD3":14.823
    ,"SD4":16.364
  },
  507 : {
     "Day":507
    ,"SD4neg":6.735
    ,"SD3neg":7.637
    ,"SD2neg":8.538
    ,"SD1neg":9.542
    ,"SD0":10.660
    ,"SD1":11.906
    ,"SD2":13.291
    ,"SD3":14.833
    ,"SD4":16.375
  },
  508 : {
     "Day":508
    ,"SD4neg":6.739
    ,"SD3neg":7.641
    ,"SD2neg":8.543
    ,"SD1neg":9.548
    ,"SD0":10.667
    ,"SD1":11.914
    ,"SD2":13.301
    ,"SD3":14.844
    ,"SD4":16.387
  },
  509 : {
     "Day":509
    ,"SD4neg":6.743
    ,"SD3neg":7.646
    ,"SD2neg":8.548
    ,"SD1neg":9.554
    ,"SD0":10.674
    ,"SD1":11.921
    ,"SD2":13.309
    ,"SD3":14.854
    ,"SD4":16.398
  },
  510 : {
     "Day":510
    ,"SD4neg":6.747
    ,"SD3neg":7.651
    ,"SD2neg":8.554
    ,"SD1neg":9.560
    ,"SD0":10.681
    ,"SD1":11.929
    ,"SD2":13.318
    ,"SD3":14.864
    ,"SD4":16.410
  },
  511 : {
     "Day":511
    ,"SD4neg":6.752
    ,"SD3neg":7.655
    ,"SD2neg":8.559
    ,"SD1neg":9.566
    ,"SD0":10.688
    ,"SD1":11.937
    ,"SD2":13.327
    ,"SD3":14.874
    ,"SD4":16.421
  },
  512 : {
     "Day":512
    ,"SD4neg":6.756
    ,"SD3neg":7.660
    ,"SD2neg":8.564
    ,"SD1neg":9.572
    ,"SD0":10.695
    ,"SD1":11.945
    ,"SD2":13.336
    ,"SD3":14.885
    ,"SD4":16.433
  },
  513 : {
     "Day":513
    ,"SD4neg":6.760
    ,"SD3neg":7.665
    ,"SD2neg":8.570
    ,"SD1neg":9.578
    ,"SD0":10.702
    ,"SD1":11.953
    ,"SD2":13.345
    ,"SD3":14.895
    ,"SD4":16.445
  },
  514 : {
     "Day":514
    ,"SD4neg":6.764
    ,"SD3neg":7.669
    ,"SD2neg":8.575
    ,"SD1neg":9.584
    ,"SD0":10.708
    ,"SD1":11.960
    ,"SD2":13.354
    ,"SD3":14.905
    ,"SD4":16.456
  },
  515 : {
     "Day":515
    ,"SD4neg":6.768
    ,"SD3neg":7.674
    ,"SD2neg":8.580
    ,"SD1neg":9.590
    ,"SD0":10.715
    ,"SD1":11.968
    ,"SD2":13.363
    ,"SD3":14.915
    ,"SD4":16.467
  },
  516 : {
     "Day":516
    ,"SD4neg":6.772
    ,"SD3neg":7.679
    ,"SD2neg":8.586
    ,"SD1neg":9.596
    ,"SD0":10.722
    ,"SD1":11.976
    ,"SD2":13.372
    ,"SD3":14.926
    ,"SD4":16.479
  },
  517 : {
     "Day":517
    ,"SD4neg":6.776
    ,"SD3neg":7.683
    ,"SD2neg":8.591
    ,"SD1neg":9.602
    ,"SD0":10.729
    ,"SD1":11.984
    ,"SD2":13.381
    ,"SD3":14.936
    ,"SD4":16.491
  },
  518 : {
     "Day":518
    ,"SD4neg":6.780
    ,"SD3neg":7.688
    ,"SD2neg":8.596
    ,"SD1neg":9.608
    ,"SD0":10.736
    ,"SD1":11.991
    ,"SD2":13.390
    ,"SD3":14.946
    ,"SD4":16.502
  },
  519 : {
     "Day":519
    ,"SD4neg":6.784
    ,"SD3neg":7.693
    ,"SD2neg":8.601
    ,"SD1neg":9.614
    ,"SD0":10.743
    ,"SD1":11.999
    ,"SD2":13.399
    ,"SD3":14.957
    ,"SD4":16.514
  },
  520 : {
     "Day":520
    ,"SD4neg":6.788
    ,"SD3neg":7.697
    ,"SD2neg":8.607
    ,"SD1neg":9.620
    ,"SD0":10.749
    ,"SD1":12.007
    ,"SD2":13.408
    ,"SD3":14.967
    ,"SD4":16.526
  },
  521 : {
     "Day":521
    ,"SD4neg":6.792
    ,"SD3neg":7.702
    ,"SD2neg":8.612
    ,"SD1neg":9.626
    ,"SD0":10.756
    ,"SD1":12.015
    ,"SD2":13.417
    ,"SD3":14.977
    ,"SD4":16.537
  },
  522 : {
     "Day":522
    ,"SD4neg":6.796
    ,"SD3neg":7.707
    ,"SD2neg":8.617
    ,"SD1neg":9.632
    ,"SD0":10.763
    ,"SD1":12.023
    ,"SD2":13.425
    ,"SD3":14.987
    ,"SD4":16.548
  },
  523 : {
     "Day":523
    ,"SD4neg":6.800
    ,"SD3neg":7.711
    ,"SD2neg":8.623
    ,"SD1neg":9.638
    ,"SD0":10.770
    ,"SD1":12.030
    ,"SD2":13.434
    ,"SD3":14.997
    ,"SD4":16.560
  },
  524 : {
     "Day":524
    ,"SD4neg":6.804
    ,"SD3neg":7.716
    ,"SD2neg":8.628
    ,"SD1neg":9.644
    ,"SD0":10.777
    ,"SD1":12.038
    ,"SD2":13.443
    ,"SD3":15.008
    ,"SD4":16.572
  },
  525 : {
     "Day":525
    ,"SD4neg":6.809
    ,"SD3neg":7.721
    ,"SD2neg":8.633
    ,"SD1neg":9.650
    ,"SD0":10.784
    ,"SD1":12.046
    ,"SD2":13.452
    ,"SD3":15.018
    ,"SD4":16.583
  },
  526 : {
     "Day":526
    ,"SD4neg":6.812
    ,"SD3neg":7.725
    ,"SD2neg":8.638
    ,"SD1neg":9.656
    ,"SD0":10.790
    ,"SD1":12.054
    ,"SD2":13.461
    ,"SD3":15.028
    ,"SD4":16.595
  },
  527 : {
     "Day":527
    ,"SD4neg":6.817
    ,"SD3neg":7.730
    ,"SD2neg":8.644
    ,"SD1neg":9.662
    ,"SD0":10.797
    ,"SD1":12.062
    ,"SD2":13.470
    ,"SD3":15.038
    ,"SD4":16.607
  },
  528 : {
     "Day":528
    ,"SD4neg":6.821
    ,"SD3neg":7.735
    ,"SD2neg":8.649
    ,"SD1neg":9.668
    ,"SD0":10.804
    ,"SD1":12.069
    ,"SD2":13.479
    ,"SD3":15.048
    ,"SD4":16.618
  },
  529 : {
     "Day":529
    ,"SD4neg":6.825
    ,"SD3neg":7.739
    ,"SD2neg":8.654
    ,"SD1neg":9.674
    ,"SD0":10.811
    ,"SD1":12.077
    ,"SD2":13.488
    ,"SD3":15.059
    ,"SD4":16.630
  },
  530 : {
     "Day":530
    ,"SD4neg":6.829
    ,"SD3neg":7.744
    ,"SD2neg":8.659
    ,"SD1neg":9.680
    ,"SD0":10.817
    ,"SD1":12.085
    ,"SD2":13.497
    ,"SD3":15.069
    ,"SD4":16.641
  },
  531 : {
     "Day":531
    ,"SD4neg":6.833
    ,"SD3neg":7.749
    ,"SD2neg":8.665
    ,"SD1neg":9.686
    ,"SD0":10.824
    ,"SD1":12.093
    ,"SD2":13.506
    ,"SD3":15.079
    ,"SD4":16.653
  },
  532 : {
     "Day":532
    ,"SD4neg":6.837
    ,"SD3neg":7.753
    ,"SD2neg":8.670
    ,"SD1neg":9.692
    ,"SD0":10.831
    ,"SD1":12.100
    ,"SD2":13.515
    ,"SD3":15.090
    ,"SD4":16.665
  },
  533 : {
     "Day":533
    ,"SD4neg":6.841
    ,"SD3neg":7.758
    ,"SD2neg":8.675
    ,"SD1neg":9.698
    ,"SD0":10.838
    ,"SD1":12.108
    ,"SD2":13.523
    ,"SD3":15.100
    ,"SD4":16.676
  },
  534 : {
     "Day":534
    ,"SD4neg":6.845
    ,"SD3neg":7.763
    ,"SD2neg":8.680
    ,"SD1neg":9.704
    ,"SD0":10.845
    ,"SD1":12.116
    ,"SD2":13.532
    ,"SD3":15.110
    ,"SD4":16.687
  },
  535 : {
     "Day":535
    ,"SD4neg":6.849
    ,"SD3neg":7.767
    ,"SD2neg":8.686
    ,"SD1neg":9.710
    ,"SD0":10.851
    ,"SD1":12.124
    ,"SD2":13.541
    ,"SD3":15.120
    ,"SD4":16.699
  },
  536 : {
     "Day":536
    ,"SD4neg":6.853
    ,"SD3neg":7.772
    ,"SD2neg":8.691
    ,"SD1neg":9.716
    ,"SD0":10.858
    ,"SD1":12.131
    ,"SD2":13.550
    ,"SD3":15.130
    ,"SD4":16.711
  },
  537 : {
     "Day":537
    ,"SD4neg":6.857
    ,"SD3neg":7.777
    ,"SD2neg":8.696
    ,"SD1neg":9.722
    ,"SD0":10.865
    ,"SD1":12.139
    ,"SD2":13.559
    ,"SD3":15.140
    ,"SD4":16.722
  },
  538 : {
     "Day":538
    ,"SD4neg":6.861
    ,"SD3neg":7.781
    ,"SD2neg":8.701
    ,"SD1neg":9.728
    ,"SD0":10.872
    ,"SD1":12.147
    ,"SD2":13.568
    ,"SD3":15.151
    ,"SD4":16.734
  },
  539 : {
     "Day":539
    ,"SD4neg":6.865
    ,"SD3neg":7.786
    ,"SD2neg":8.707
    ,"SD1neg":9.734
    ,"SD0":10.878
    ,"SD1":12.155
    ,"SD2":13.577
    ,"SD3":15.161
    ,"SD4":16.745
  },
  540 : {
     "Day":540
    ,"SD4neg":6.869
    ,"SD3neg":7.790
    ,"SD2neg":8.712
    ,"SD1neg":9.739
    ,"SD0":10.885
    ,"SD1":12.162
    ,"SD2":13.586
    ,"SD3":15.171
    ,"SD4":16.757
  },
  541 : {
     "Day":541
    ,"SD4neg":6.873
    ,"SD3neg":7.795
    ,"SD2neg":8.717
    ,"SD1neg":9.745
    ,"SD0":10.892
    ,"SD1":12.170
    ,"SD2":13.595
    ,"SD3":15.182
    ,"SD4":16.769
  },
  542 : {
     "Day":542
    ,"SD4neg":6.877
    ,"SD3neg":7.800
    ,"SD2neg":8.722
    ,"SD1neg":9.751
    ,"SD0":10.899
    ,"SD1":12.178
    ,"SD2":13.603
    ,"SD3":15.192
    ,"SD4":16.780
  },
  543 : {
     "Day":543
    ,"SD4neg":6.881
    ,"SD3neg":7.804
    ,"SD2neg":8.727
    ,"SD1neg":9.757
    ,"SD0":10.906
    ,"SD1":12.186
    ,"SD2":13.612
    ,"SD3":15.202
    ,"SD4":16.792
  },
  544 : {
     "Day":544
    ,"SD4neg":6.885
    ,"SD3neg":7.809
    ,"SD2neg":8.733
    ,"SD1neg":9.763
    ,"SD0":10.912
    ,"SD1":12.193
    ,"SD2":13.621
    ,"SD3":15.212
    ,"SD4":16.803
  },
  545 : {
     "Day":545
    ,"SD4neg":6.889
    ,"SD3neg":7.813
    ,"SD2neg":8.738
    ,"SD1neg":9.769
    ,"SD0":10.919
    ,"SD1":12.201
    ,"SD2":13.630
    ,"SD3":15.222
    ,"SD4":16.815
  },
  546 : {
     "Day":546
    ,"SD4neg":6.893
    ,"SD3neg":7.818
    ,"SD2neg":8.743
    ,"SD1neg":9.775
    ,"SD0":10.926
    ,"SD1":12.209
    ,"SD2":13.639
    ,"SD3":15.233
    ,"SD4":16.827
  },
  547 : {
     "Day":547
    ,"SD4neg":6.897
    ,"SD3neg":7.823
    ,"SD2neg":8.748
    ,"SD1neg":9.781
    ,"SD0":10.933
    ,"SD1":12.217
    ,"SD2":13.648
    ,"SD3":15.243
    ,"SD4":16.838
  },
  548 : {
     "Day":548
    ,"SD4neg":6.901
    ,"SD3neg":7.827
    ,"SD2neg":8.753
    ,"SD1neg":9.787
    ,"SD0":10.939
    ,"SD1":12.224
    ,"SD2":13.657
    ,"SD3":15.253
    ,"SD4":16.850
  },
  549 : {
     "Day":549
    ,"SD4neg":6.905
    ,"SD3neg":7.832
    ,"SD2neg":8.759
    ,"SD1neg":9.793
    ,"SD0":10.946
    ,"SD1":12.232
    ,"SD2":13.666
    ,"SD3":15.263
    ,"SD4":16.861
  },
  550 : {
     "Day":550
    ,"SD4neg":6.909
    ,"SD3neg":7.836
    ,"SD2neg":8.764
    ,"SD1neg":9.799
    ,"SD0":10.953
    ,"SD1":12.240
    ,"SD2":13.674
    ,"SD3":15.273
    ,"SD4":16.872
  },
  551 : {
     "Day":551
    ,"SD4neg":6.913
    ,"SD3neg":7.841
    ,"SD2neg":8.769
    ,"SD1neg":9.805
    ,"SD0":10.960
    ,"SD1":12.248
    ,"SD2":13.684
    ,"SD3":15.284
    ,"SD4":16.884
  },
  552 : {
     "Day":552
    ,"SD4neg":6.917
    ,"SD3neg":7.846
    ,"SD2neg":8.774
    ,"SD1neg":9.810
    ,"SD0":10.966
    ,"SD1":12.255
    ,"SD2":13.692
    ,"SD3":15.294
    ,"SD4":16.896
  },
  553 : {
     "Day":553
    ,"SD4neg":6.921
    ,"SD3neg":7.850
    ,"SD2neg":8.779
    ,"SD1neg":9.816
    ,"SD0":10.973
    ,"SD1":12.263
    ,"SD2":13.701
    ,"SD3":15.304
    ,"SD4":16.908
  },
  554 : {
     "Day":554
    ,"SD4neg":6.925
    ,"SD3neg":7.855
    ,"SD2neg":8.785
    ,"SD1neg":9.822
    ,"SD0":10.980
    ,"SD1":12.271
    ,"SD2":13.710
    ,"SD3":15.314
    ,"SD4":16.919
  },
  555 : {
     "Day":555
    ,"SD4neg":6.929
    ,"SD3neg":7.859
    ,"SD2neg":8.790
    ,"SD1neg":9.828
    ,"SD0":10.986
    ,"SD1":12.278
    ,"SD2":13.719
    ,"SD3":15.324
    ,"SD4":16.930
  },
  556 : {
     "Day":556
    ,"SD4neg":6.933
    ,"SD3neg":7.864
    ,"SD2neg":8.795
    ,"SD1neg":9.834
    ,"SD0":10.993
    ,"SD1":12.286
    ,"SD2":13.728
    ,"SD3":15.335
    ,"SD4":16.942
  },
  557 : {
     "Day":557
    ,"SD4neg":6.937
    ,"SD3neg":7.868
    ,"SD2neg":8.800
    ,"SD1neg":9.840
    ,"SD0":11.000
    ,"SD1":12.294
    ,"SD2":13.737
    ,"SD3":15.345
    ,"SD4":16.953
  },
  558 : {
     "Day":558
    ,"SD4neg":6.940
    ,"SD3neg":7.873
    ,"SD2neg":8.805
    ,"SD1neg":9.846
    ,"SD0":11.007
    ,"SD1":12.302
    ,"SD2":13.746
    ,"SD3":15.356
    ,"SD4":16.965
  },
  559 : {
     "Day":559
    ,"SD4neg":6.945
    ,"SD3neg":7.878
    ,"SD2neg":8.811
    ,"SD1neg":9.852
    ,"SD0":11.013
    ,"SD1":12.309
    ,"SD2":13.754
    ,"SD3":15.365
    ,"SD4":16.977
  },
  560 : {
     "Day":560
    ,"SD4neg":6.948
    ,"SD3neg":7.882
    ,"SD2neg":8.816
    ,"SD1neg":9.858
    ,"SD0":11.020
    ,"SD1":12.317
    ,"SD2":13.763
    ,"SD3":15.376
    ,"SD4":16.989
  },
  561 : {
     "Day":561
    ,"SD4neg":6.952
    ,"SD3neg":7.887
    ,"SD2neg":8.821
    ,"SD1neg":9.864
    ,"SD0":11.027
    ,"SD1":12.325
    ,"SD2":13.772
    ,"SD3":15.386
    ,"SD4":17.000
  },
  562 : {
     "Day":562
    ,"SD4neg":6.956
    ,"SD3neg":7.891
    ,"SD2neg":8.826
    ,"SD1neg":9.869
    ,"SD0":11.034
    ,"SD1":12.332
    ,"SD2":13.781
    ,"SD3":15.396
    ,"SD4":17.011
  },
  563 : {
     "Day":563
    ,"SD4neg":6.960
    ,"SD3neg":7.896
    ,"SD2neg":8.831
    ,"SD1neg":9.875
    ,"SD0":11.040
    ,"SD1":12.340
    ,"SD2":13.790
    ,"SD3":15.406
    ,"SD4":17.023
  },
  564 : {
     "Day":564
    ,"SD4neg":6.964
    ,"SD3neg":7.900
    ,"SD2neg":8.836
    ,"SD1neg":9.881
    ,"SD0":11.047
    ,"SD1":12.348
    ,"SD2":13.799
    ,"SD3":15.416
    ,"SD4":17.034
  },
  565 : {
     "Day":565
    ,"SD4neg":6.968
    ,"SD3neg":7.905
    ,"SD2neg":8.841
    ,"SD1neg":9.887
    ,"SD0":11.054
    ,"SD1":12.355
    ,"SD2":13.807
    ,"SD3":15.427
    ,"SD4":17.046
  },
  566 : {
     "Day":566
    ,"SD4neg":6.972
    ,"SD3neg":7.909
    ,"SD2neg":8.847
    ,"SD1neg":9.893
    ,"SD0":11.060
    ,"SD1":12.363
    ,"SD2":13.816
    ,"SD3":15.437
    ,"SD4":17.058
  },
  567 : {
     "Day":567
    ,"SD4neg":6.976
    ,"SD3neg":7.914
    ,"SD2neg":8.852
    ,"SD1neg":9.899
    ,"SD0":11.067
    ,"SD1":12.371
    ,"SD2":13.825
    ,"SD3":15.447
    ,"SD4":17.070
  },
  568 : {
     "Day":568
    ,"SD4neg":6.980
    ,"SD3neg":7.919
    ,"SD2neg":8.857
    ,"SD1neg":9.905
    ,"SD0":11.074
    ,"SD1":12.379
    ,"SD2":13.834
    ,"SD3":15.457
    ,"SD4":17.081
  },
  569 : {
     "Day":569
    ,"SD4neg":6.984
    ,"SD3neg":7.923
    ,"SD2neg":8.862
    ,"SD1neg":9.910
    ,"SD0":11.081
    ,"SD1":12.386
    ,"SD2":13.843
    ,"SD3":15.468
    ,"SD4":17.093
  },
  570 : {
     "Day":570
    ,"SD4neg":6.988
    ,"SD3neg":7.928
    ,"SD2neg":8.867
    ,"SD1neg":9.916
    ,"SD0":11.087
    ,"SD1":12.394
    ,"SD2":13.852
    ,"SD3":15.478
    ,"SD4":17.104
  },
  571 : {
     "Day":571
    ,"SD4neg":6.992
    ,"SD3neg":7.932
    ,"SD2neg":8.872
    ,"SD1neg":9.922
    ,"SD0":11.094
    ,"SD1":12.402
    ,"SD2":13.861
    ,"SD3":15.488
    ,"SD4":17.116
  },
  572 : {
     "Day":572
    ,"SD4neg":6.996
    ,"SD3neg":7.937
    ,"SD2neg":8.878
    ,"SD1neg":9.928
    ,"SD0":11.101
    ,"SD1":12.409
    ,"SD2":13.869
    ,"SD3":15.498
    ,"SD4":17.127
  },
  573 : {
     "Day":573
    ,"SD4neg":6.999
    ,"SD3neg":7.941
    ,"SD2neg":8.883
    ,"SD1neg":9.934
    ,"SD0":11.107
    ,"SD1":12.417
    ,"SD2":13.878
    ,"SD3":15.509
    ,"SD4":17.139
  },
  574 : {
     "Day":574
    ,"SD4neg":7.003
    ,"SD3neg":7.946
    ,"SD2neg":8.888
    ,"SD1neg":9.940
    ,"SD0":11.114
    ,"SD1":12.425
    ,"SD2":13.887
    ,"SD3":15.519
    ,"SD4":17.150
  },
  575 : {
     "Day":575
    ,"SD4neg":7.007
    ,"SD3neg":7.950
    ,"SD2neg":8.893
    ,"SD1neg":9.946
    ,"SD0":11.121
    ,"SD1":12.432
    ,"SD2":13.896
    ,"SD3":15.529
    ,"SD4":17.162
  },
  576 : {
     "Day":576
    ,"SD4neg":7.011
    ,"SD3neg":7.955
    ,"SD2neg":8.898
    ,"SD1neg":9.952
    ,"SD0":11.128
    ,"SD1":12.440
    ,"SD2":13.905
    ,"SD3":15.539
    ,"SD4":17.173
  },
  577 : {
     "Day":577
    ,"SD4neg":7.015
    ,"SD3neg":7.959
    ,"SD2neg":8.903
    ,"SD1neg":9.957
    ,"SD0":11.134
    ,"SD1":12.448
    ,"SD2":13.914
    ,"SD3":15.550
    ,"SD4":17.185
  },
  578 : {
     "Day":578
    ,"SD4neg":7.019
    ,"SD3neg":7.964
    ,"SD2neg":8.908
    ,"SD1neg":9.963
    ,"SD0":11.141
    ,"SD1":12.455
    ,"SD2":13.923
    ,"SD3":15.560
    ,"SD4":17.197
  },
  579 : {
     "Day":579
    ,"SD4neg":7.023
    ,"SD3neg":7.968
    ,"SD2neg":8.913
    ,"SD1neg":9.969
    ,"SD0":11.148
    ,"SD1":12.463
    ,"SD2":13.932
    ,"SD3":15.570
    ,"SD4":17.209
  },
  580 : {
     "Day":580
    ,"SD4neg":7.027
    ,"SD3neg":7.973
    ,"SD2neg":8.919
    ,"SD1neg":9.975
    ,"SD0":11.154
    ,"SD1":12.471
    ,"SD2":13.940
    ,"SD3":15.580
    ,"SD4":17.220
  },
  581 : {
     "Day":581
    ,"SD4neg":7.031
    ,"SD3neg":7.977
    ,"SD2neg":8.924
    ,"SD1neg":9.981
    ,"SD0":11.161
    ,"SD1":12.479
    ,"SD2":13.949
    ,"SD3":15.591
    ,"SD4":17.232
  },
  582 : {
     "Day":582
    ,"SD4neg":7.035
    ,"SD3neg":7.982
    ,"SD2neg":8.929
    ,"SD1neg":9.987
    ,"SD0":11.168
    ,"SD1":12.486
    ,"SD2":13.958
    ,"SD3":15.601
    ,"SD4":17.243
  },
  583 : {
     "Day":583
    ,"SD4neg":7.038
    ,"SD3neg":7.986
    ,"SD2neg":8.934
    ,"SD1neg":9.992
    ,"SD0":11.174
    ,"SD1":12.494
    ,"SD2":13.967
    ,"SD3":15.611
    ,"SD4":17.255
  },
  584 : {
     "Day":584
    ,"SD4neg":7.042
    ,"SD3neg":7.991
    ,"SD2neg":8.939
    ,"SD1neg":9.998
    ,"SD0":11.181
    ,"SD1":12.502
    ,"SD2":13.976
    ,"SD3":15.621
    ,"SD4":17.266
  },
  585 : {
     "Day":585
    ,"SD4neg":7.046
    ,"SD3neg":7.995
    ,"SD2neg":8.944
    ,"SD1neg":10.004
    ,"SD0":11.188
    ,"SD1":12.509
    ,"SD2":13.985
    ,"SD3":15.631
    ,"SD4":17.278
  },
  586 : {
     "Day":586
    ,"SD4neg":7.050
    ,"SD3neg":8.000
    ,"SD2neg":8.949
    ,"SD1neg":10.010
    ,"SD0":11.194
    ,"SD1":12.517
    ,"SD2":13.993
    ,"SD3":15.641
    ,"SD4":17.290
  },
  587 : {
     "Day":587
    ,"SD4neg":7.054
    ,"SD3neg":8.004
    ,"SD2neg":8.954
    ,"SD1neg":10.016
    ,"SD0":11.201
    ,"SD1":12.525
    ,"SD2":14.002
    ,"SD3":15.652
    ,"SD4":17.301
  },
  588 : {
     "Day":588
    ,"SD4neg":7.058
    ,"SD3neg":8.009
    ,"SD2neg":8.960
    ,"SD1neg":10.022
    ,"SD0":11.208
    ,"SD1":12.532
    ,"SD2":14.011
    ,"SD3":15.662
    ,"SD4":17.313
  },
  589 : {
     "Day":589
    ,"SD4neg":7.062
    ,"SD3neg":8.013
    ,"SD2neg":8.965
    ,"SD1neg":10.027
    ,"SD0":11.214
    ,"SD1":12.540
    ,"SD2":14.020
    ,"SD3":15.672
    ,"SD4":17.325
  },
  590 : {
     "Day":590
    ,"SD4neg":7.066
    ,"SD3neg":8.018
    ,"SD2neg":8.970
    ,"SD1neg":10.033
    ,"SD0":11.221
    ,"SD1":12.548
    ,"SD2":14.029
    ,"SD3":15.683
    ,"SD4":17.336
  },
  591 : {
     "Day":591
    ,"SD4neg":7.070
    ,"SD3neg":8.022
    ,"SD2neg":8.975
    ,"SD1neg":10.039
    ,"SD0":11.228
    ,"SD1":12.555
    ,"SD2":14.038
    ,"SD3":15.693
    ,"SD4":17.348
  },
  592 : {
     "Day":592
    ,"SD4neg":7.073
    ,"SD3neg":8.027
    ,"SD2neg":8.980
    ,"SD1neg":10.045
    ,"SD0":11.234
    ,"SD1":12.563
    ,"SD2":14.047
    ,"SD3":15.703
    ,"SD4":17.360
  },
  593 : {
     "Day":593
    ,"SD4neg":7.077
    ,"SD3neg":8.031
    ,"SD2neg":8.985
    ,"SD1neg":10.051
    ,"SD0":11.241
    ,"SD1":12.571
    ,"SD2":14.055
    ,"SD3":15.713
    ,"SD4":17.371
  },
  594 : {
     "Day":594
    ,"SD4neg":7.081
    ,"SD3neg":8.036
    ,"SD2neg":8.990
    ,"SD1neg":10.057
    ,"SD0":11.248
    ,"SD1":12.578
    ,"SD2":14.064
    ,"SD3":15.724
    ,"SD4":17.383
  },
  595 : {
     "Day":595
    ,"SD4neg":7.085
    ,"SD3neg":8.040
    ,"SD2neg":8.995
    ,"SD1neg":10.062
    ,"SD0":11.254
    ,"SD1":12.586
    ,"SD2":14.073
    ,"SD3":15.734
    ,"SD4":17.394
  },
  596 : {
     "Day":596
    ,"SD4neg":7.089
    ,"SD3neg":8.045
    ,"SD2neg":9.000
    ,"SD1neg":10.068
    ,"SD0":11.261
    ,"SD1":12.594
    ,"SD2":14.082
    ,"SD3":15.744
    ,"SD4":17.406
  },
  597 : {
     "Day":597
    ,"SD4neg":7.093
    ,"SD3neg":8.049
    ,"SD2neg":9.005
    ,"SD1neg":10.074
    ,"SD0":11.268
    ,"SD1":12.601
    ,"SD2":14.091
    ,"SD3":15.754
    ,"SD4":17.417
  },
  598 : {
     "Day":598
    ,"SD4neg":7.097
    ,"SD3neg":8.054
    ,"SD2neg":9.010
    ,"SD1neg":10.080
    ,"SD0":11.274
    ,"SD1":12.609
    ,"SD2":14.100
    ,"SD3":15.764
    ,"SD4":17.429
  },
  599 : {
     "Day":599
    ,"SD4neg":7.100
    ,"SD3neg":8.058
    ,"SD2neg":9.016
    ,"SD1neg":10.086
    ,"SD0":11.281
    ,"SD1":12.617
    ,"SD2":14.109
    ,"SD3":15.775
    ,"SD4":17.441
  },
  600 : {
     "Day":600
    ,"SD4neg":7.104
    ,"SD3neg":8.062
    ,"SD2neg":9.021
    ,"SD1neg":10.091
    ,"SD0":11.288
    ,"SD1":12.624
    ,"SD2":14.117
    ,"SD3":15.785
    ,"SD4":17.452
  },
  601 : {
     "Day":601
    ,"SD4neg":7.108
    ,"SD3neg":8.067
    ,"SD2neg":9.026
    ,"SD1neg":10.097
    ,"SD0":11.294
    ,"SD1":12.632
    ,"SD2":14.126
    ,"SD3":15.795
    ,"SD4":17.464
  },
  602 : {
     "Day":602
    ,"SD4neg":7.112
    ,"SD3neg":8.071
    ,"SD2neg":9.031
    ,"SD1neg":10.103
    ,"SD0":11.301
    ,"SD1":12.640
    ,"SD2":14.135
    ,"SD3":15.805
    ,"SD4":17.475
  },
  603 : {
     "Day":603
    ,"SD4neg":7.116
    ,"SD3neg":8.076
    ,"SD2neg":9.036
    ,"SD1neg":10.109
    ,"SD0":11.308
    ,"SD1":12.647
    ,"SD2":14.144
    ,"SD3":15.816
    ,"SD4":17.487
  },
  604 : {
     "Day":604
    ,"SD4neg":7.119
    ,"SD3neg":8.080
    ,"SD2neg":9.041
    ,"SD1neg":10.115
    ,"SD0":11.314
    ,"SD1":12.655
    ,"SD2":14.153
    ,"SD3":15.826
    ,"SD4":17.499
  },
  605 : {
     "Day":605
    ,"SD4neg":7.124
    ,"SD3neg":8.085
    ,"SD2neg":9.046
    ,"SD1neg":10.121
    ,"SD0":11.321
    ,"SD1":12.663
    ,"SD2":14.162
    ,"SD3":15.836
    ,"SD4":17.511
  },
  606 : {
     "Day":606
    ,"SD4neg":7.127
    ,"SD3neg":8.089
    ,"SD2neg":9.051
    ,"SD1neg":10.126
    ,"SD0":11.328
    ,"SD1":12.670
    ,"SD2":14.171
    ,"SD3":15.846
    ,"SD4":17.522
  },
  607 : {
     "Day":607
    ,"SD4neg":7.131
    ,"SD3neg":8.094
    ,"SD2neg":9.056
    ,"SD1neg":10.132
    ,"SD0":11.334
    ,"SD1":12.678
    ,"SD2":14.179
    ,"SD3":15.856
    ,"SD4":17.534
  },
  608 : {
     "Day":608
    ,"SD4neg":7.135
    ,"SD3neg":8.098
    ,"SD2neg":9.061
    ,"SD1neg":10.138
    ,"SD0":11.341
    ,"SD1":12.686
    ,"SD2":14.188
    ,"SD3":15.867
    ,"SD4":17.546
  },
  609 : {
     "Day":609
    ,"SD4neg":7.139
    ,"SD3neg":8.102
    ,"SD2neg":9.066
    ,"SD1neg":10.144
    ,"SD0":11.348
    ,"SD1":12.693
    ,"SD2":14.197
    ,"SD3":15.877
    ,"SD4":17.557
  },
  610 : {
     "Day":610
    ,"SD4neg":7.143
    ,"SD3neg":8.107
    ,"SD2neg":9.072
    ,"SD1neg":10.150
    ,"SD0":11.354
    ,"SD1":12.701
    ,"SD2":14.206
    ,"SD3":15.887
    ,"SD4":17.569
  },
  611 : {
     "Day":611
    ,"SD4neg":7.146
    ,"SD3neg":8.112
    ,"SD2neg":9.077
    ,"SD1neg":10.155
    ,"SD0":11.361
    ,"SD1":12.709
    ,"SD2":14.215
    ,"SD3":15.898
    ,"SD4":17.581
  },
  612 : {
     "Day":612
    ,"SD4neg":7.150
    ,"SD3neg":8.116
    ,"SD2neg":9.082
    ,"SD1neg":10.161
    ,"SD0":11.368
    ,"SD1":12.716
    ,"SD2":14.224
    ,"SD3":15.908
    ,"SD4":17.592
  },
  613 : {
     "Day":613
    ,"SD4neg":7.154
    ,"SD3neg":8.120
    ,"SD2neg":9.087
    ,"SD1neg":10.167
    ,"SD0":11.374
    ,"SD1":12.724
    ,"SD2":14.233
    ,"SD3":15.918
    ,"SD4":17.604
  },
  614 : {
     "Day":614
    ,"SD4neg":7.158
    ,"SD3neg":8.125
    ,"SD2neg":9.092
    ,"SD1neg":10.173
    ,"SD0":11.381
    ,"SD1":12.732
    ,"SD2":14.242
    ,"SD3":15.929
    ,"SD4":17.616
  },
  615 : {
     "Day":615
    ,"SD4neg":7.162
    ,"SD3neg":8.129
    ,"SD2neg":9.097
    ,"SD1neg":10.179
    ,"SD0":11.388
    ,"SD1":12.739
    ,"SD2":14.250
    ,"SD3":15.939
    ,"SD4":17.627
  },
  616 : {
     "Day":616
    ,"SD4neg":7.166
    ,"SD3neg":8.134
    ,"SD2neg":9.102
    ,"SD1neg":10.184
    ,"SD0":11.394
    ,"SD1":12.747
    ,"SD2":14.259
    ,"SD3":15.949
    ,"SD4":17.639
  },
  617 : {
     "Day":617
    ,"SD4neg":7.170
    ,"SD3neg":8.138
    ,"SD2neg":9.107
    ,"SD1neg":10.190
    ,"SD0":11.401
    ,"SD1":12.755
    ,"SD2":14.268
    ,"SD3":15.959
    ,"SD4":17.650
  },
  618 : {
     "Day":618
    ,"SD4neg":7.173
    ,"SD3neg":8.143
    ,"SD2neg":9.112
    ,"SD1neg":10.196
    ,"SD0":11.408
    ,"SD1":12.763
    ,"SD2":14.277
    ,"SD3":15.970
    ,"SD4":17.662
  },
  619 : {
     "Day":619
    ,"SD4neg":7.177
    ,"SD3neg":8.147
    ,"SD2neg":9.117
    ,"SD1neg":10.202
    ,"SD0":11.414
    ,"SD1":12.770
    ,"SD2":14.286
    ,"SD3":15.980
    ,"SD4":17.674
  },
  620 : {
     "Day":620
    ,"SD4neg":7.181
    ,"SD3neg":8.152
    ,"SD2neg":9.122
    ,"SD1neg":10.208
    ,"SD0":11.421
    ,"SD1":12.778
    ,"SD2":14.295
    ,"SD3":15.990
    ,"SD4":17.685
  },
  621 : {
     "Day":621
    ,"SD4neg":7.185
    ,"SD3neg":8.156
    ,"SD2neg":9.127
    ,"SD1neg":10.213
    ,"SD0":11.428
    ,"SD1":12.785
    ,"SD2":14.303
    ,"SD3":16.000
    ,"SD4":17.697
  },
  622 : {
     "Day":622
    ,"SD4neg":7.188
    ,"SD3neg":8.160
    ,"SD2neg":9.132
    ,"SD1neg":10.219
    ,"SD0":11.434
    ,"SD1":12.793
    ,"SD2":14.312
    ,"SD3":16.011
    ,"SD4":17.709
  },
  623 : {
     "Day":623
    ,"SD4neg":7.192
    ,"SD3neg":8.165
    ,"SD2neg":9.137
    ,"SD1neg":10.225
    ,"SD0":11.441
    ,"SD1":12.801
    ,"SD2":14.321
    ,"SD3":16.021
    ,"SD4":17.720
  },
  624 : {
     "Day":624
    ,"SD4neg":7.196
    ,"SD3neg":8.169
    ,"SD2neg":9.142
    ,"SD1neg":10.231
    ,"SD0":11.448
    ,"SD1":12.809
    ,"SD2":14.330
    ,"SD3":16.031
    ,"SD4":17.732
  },
  625 : {
     "Day":625
    ,"SD4neg":7.200
    ,"SD3neg":8.174
    ,"SD2neg":9.147
    ,"SD1neg":10.236
    ,"SD0":11.454
    ,"SD1":12.816
    ,"SD2":14.339
    ,"SD3":16.042
    ,"SD4":17.744
  },
  626 : {
     "Day":626
    ,"SD4neg":7.204
    ,"SD3neg":8.178
    ,"SD2neg":9.153
    ,"SD1neg":10.242
    ,"SD0":11.461
    ,"SD1":12.824
    ,"SD2":14.348
    ,"SD3":16.052
    ,"SD4":17.756
  },
  627 : {
     "Day":627
    ,"SD4neg":7.208
    ,"SD3neg":8.183
    ,"SD2neg":9.158
    ,"SD1neg":10.248
    ,"SD0":11.468
    ,"SD1":12.831
    ,"SD2":14.357
    ,"SD3":16.062
    ,"SD4":17.767
  },
  628 : {
     "Day":628
    ,"SD4neg":7.211
    ,"SD3neg":8.187
    ,"SD2neg":9.163
    ,"SD1neg":10.254
    ,"SD0":11.474
    ,"SD1":12.839
    ,"SD2":14.366
    ,"SD3":16.073
    ,"SD4":17.779
  },
  629 : {
     "Day":629
    ,"SD4neg":7.215
    ,"SD3neg":8.191
    ,"SD2neg":9.168
    ,"SD1neg":10.260
    ,"SD0":11.481
    ,"SD1":12.847
    ,"SD2":14.374
    ,"SD3":16.083
    ,"SD4":17.791
  },
  630 : {
     "Day":630
    ,"SD4neg":7.219
    ,"SD3neg":8.196
    ,"SD2neg":9.173
    ,"SD1neg":10.265
    ,"SD0":11.488
    ,"SD1":12.855
    ,"SD2":14.383
    ,"SD3":16.093
    ,"SD4":17.803
  },
  631 : {
     "Day":631
    ,"SD4neg":7.223
    ,"SD3neg":8.200
    ,"SD2neg":9.178
    ,"SD1neg":10.271
    ,"SD0":11.494
    ,"SD1":12.862
    ,"SD2":14.392
    ,"SD3":16.103
    ,"SD4":17.815
  },
  632 : {
     "Day":632
    ,"SD4neg":7.227
    ,"SD3neg":8.205
    ,"SD2neg":9.183
    ,"SD1neg":10.277
    ,"SD0":11.501
    ,"SD1":12.870
    ,"SD2":14.401
    ,"SD3":16.113
    ,"SD4":17.826
  },
  633 : {
     "Day":633
    ,"SD4neg":7.230
    ,"SD3neg":8.209
    ,"SD2neg":9.188
    ,"SD1neg":10.283
    ,"SD0":11.508
    ,"SD1":12.878
    ,"SD2":14.410
    ,"SD3":16.124
    ,"SD4":17.838
  },
  634 : {
     "Day":634
    ,"SD4neg":7.234
    ,"SD3neg":8.213
    ,"SD2neg":9.193
    ,"SD1neg":10.288
    ,"SD0":11.514
    ,"SD1":12.885
    ,"SD2":14.419
    ,"SD3":16.134
    ,"SD4":17.850
  },
  635 : {
     "Day":635
    ,"SD4neg":7.238
    ,"SD3neg":8.218
    ,"SD2neg":9.198
    ,"SD1neg":10.294
    ,"SD0":11.521
    ,"SD1":12.893
    ,"SD2":14.428
    ,"SD3":16.144
    ,"SD4":17.861
  },
  636 : {
     "Day":636
    ,"SD4neg":7.242
    ,"SD3neg":8.222
    ,"SD2neg":9.203
    ,"SD1neg":10.300
    ,"SD0":11.527
    ,"SD1":12.900
    ,"SD2":14.436
    ,"SD3":16.155
    ,"SD4":17.873
  },
  637 : {
     "Day":637
    ,"SD4neg":7.245
    ,"SD3neg":8.227
    ,"SD2neg":9.208
    ,"SD1neg":10.306
    ,"SD0":11.534
    ,"SD1":12.908
    ,"SD2":14.446
    ,"SD3":16.165
    ,"SD4":17.885
  },
  638 : {
     "Day":638
    ,"SD4neg":7.249
    ,"SD3neg":8.231
    ,"SD2neg":9.213
    ,"SD1neg":10.312
    ,"SD0":11.541
    ,"SD1":12.916
    ,"SD2":14.454
    ,"SD3":16.175
    ,"SD4":17.896
  },
  639 : {
     "Day":639
    ,"SD4neg":7.253
    ,"SD3neg":8.236
    ,"SD2neg":9.218
    ,"SD1neg":10.317
    ,"SD0":11.547
    ,"SD1":12.924
    ,"SD2":14.463
    ,"SD3":16.186
    ,"SD4":17.908
  },
  640 : {
     "Day":640
    ,"SD4neg":7.257
    ,"SD3neg":8.240
    ,"SD2neg":9.223
    ,"SD1neg":10.323
    ,"SD0":11.554
    ,"SD1":12.931
    ,"SD2":14.472
    ,"SD3":16.196
    ,"SD4":17.920
  },
  641 : {
     "Day":641
    ,"SD4neg":7.260
    ,"SD3neg":8.244
    ,"SD2neg":9.228
    ,"SD1neg":10.329
    ,"SD0":11.561
    ,"SD1":12.939
    ,"SD2":14.481
    ,"SD3":16.206
    ,"SD4":17.932
  },
  642 : {
     "Day":642
    ,"SD4neg":7.264
    ,"SD3neg":8.249
    ,"SD2neg":9.233
    ,"SD1neg":10.335
    ,"SD0":11.567
    ,"SD1":12.947
    ,"SD2":14.490
    ,"SD3":16.216
    ,"SD4":17.943
  },
  643 : {
     "Day":643
    ,"SD4neg":7.268
    ,"SD3neg":8.253
    ,"SD2neg":9.238
    ,"SD1neg":10.340
    ,"SD0":11.574
    ,"SD1":12.954
    ,"SD2":14.499
    ,"SD3":16.227
    ,"SD4":17.955
  },
  644 : {
     "Day":644
    ,"SD4neg":7.272
    ,"SD3neg":8.257
    ,"SD2neg":9.243
    ,"SD1neg":10.346
    ,"SD0":11.581
    ,"SD1":12.962
    ,"SD2":14.508
    ,"SD3":16.237
    ,"SD4":17.967
  },
  645 : {
     "Day":645
    ,"SD4neg":7.276
    ,"SD3neg":8.262
    ,"SD2neg":9.248
    ,"SD1neg":10.352
    ,"SD0":11.587
    ,"SD1":12.969
    ,"SD2":14.516
    ,"SD3":16.247
    ,"SD4":17.978
  },
  646 : {
     "Day":646
    ,"SD4neg":7.279
    ,"SD3neg":8.266
    ,"SD2neg":9.253
    ,"SD1neg":10.358
    ,"SD0":11.594
    ,"SD1":12.977
    ,"SD2":14.525
    ,"SD3":16.258
    ,"SD4":17.990
  },
  647 : {
     "Day":647
    ,"SD4neg":7.283
    ,"SD3neg":8.271
    ,"SD2neg":9.258
    ,"SD1neg":10.363
    ,"SD0":11.600
    ,"SD1":12.985
    ,"SD2":14.534
    ,"SD3":16.268
    ,"SD4":18.002
  },
  648 : {
     "Day":648
    ,"SD4neg":7.287
    ,"SD3neg":8.275
    ,"SD2neg":9.263
    ,"SD1neg":10.369
    ,"SD0":11.607
    ,"SD1":12.992
    ,"SD2":14.543
    ,"SD3":16.278
    ,"SD4":18.013
  },
  649 : {
     "Day":649
    ,"SD4neg":7.291
    ,"SD3neg":8.280
    ,"SD2neg":9.268
    ,"SD1neg":10.375
    ,"SD0":11.614
    ,"SD1":13.000
    ,"SD2":14.552
    ,"SD3":16.289
    ,"SD4":18.025
  },
  650 : {
     "Day":650
    ,"SD4neg":7.295
    ,"SD3neg":8.284
    ,"SD2neg":9.273
    ,"SD1neg":10.381
    ,"SD0":11.620
    ,"SD1":13.008
    ,"SD2":14.561
    ,"SD3":16.299
    ,"SD4":18.037
  },
  651 : {
     "Day":651
    ,"SD4neg":7.298
    ,"SD3neg":8.288
    ,"SD2neg":9.278
    ,"SD1neg":10.386
    ,"SD0":11.627
    ,"SD1":13.016
    ,"SD2":14.570
    ,"SD3":16.310
    ,"SD4":18.049
  },
  652 : {
     "Day":652
    ,"SD4neg":7.302
    ,"SD3neg":8.293
    ,"SD2neg":9.283
    ,"SD1neg":10.392
    ,"SD0":11.634
    ,"SD1":13.023
    ,"SD2":14.578
    ,"SD3":16.319
    ,"SD4":18.060
  },
  653 : {
     "Day":653
    ,"SD4neg":7.306
    ,"SD3neg":8.297
    ,"SD2neg":9.288
    ,"SD1neg":10.398
    ,"SD0":11.640
    ,"SD1":13.031
    ,"SD2":14.588
    ,"SD3":16.330
    ,"SD4":18.073
  },
  654 : {
     "Day":654
    ,"SD4neg":7.309
    ,"SD3neg":8.301
    ,"SD2neg":9.293
    ,"SD1neg":10.404
    ,"SD0":11.647
    ,"SD1":13.039
    ,"SD2":14.596
    ,"SD3":16.340
    ,"SD4":18.084
  },
  655 : {
     "Day":655
    ,"SD4neg":7.313
    ,"SD3neg":8.306
    ,"SD2neg":9.298
    ,"SD1neg":10.409
    ,"SD0":11.654
    ,"SD1":13.046
    ,"SD2":14.605
    ,"SD3":16.351
    ,"SD4":18.096
  },
  656 : {
     "Day":656
    ,"SD4neg":7.317
    ,"SD3neg":8.310
    ,"SD2neg":9.303
    ,"SD1neg":10.415
    ,"SD0":11.660
    ,"SD1":13.054
    ,"SD2":14.614
    ,"SD3":16.361
    ,"SD4":18.108
  },
  657 : {
     "Day":657
    ,"SD4neg":7.321
    ,"SD3neg":8.315
    ,"SD2neg":9.308
    ,"SD1neg":10.421
    ,"SD0":11.667
    ,"SD1":13.062
    ,"SD2":14.623
    ,"SD3":16.371
    ,"SD4":18.120
  },
  658 : {
     "Day":658
    ,"SD4neg":7.324
    ,"SD3neg":8.319
    ,"SD2neg":9.313
    ,"SD1neg":10.427
    ,"SD0":11.673
    ,"SD1":13.069
    ,"SD2":14.632
    ,"SD3":16.382
    ,"SD4":18.132
  },
  659 : {
     "Day":659
    ,"SD4neg":7.328
    ,"SD3neg":8.323
    ,"SD2neg":9.318
    ,"SD1neg":10.432
    ,"SD0":11.680
    ,"SD1":13.077
    ,"SD2":14.641
    ,"SD3":16.392
    ,"SD4":18.143
  },
  660 : {
     "Day":660
    ,"SD4neg":7.332
    ,"SD3neg":8.328
    ,"SD2neg":9.323
    ,"SD1neg":10.438
    ,"SD0":11.687
    ,"SD1":13.084
    ,"SD2":14.650
    ,"SD3":16.402
    ,"SD4":18.155
  },
  661 : {
     "Day":661
    ,"SD4neg":7.336
    ,"SD3neg":8.332
    ,"SD2neg":9.328
    ,"SD1neg":10.444
    ,"SD0":11.693
    ,"SD1":13.092
    ,"SD2":14.659
    ,"SD3":16.413
    ,"SD4":18.167
  },
  662 : {
     "Day":662
    ,"SD4neg":7.339
    ,"SD3neg":8.336
    ,"SD2neg":9.333
    ,"SD1neg":10.450
    ,"SD0":11.700
    ,"SD1":13.100
    ,"SD2":14.668
    ,"SD3":16.423
    ,"SD4":18.179
  },
  663 : {
     "Day":663
    ,"SD4neg":7.343
    ,"SD3neg":8.341
    ,"SD2neg":9.338
    ,"SD1neg":10.455
    ,"SD0":11.706
    ,"SD1":13.107
    ,"SD2":14.676
    ,"SD3":16.434
    ,"SD4":18.191
  },
  664 : {
     "Day":664
    ,"SD4neg":7.347
    ,"SD3neg":8.345
    ,"SD2neg":9.343
    ,"SD1neg":10.461
    ,"SD0":11.713
    ,"SD1":13.115
    ,"SD2":14.685
    ,"SD3":16.444
    ,"SD4":18.202
  },
  665 : {
     "Day":665
    ,"SD4neg":7.351
    ,"SD3neg":8.350
    ,"SD2neg":9.348
    ,"SD1neg":10.467
    ,"SD0":11.720
    ,"SD1":13.123
    ,"SD2":14.694
    ,"SD3":16.454
    ,"SD4":18.214
  },
  666 : {
     "Day":666
    ,"SD4neg":7.354
    ,"SD3neg":8.354
    ,"SD2neg":9.353
    ,"SD1neg":10.473
    ,"SD0":11.726
    ,"SD1":13.130
    ,"SD2":14.703
    ,"SD3":16.464
    ,"SD4":18.226
  },
  667 : {
     "Day":667
    ,"SD4neg":7.358
    ,"SD3neg":8.358
    ,"SD2neg":9.358
    ,"SD1neg":10.478
    ,"SD0":11.733
    ,"SD1":13.138
    ,"SD2":14.712
    ,"SD3":16.475
    ,"SD4":18.238
  },
  668 : {
     "Day":668
    ,"SD4neg":7.362
    ,"SD3neg":8.363
    ,"SD2neg":9.363
    ,"SD1neg":10.484
    ,"SD0":11.740
    ,"SD1":13.146
    ,"SD2":14.721
    ,"SD3":16.485
    ,"SD4":18.249
  },
  669 : {
     "Day":669
    ,"SD4neg":7.366
    ,"SD3neg":8.367
    ,"SD2neg":9.368
    ,"SD1neg":10.490
    ,"SD0":11.746
    ,"SD1":13.153
    ,"SD2":14.730
    ,"SD3":16.495
    ,"SD4":18.261
  },
  670 : {
     "Day":670
    ,"SD4neg":7.369
    ,"SD3neg":8.371
    ,"SD2neg":9.373
    ,"SD1neg":10.496
    ,"SD0":11.753
    ,"SD1":13.161
    ,"SD2":14.739
    ,"SD3":16.506
    ,"SD4":18.273
  },
  671 : {
     "Day":671
    ,"SD4neg":7.373
    ,"SD3neg":8.376
    ,"SD2neg":9.378
    ,"SD1neg":10.501
    ,"SD0":11.760
    ,"SD1":13.169
    ,"SD2":14.748
    ,"SD3":16.516
    ,"SD4":18.285
  },
  672 : {
     "Day":672
    ,"SD4neg":7.377
    ,"SD3neg":8.380
    ,"SD2neg":9.383
    ,"SD1neg":10.507
    ,"SD0":11.766
    ,"SD1":13.176
    ,"SD2":14.756
    ,"SD3":16.526
    ,"SD4":18.296
  },
  673 : {
     "Day":673
    ,"SD4neg":7.381
    ,"SD3neg":8.384
    ,"SD2neg":9.388
    ,"SD1neg":10.513
    ,"SD0":11.773
    ,"SD1":13.184
    ,"SD2":14.765
    ,"SD3":16.537
    ,"SD4":18.308
  },
  674 : {
     "Day":674
    ,"SD4neg":7.384
    ,"SD3neg":8.389
    ,"SD2neg":9.393
    ,"SD1neg":10.519
    ,"SD0":11.779
    ,"SD1":13.192
    ,"SD2":14.774
    ,"SD3":16.547
    ,"SD4":18.320
  },
  675 : {
     "Day":675
    ,"SD4neg":7.388
    ,"SD3neg":8.393
    ,"SD2neg":9.398
    ,"SD1neg":10.524
    ,"SD0":11.786
    ,"SD1":13.199
    ,"SD2":14.783
    ,"SD3":16.558
    ,"SD4":18.332
  },
  676 : {
     "Day":676
    ,"SD4neg":7.392
    ,"SD3neg":8.397
    ,"SD2neg":9.403
    ,"SD1neg":10.530
    ,"SD0":11.792
    ,"SD1":13.207
    ,"SD2":14.792
    ,"SD3":16.568
    ,"SD4":18.344
  },
  677 : {
     "Day":677
    ,"SD4neg":7.395
    ,"SD3neg":8.402
    ,"SD2neg":9.408
    ,"SD1neg":10.536
    ,"SD0":11.799
    ,"SD1":13.215
    ,"SD2":14.801
    ,"SD3":16.578
    ,"SD4":18.355
  },
  678 : {
     "Day":678
    ,"SD4neg":7.399
    ,"SD3neg":8.406
    ,"SD2neg":9.413
    ,"SD1neg":10.542
    ,"SD0":11.806
    ,"SD1":13.222
    ,"SD2":14.810
    ,"SD3":16.588
    ,"SD4":18.367
  },
  679 : {
     "Day":679
    ,"SD4neg":7.403
    ,"SD3neg":8.410
    ,"SD2neg":9.418
    ,"SD1neg":10.547
    ,"SD0":11.812
    ,"SD1":13.230
    ,"SD2":14.819
    ,"SD3":16.599
    ,"SD4":18.379
  },
  680 : {
     "Day":680
    ,"SD4neg":7.406
    ,"SD3neg":8.415
    ,"SD2neg":9.423
    ,"SD1neg":10.553
    ,"SD0":11.819
    ,"SD1":13.238
    ,"SD2":14.828
    ,"SD3":16.609
    ,"SD4":18.391
  },
  681 : {
     "Day":681
    ,"SD4neg":7.410
    ,"SD3neg":8.419
    ,"SD2neg":9.428
    ,"SD1neg":10.559
    ,"SD0":11.826
    ,"SD1":13.245
    ,"SD2":14.837
    ,"SD3":16.620
    ,"SD4":18.403
  },
  682 : {
     "Day":682
    ,"SD4neg":7.414
    ,"SD3neg":8.424
    ,"SD2neg":9.433
    ,"SD1neg":10.564
    ,"SD0":11.832
    ,"SD1":13.253
    ,"SD2":14.845
    ,"SD3":16.630
    ,"SD4":18.415
  },
  683 : {
     "Day":683
    ,"SD4neg":7.418
    ,"SD3neg":8.428
    ,"SD2neg":9.438
    ,"SD1neg":10.570
    ,"SD0":11.839
    ,"SD1":13.261
    ,"SD2":14.854
    ,"SD3":16.640
    ,"SD4":18.426
  },
  684 : {
     "Day":684
    ,"SD4neg":7.421
    ,"SD3neg":8.432
    ,"SD2neg":9.443
    ,"SD1neg":10.576
    ,"SD0":11.845
    ,"SD1":13.268
    ,"SD2":14.863
    ,"SD3":16.651
    ,"SD4":18.438
  },
  685 : {
     "Day":685
    ,"SD4neg":7.425
    ,"SD3neg":8.436
    ,"SD2neg":9.448
    ,"SD1neg":10.582
    ,"SD0":11.852
    ,"SD1":13.276
    ,"SD2":14.872
    ,"SD3":16.661
    ,"SD4":18.450
  },
  686 : {
     "Day":686
    ,"SD4neg":7.429
    ,"SD3neg":8.441
    ,"SD2neg":9.453
    ,"SD1neg":10.587
    ,"SD0":11.859
    ,"SD1":13.284
    ,"SD2":14.881
    ,"SD3":16.672
    ,"SD4":18.462
  },
  687 : {
     "Day":687
    ,"SD4neg":7.433
    ,"SD3neg":8.445
    ,"SD2neg":9.458
    ,"SD1neg":10.593
    ,"SD0":11.865
    ,"SD1":13.291
    ,"SD2":14.890
    ,"SD3":16.682
    ,"SD4":18.474
  },
  688 : {
     "Day":688
    ,"SD4neg":7.436
    ,"SD3neg":8.450
    ,"SD2neg":9.463
    ,"SD1neg":10.599
    ,"SD0":11.872
    ,"SD1":13.299
    ,"SD2":14.899
    ,"SD3":16.692
    ,"SD4":18.485
  },
  689 : {
     "Day":689
    ,"SD4neg":7.440
    ,"SD3neg":8.454
    ,"SD2neg":9.468
    ,"SD1neg":10.604
    ,"SD0":11.878
    ,"SD1":13.306
    ,"SD2":14.907
    ,"SD3":16.702
    ,"SD4":18.497
  },
  690 : {
     "Day":690
    ,"SD4neg":7.443
    ,"SD3neg":8.458
    ,"SD2neg":9.473
    ,"SD1neg":10.610
    ,"SD0":11.885
    ,"SD1":13.314
    ,"SD2":14.916
    ,"SD3":16.713
    ,"SD4":18.509
  },
  691 : {
     "Day":691
    ,"SD4neg":7.447
    ,"SD3neg":8.462
    ,"SD2neg":9.478
    ,"SD1neg":10.616
    ,"SD0":11.892
    ,"SD1":13.322
    ,"SD2":14.925
    ,"SD3":16.723
    ,"SD4":18.521
  },
  692 : {
     "Day":692
    ,"SD4neg":7.451
    ,"SD3neg":8.467
    ,"SD2neg":9.483
    ,"SD1neg":10.622
    ,"SD0":11.898
    ,"SD1":13.329
    ,"SD2":14.934
    ,"SD3":16.733
    ,"SD4":18.533
  },
  693 : {
     "Day":693
    ,"SD4neg":7.455
    ,"SD3neg":8.471
    ,"SD2neg":9.488
    ,"SD1neg":10.627
    ,"SD0":11.905
    ,"SD1":13.337
    ,"SD2":14.943
    ,"SD3":16.744
    ,"SD4":18.545
  },
  694 : {
     "Day":694
    ,"SD4neg":7.458
    ,"SD3neg":8.475
    ,"SD2neg":9.493
    ,"SD1neg":10.633
    ,"SD0":11.911
    ,"SD1":13.345
    ,"SD2":14.952
    ,"SD3":16.754
    ,"SD4":18.557
  },
  695 : {
     "Day":695
    ,"SD4neg":7.462
    ,"SD3neg":8.480
    ,"SD2neg":9.498
    ,"SD1neg":10.639
    ,"SD0":11.918
    ,"SD1":13.352
    ,"SD2":14.961
    ,"SD3":16.765
    ,"SD4":18.569
  },
  696 : {
     "Day":696
    ,"SD4neg":7.465
    ,"SD3neg":8.484
    ,"SD2neg":9.503
    ,"SD1neg":10.644
    ,"SD0":11.925
    ,"SD1":13.360
    ,"SD2":14.970
    ,"SD3":16.775
    ,"SD4":18.581
  },
  697 : {
     "Day":697
    ,"SD4neg":7.469
    ,"SD3neg":8.488
    ,"SD2neg":9.507
    ,"SD1neg":10.650
    ,"SD0":11.931
    ,"SD1":13.368
    ,"SD2":14.979
    ,"SD3":16.786
    ,"SD4":18.593
  },
  698 : {
     "Day":698
    ,"SD4neg":7.473
    ,"SD3neg":8.493
    ,"SD2neg":9.513
    ,"SD1neg":10.656
    ,"SD0":11.938
    ,"SD1":13.375
    ,"SD2":14.987
    ,"SD3":16.796
    ,"SD4":18.604
  },
  699 : {
     "Day":699
    ,"SD4neg":7.477
    ,"SD3neg":8.497
    ,"SD2neg":9.517
    ,"SD1neg":10.662
    ,"SD0":11.944
    ,"SD1":13.383
    ,"SD2":14.996
    ,"SD3":16.806
    ,"SD4":18.616
  },
  700 : {
     "Day":700
    ,"SD4neg":7.480
    ,"SD3neg":8.501
    ,"SD2neg":9.522
    ,"SD1neg":10.667
    ,"SD0":11.951
    ,"SD1":13.391
    ,"SD2":15.005
    ,"SD3":16.817
    ,"SD4":18.628
  },
  701 : {
     "Day":701
    ,"SD4neg":7.484
    ,"SD3neg":8.506
    ,"SD2neg":9.527
    ,"SD1neg":10.673
    ,"SD0":11.958
    ,"SD1":13.398
    ,"SD2":15.014
    ,"SD3":16.827
    ,"SD4":18.640
  },
  702 : {
     "Day":702
    ,"SD4neg":7.488
    ,"SD3neg":8.510
    ,"SD2neg":9.532
    ,"SD1neg":10.679
    ,"SD0":11.964
    ,"SD1":13.406
    ,"SD2":15.023
    ,"SD3":16.838
    ,"SD4":18.652
  },
  703 : {
     "Day":703
    ,"SD4neg":7.491
    ,"SD3neg":8.514
    ,"SD2neg":9.537
    ,"SD1neg":10.684
    ,"SD0":11.971
    ,"SD1":13.414
    ,"SD2":15.032
    ,"SD3":16.848
    ,"SD4":18.664
  },
  704 : {
     "Day":704
    ,"SD4neg":7.495
    ,"SD3neg":8.519
    ,"SD2neg":9.542
    ,"SD1neg":10.690
    ,"SD0":11.977
    ,"SD1":13.421
    ,"SD2":15.041
    ,"SD3":16.858
    ,"SD4":18.675
  },
  705 : {
     "Day":705
    ,"SD4neg":7.499
    ,"SD3neg":8.523
    ,"SD2neg":9.547
    ,"SD1neg":10.696
    ,"SD0":11.984
    ,"SD1":13.429
    ,"SD2":15.050
    ,"SD3":16.868
    ,"SD4":18.687
  },
  706 : {
     "Day":706
    ,"SD4neg":7.502
    ,"SD3neg":8.527
    ,"SD2neg":9.552
    ,"SD1neg":10.701
    ,"SD0":11.990
    ,"SD1":13.437
    ,"SD2":15.059
    ,"SD3":16.879
    ,"SD4":18.699
  },
  707 : {
     "Day":707
    ,"SD4neg":7.506
    ,"SD3neg":8.531
    ,"SD2neg":9.557
    ,"SD1neg":10.707
    ,"SD0":11.997
    ,"SD1":13.444
    ,"SD2":15.068
    ,"SD3":16.889
    ,"SD4":18.711
  },
  708 : {
     "Day":708
    ,"SD4neg":7.510
    ,"SD3neg":8.536
    ,"SD2neg":9.562
    ,"SD1neg":10.713
    ,"SD0":12.004
    ,"SD1":13.452
    ,"SD2":15.077
    ,"SD3":16.900
    ,"SD4":18.723
  },
  709 : {
     "Day":709
    ,"SD4neg":7.513
    ,"SD3neg":8.540
    ,"SD2neg":9.567
    ,"SD1neg":10.718
    ,"SD0":12.010
    ,"SD1":13.460
    ,"SD2":15.086
    ,"SD3":16.910
    ,"SD4":18.735
  },
  710 : {
     "Day":710
    ,"SD4neg":7.517
    ,"SD3neg":8.544
    ,"SD2neg":9.572
    ,"SD1neg":10.724
    ,"SD0":12.017
    ,"SD1":13.467
    ,"SD2":15.094
    ,"SD3":16.921
    ,"SD4":18.747
  },
  711 : {
     "Day":711
    ,"SD4neg":7.521
    ,"SD3neg":8.549
    ,"SD2neg":9.577
    ,"SD1neg":10.730
    ,"SD0":12.023
    ,"SD1":13.475
    ,"SD2":15.103
    ,"SD3":16.931
    ,"SD4":18.758
  },
  712 : {
     "Day":712
    ,"SD4neg":7.524
    ,"SD3neg":8.553
    ,"SD2neg":9.582
    ,"SD1neg":10.736
    ,"SD0":12.030
    ,"SD1":13.482
    ,"SD2":15.112
    ,"SD3":16.941
    ,"SD4":18.770
  },
  713 : {
     "Day":713
    ,"SD4neg":7.528
    ,"SD3neg":8.557
    ,"SD2neg":9.587
    ,"SD1neg":10.741
    ,"SD0":12.037
    ,"SD1":13.490
    ,"SD2":15.121
    ,"SD3":16.952
    ,"SD4":18.782
  },
  714 : {
     "Day":714
    ,"SD4neg":7.531
    ,"SD3neg":8.561
    ,"SD2neg":9.591
    ,"SD1neg":10.747
    ,"SD0":12.043
    ,"SD1":13.498
    ,"SD2":15.130
    ,"SD3":16.962
    ,"SD4":18.794
  },
  715 : {
     "Day":715
    ,"SD4neg":7.535
    ,"SD3neg":8.566
    ,"SD2neg":9.596
    ,"SD1neg":10.753
    ,"SD0":12.050
    ,"SD1":13.505
    ,"SD2":15.139
    ,"SD3":16.972
    ,"SD4":18.806
  },
  716 : {
     "Day":716
    ,"SD4neg":7.539
    ,"SD3neg":8.570
    ,"SD2neg":9.601
    ,"SD1neg":10.758
    ,"SD0":12.056
    ,"SD1":13.513
    ,"SD2":15.148
    ,"SD3":16.983
    ,"SD4":18.818
  },
  717 : {
     "Day":717
    ,"SD4neg":7.542
    ,"SD3neg":8.574
    ,"SD2neg":9.606
    ,"SD1neg":10.764
    ,"SD0":12.063
    ,"SD1":13.521
    ,"SD2":15.157
    ,"SD3":16.993
    ,"SD4":18.830
  },
  718 : {
     "Day":718
    ,"SD4neg":7.546
    ,"SD3neg":8.578
    ,"SD2neg":9.611
    ,"SD1neg":10.769
    ,"SD0":12.069
    ,"SD1":13.528
    ,"SD2":15.166
    ,"SD3":17.004
    ,"SD4":18.842
  },
  719 : {
     "Day":719
    ,"SD4neg":7.550
    ,"SD3neg":8.583
    ,"SD2neg":9.616
    ,"SD1neg":10.775
    ,"SD0":12.076
    ,"SD1":13.536
    ,"SD2":15.174
    ,"SD3":17.014
    ,"SD4":18.853
  },
  720 : {
     "Day":720
    ,"SD4neg":7.553
    ,"SD3neg":8.587
    ,"SD2neg":9.621
    ,"SD1neg":10.781
    ,"SD0":12.083
    ,"SD1":13.543
    ,"SD2":15.183
    ,"SD3":17.024
    ,"SD4":18.865
  },
  721 : {
     "Day":721
    ,"SD4neg":7.557
    ,"SD3neg":8.591
    ,"SD2neg":9.626
    ,"SD1neg":10.787
    ,"SD0":12.089
    ,"SD1":13.551
    ,"SD2":15.192
    ,"SD3":17.035
    ,"SD4":18.877
  },
  722 : {
     "Day":722
    ,"SD4neg":7.561
    ,"SD3neg":8.596
    ,"SD2neg":9.631
    ,"SD1neg":10.792
    ,"SD0":12.096
    ,"SD1":13.559
    ,"SD2":15.201
    ,"SD3":17.045
    ,"SD4":18.889
  },
  723 : {
     "Day":723
    ,"SD4neg":7.564
    ,"SD3neg":8.600
    ,"SD2neg":9.636
    ,"SD1neg":10.798
    ,"SD0":12.102
    ,"SD1":13.566
    ,"SD2":15.210
    ,"SD3":17.056
    ,"SD4":18.901
  },
  724 : {
     "Day":724
    ,"SD4neg":7.568
    ,"SD3neg":8.604
    ,"SD2neg":9.641
    ,"SD1neg":10.804
    ,"SD0":12.109
    ,"SD1":13.574
    ,"SD2":15.219
    ,"SD3":17.066
    ,"SD4":18.913
  },
  725 : {
     "Day":725
    ,"SD4neg":7.571
    ,"SD3neg":8.608
    ,"SD2neg":9.645
    ,"SD1neg":10.809
    ,"SD0":12.115
    ,"SD1":13.582
    ,"SD2":15.228
    ,"SD3":17.077
    ,"SD4":18.925
  },
  726 : {
     "Day":726
    ,"SD4neg":7.575
    ,"SD3neg":8.613
    ,"SD2neg":9.650
    ,"SD1neg":10.815
    ,"SD0":12.122
    ,"SD1":13.589
    ,"SD2":15.237
    ,"SD3":17.087
    ,"SD4":18.937
  },
  727 : {
     "Day":727
    ,"SD4neg":7.579
    ,"SD3neg":8.617
    ,"SD2neg":9.655
    ,"SD1neg":10.821
    ,"SD0":12.128
    ,"SD1":13.597
    ,"SD2":15.246
    ,"SD3":17.097
    ,"SD4":18.949
  },
  728 : {
     "Day":728
    ,"SD4neg":7.582
    ,"SD3neg":8.621
    ,"SD2neg":9.660
    ,"SD1neg":10.826
    ,"SD0":12.135
    ,"SD1":13.604
    ,"SD2":15.254
    ,"SD3":17.107
    ,"SD4":18.960
  },
  729 : {
     "Day":729
    ,"SD4neg":7.586
    ,"SD3neg":8.626
    ,"SD2neg":9.665
    ,"SD1neg":10.832
    ,"SD0":12.142
    ,"SD1":13.612
    ,"SD2":15.263
    ,"SD3":17.118
    ,"SD4":18.972
  },
  730 : {
     "Day":730
    ,"SD4neg":7.590
    ,"SD3neg":8.630
    ,"SD2neg":9.670
    ,"SD1neg":10.838
    ,"SD0":12.148
    ,"SD1":13.620
    ,"SD2":15.272
    ,"SD3":17.128
    ,"SD4":18.984
  },
  731 : {
     "Day":731
    ,"SD4neg":7.593
    ,"SD3neg":8.634
    ,"SD2neg":9.675
    ,"SD1neg":10.843
    ,"SD0":12.155
    ,"SD1":13.627
    ,"SD2":15.281
    ,"SD3":17.139
    ,"SD4":18.996
  },
  732 : {
     "Day":732
    ,"SD4neg":7.597
    ,"SD3neg":8.638
    ,"SD2neg":9.680
    ,"SD1neg":10.849
    ,"SD0":12.161
    ,"SD1":13.635
    ,"SD2":15.290
    ,"SD3":17.149
    ,"SD4":19.008
  },
  733 : {
     "Day":733
    ,"SD4neg":7.600
    ,"SD3neg":8.643
    ,"SD2neg":9.685
    ,"SD1neg":10.855
    ,"SD0":12.168
    ,"SD1":13.643
    ,"SD2":15.299
    ,"SD3":17.160
    ,"SD4":19.020
  },
  734 : {
     "Day":734
    ,"SD4neg":7.604
    ,"SD3neg":8.647
    ,"SD2neg":9.690
    ,"SD1neg":10.860
    ,"SD0":12.174
    ,"SD1":13.650
    ,"SD2":15.308
    ,"SD3":17.170
    ,"SD4":19.032
  },
  735 : {
     "Day":735
    ,"SD4neg":7.608
    ,"SD3neg":8.651
    ,"SD2neg":9.694
    ,"SD1neg":10.866
    ,"SD0":12.181
    ,"SD1":13.658
    ,"SD2":15.317
    ,"SD3":17.181
    ,"SD4":19.044
  },
  736 : {
     "Day":736
    ,"SD4neg":7.611
    ,"SD3neg":8.655
    ,"SD2neg":9.699
    ,"SD1neg":10.871
    ,"SD0":12.188
    ,"SD1":13.666
    ,"SD2":15.326
    ,"SD3":17.191
    ,"SD4":19.056
  },
  737 : {
     "Day":737
    ,"SD4neg":7.615
    ,"SD3neg":8.659
    ,"SD2neg":9.704
    ,"SD1neg":10.877
    ,"SD0":12.194
    ,"SD1":13.673
    ,"SD2":15.335
    ,"SD3":17.202
    ,"SD4":19.068
  },
  738 : {
     "Day":738
    ,"SD4neg":7.619
    ,"SD3neg":8.664
    ,"SD2neg":9.709
    ,"SD1neg":10.883
    ,"SD0":12.201
    ,"SD1":13.681
    ,"SD2":15.343
    ,"SD3":17.211
    ,"SD4":19.079
  },
  739 : {
     "Day":739
    ,"SD4neg":7.622
    ,"SD3neg":8.668
    ,"SD2neg":9.714
    ,"SD1neg":10.888
    ,"SD0":12.207
    ,"SD1":13.688
    ,"SD2":15.352
    ,"SD3":17.222
    ,"SD4":19.091
  },
  740 : {
     "Day":740
    ,"SD4neg":7.626
    ,"SD3neg":8.672
    ,"SD2neg":9.719
    ,"SD1neg":10.894
    ,"SD0":12.214
    ,"SD1":13.696
    ,"SD2":15.361
    ,"SD3":17.232
    ,"SD4":19.103
  },
  741 : {
     "Day":741
    ,"SD4neg":7.629
    ,"SD3neg":8.677
    ,"SD2neg":9.724
    ,"SD1neg":10.900
    ,"SD0":12.220
    ,"SD1":13.704
    ,"SD2":15.370
    ,"SD3":17.243
    ,"SD4":19.115
  },
  742 : {
     "Day":742
    ,"SD4neg":7.633
    ,"SD3neg":8.681
    ,"SD2neg":9.729
    ,"SD1neg":10.905
    ,"SD0":12.227
    ,"SD1":13.711
    ,"SD2":15.379
    ,"SD3":17.253
    ,"SD4":19.127
  },
  743 : {
     "Day":743
    ,"SD4neg":7.636
    ,"SD3neg":8.685
    ,"SD2neg":9.734
    ,"SD1neg":10.911
    ,"SD0":12.233
    ,"SD1":13.719
    ,"SD2":15.388
    ,"SD3":17.264
    ,"SD4":19.139
  },
  744 : {
     "Day":744
    ,"SD4neg":7.640
    ,"SD3neg":8.689
    ,"SD2neg":9.738
    ,"SD1neg":10.917
    ,"SD0":12.240
    ,"SD1":13.726
    ,"SD2":15.397
    ,"SD3":17.274
    ,"SD4":19.151
  },
  745 : {
     "Day":745
    ,"SD4neg":7.644
    ,"SD3neg":8.693
    ,"SD2neg":9.743
    ,"SD1neg":10.922
    ,"SD0":12.246
    ,"SD1":13.734
    ,"SD2":15.406
    ,"SD3":17.285
    ,"SD4":19.163
  },
  746 : {
     "Day":746
    ,"SD4neg":7.647
    ,"SD3neg":8.698
    ,"SD2neg":9.748
    ,"SD1neg":10.928
    ,"SD0":12.253
    ,"SD1":13.742
    ,"SD2":15.415
    ,"SD3":17.295
    ,"SD4":19.175
  },
  747 : {
     "Day":747
    ,"SD4neg":7.651
    ,"SD3neg":8.702
    ,"SD2neg":9.753
    ,"SD1neg":10.933
    ,"SD0":12.259
    ,"SD1":13.749
    ,"SD2":15.423
    ,"SD3":17.305
    ,"SD4":19.187
  },
  748 : {
     "Day":748
    ,"SD4neg":7.654
    ,"SD3neg":8.706
    ,"SD2neg":9.758
    ,"SD1neg":10.939
    ,"SD0":12.266
    ,"SD1":13.757
    ,"SD2":15.432
    ,"SD3":17.316
    ,"SD4":19.199
  },
  749 : {
     "Day":749
    ,"SD4neg":7.658
    ,"SD3neg":8.710
    ,"SD2neg":9.763
    ,"SD1neg":10.945
    ,"SD0":12.272
    ,"SD1":13.764
    ,"SD2":15.441
    ,"SD3":17.326
    ,"SD4":19.211
  },
  750 : {
     "Day":750
    ,"SD4neg":7.661
    ,"SD3neg":8.714
    ,"SD2neg":9.767
    ,"SD1neg":10.950
    ,"SD0":12.279
    ,"SD1":13.772
    ,"SD2":15.450
    ,"SD3":17.337
    ,"SD4":19.223
  },
  751 : {
     "Day":751
    ,"SD4neg":7.665
    ,"SD3neg":8.719
    ,"SD2neg":9.772
    ,"SD1neg":10.956
    ,"SD0":12.286
    ,"SD1":13.780
    ,"SD2":15.459
    ,"SD3":17.347
    ,"SD4":19.234
  },
  752 : {
     "Day":752
    ,"SD4neg":7.669
    ,"SD3neg":8.723
    ,"SD2neg":9.777
    ,"SD1neg":10.962
    ,"SD0":12.292
    ,"SD1":13.787
    ,"SD2":15.468
    ,"SD3":17.357
    ,"SD4":19.246
  },
  753 : {
     "Day":753
    ,"SD4neg":7.672
    ,"SD3neg":8.727
    ,"SD2neg":9.782
    ,"SD1neg":10.967
    ,"SD0":12.299
    ,"SD1":13.795
    ,"SD2":15.477
    ,"SD3":17.367
    ,"SD4":19.258
  },
  754 : {
     "Day":754
    ,"SD4neg":7.676
    ,"SD3neg":8.731
    ,"SD2neg":9.787
    ,"SD1neg":10.973
    ,"SD0":12.305
    ,"SD1":13.802
    ,"SD2":15.485
    ,"SD3":17.378
    ,"SD4":19.270
  },
  755 : {
     "Day":755
    ,"SD4neg":7.679
    ,"SD3neg":8.736
    ,"SD2neg":9.792
    ,"SD1neg":10.978
    ,"SD0":12.312
    ,"SD1":13.810
    ,"SD2":15.494
    ,"SD3":17.388
    ,"SD4":19.282
  },
  756 : {
     "Day":756
    ,"SD4neg":7.683
    ,"SD3neg":8.740
    ,"SD2neg":9.797
    ,"SD1neg":10.984
    ,"SD0":12.318
    ,"SD1":13.818
    ,"SD2":15.503
    ,"SD3":17.399
    ,"SD4":19.294
  },
  757 : {
     "Day":757
    ,"SD4neg":7.686
    ,"SD3neg":8.744
    ,"SD2neg":9.801
    ,"SD1neg":10.990
    ,"SD0":12.325
    ,"SD1":13.825
    ,"SD2":15.512
    ,"SD3":17.409
    ,"SD4":19.306
  },
  758 : {
     "Day":758
    ,"SD4neg":7.690
    ,"SD3neg":8.748
    ,"SD2neg":9.806
    ,"SD1neg":10.995
    ,"SD0":12.331
    ,"SD1":13.833
    ,"SD2":15.521
    ,"SD3":17.419
    ,"SD4":19.318
  },
  759 : {
     "Day":759
    ,"SD4neg":7.693
    ,"SD3neg":8.752
    ,"SD2neg":9.811
    ,"SD1neg":11.001
    ,"SD0":12.338
    ,"SD1":13.840
    ,"SD2":15.530
    ,"SD3":17.430
    ,"SD4":19.330
  },
  760 : {
     "Day":760
    ,"SD4neg":7.697
    ,"SD3neg":8.756
    ,"SD2neg":9.816
    ,"SD1neg":11.006
    ,"SD0":12.344
    ,"SD1":13.848
    ,"SD2":15.539
    ,"SD3":17.440
    ,"SD4":19.342
  },
  761 : {
     "Day":761
    ,"SD4neg":7.701
    ,"SD3neg":8.761
    ,"SD2neg":9.821
    ,"SD1neg":11.012
    ,"SD0":12.351
    ,"SD1":13.855
    ,"SD2":15.548
    ,"SD3":17.451
    ,"SD4":19.354
  },
  762 : {
     "Day":762
    ,"SD4neg":7.704
    ,"SD3neg":8.765
    ,"SD2neg":9.826
    ,"SD1neg":11.018
    ,"SD0":12.357
    ,"SD1":13.863
    ,"SD2":15.556
    ,"SD3":17.461
    ,"SD4":19.366
  },
  763 : {
     "Day":763
    ,"SD4neg":7.708
    ,"SD3neg":8.769
    ,"SD2neg":9.830
    ,"SD1neg":11.023
    ,"SD0":12.364
    ,"SD1":13.871
    ,"SD2":15.565
    ,"SD3":17.472
    ,"SD4":19.378
  },
  764 : {
     "Day":764
    ,"SD4neg":7.711
    ,"SD3neg":8.773
    ,"SD2neg":9.835
    ,"SD1neg":11.029
    ,"SD0":12.370
    ,"SD1":13.878
    ,"SD2":15.574
    ,"SD3":17.482
    ,"SD4":19.390
  },
  765 : {
     "Day":765
    ,"SD4neg":7.715
    ,"SD3neg":8.777
    ,"SD2neg":9.840
    ,"SD1neg":11.034
    ,"SD0":12.377
    ,"SD1":13.886
    ,"SD2":15.583
    ,"SD3":17.492
    ,"SD4":19.402
  },
  766 : {
     "Day":766
    ,"SD4neg":7.718
    ,"SD3neg":8.781
    ,"SD2neg":9.845
    ,"SD1neg":11.040
    ,"SD0":12.383
    ,"SD1":13.893
    ,"SD2":15.592
    ,"SD3":17.503
    ,"SD4":19.413
  },
  767 : {
     "Day":767
    ,"SD4neg":7.722
    ,"SD3neg":8.786
    ,"SD2neg":9.850
    ,"SD1neg":11.045
    ,"SD0":12.390
    ,"SD1":13.901
    ,"SD2":15.601
    ,"SD3":17.513
    ,"SD4":19.425
  },
  768 : {
     "Day":768
    ,"SD4neg":7.726
    ,"SD3neg":8.790
    ,"SD2neg":9.855
    ,"SD1neg":11.051
    ,"SD0":12.396
    ,"SD1":13.908
    ,"SD2":15.609
    ,"SD3":17.523
    ,"SD4":19.437
  },
  769 : {
     "Day":769
    ,"SD4neg":7.729
    ,"SD3neg":8.794
    ,"SD2neg":9.859
    ,"SD1neg":11.057
    ,"SD0":12.402
    ,"SD1":13.916
    ,"SD2":15.618
    ,"SD3":17.533
    ,"SD4":19.449
  },
  770 : {
     "Day":770
    ,"SD4neg":7.733
    ,"SD3neg":8.798
    ,"SD2neg":9.864
    ,"SD1neg":11.062
    ,"SD0":12.409
    ,"SD1":13.923
    ,"SD2":15.627
    ,"SD3":17.544
    ,"SD4":19.461
  },
  771 : {
     "Day":771
    ,"SD4neg":7.736
    ,"SD3neg":8.803
    ,"SD2neg":9.869
    ,"SD1neg":11.068
    ,"SD0":12.415
    ,"SD1":13.931
    ,"SD2":15.636
    ,"SD3":17.554
    ,"SD4":19.472
  },
  772 : {
     "Day":772
    ,"SD4neg":7.739
    ,"SD3neg":8.807
    ,"SD2neg":9.874
    ,"SD1neg":11.073
    ,"SD0":12.422
    ,"SD1":13.939
    ,"SD2":15.645
    ,"SD3":17.565
    ,"SD4":19.484
  },
  773 : {
     "Day":773
    ,"SD4neg":7.743
    ,"SD3neg":8.811
    ,"SD2neg":9.879
    ,"SD1neg":11.079
    ,"SD0":12.428
    ,"SD1":13.946
    ,"SD2":15.654
    ,"SD3":17.575
    ,"SD4":19.496
  },
  774 : {
     "Day":774
    ,"SD4neg":7.747
    ,"SD3neg":8.815
    ,"SD2neg":9.883
    ,"SD1neg":11.084
    ,"SD0":12.435
    ,"SD1":13.954
    ,"SD2":15.662
    ,"SD3":17.585
    ,"SD4":19.508
  },
  775 : {
     "Day":775
    ,"SD4neg":7.750
    ,"SD3neg":8.819
    ,"SD2neg":9.888
    ,"SD1neg":11.090
    ,"SD0":12.441
    ,"SD1":13.961
    ,"SD2":15.671
    ,"SD3":17.596
    ,"SD4":19.520
  },
  776 : {
     "Day":776
    ,"SD4neg":7.753
    ,"SD3neg":8.823
    ,"SD2neg":9.893
    ,"SD1neg":11.095
    ,"SD0":12.448
    ,"SD1":13.969
    ,"SD2":15.680
    ,"SD3":17.606
    ,"SD4":19.532
  },
  777 : {
     "Day":777
    ,"SD4neg":7.757
    ,"SD3neg":8.827
    ,"SD2neg":9.898
    ,"SD1neg":11.101
    ,"SD0":12.454
    ,"SD1":13.976
    ,"SD2":15.689
    ,"SD3":17.616
    ,"SD4":19.544
  },
  778 : {
     "Day":778
    ,"SD4neg":7.760
    ,"SD3neg":8.831
    ,"SD2neg":9.902
    ,"SD1neg":11.107
    ,"SD0":12.461
    ,"SD1":13.984
    ,"SD2":15.698
    ,"SD3":17.627
    ,"SD4":19.556
  },
  779 : {
     "Day":779
    ,"SD4neg":7.764
    ,"SD3neg":8.836
    ,"SD2neg":9.907
    ,"SD1neg":11.112
    ,"SD0":12.467
    ,"SD1":13.991
    ,"SD2":15.707
    ,"SD3":17.637
    ,"SD4":19.568
  },
  780 : {
     "Day":780
    ,"SD4neg":7.767
    ,"SD3neg":8.840
    ,"SD2neg":9.912
    ,"SD1neg":11.118
    ,"SD0":12.474
    ,"SD1":13.999
    ,"SD2":15.715
    ,"SD3":17.647
    ,"SD4":19.580
  },
  781 : {
     "Day":781
    ,"SD4neg":7.771
    ,"SD3neg":8.844
    ,"SD2neg":9.917
    ,"SD1neg":11.123
    ,"SD0":12.480
    ,"SD1":14.006
    ,"SD2":15.724
    ,"SD3":17.658
    ,"SD4":19.592
  },
  782 : {
     "Day":782
    ,"SD4neg":7.774
    ,"SD3neg":8.848
    ,"SD2neg":9.922
    ,"SD1neg":11.129
    ,"SD0":12.486
    ,"SD1":14.014
    ,"SD2":15.733
    ,"SD3":17.668
    ,"SD4":19.603
  },
  783 : {
     "Day":783
    ,"SD4neg":7.778
    ,"SD3neg":8.852
    ,"SD2neg":9.926
    ,"SD1neg":11.134
    ,"SD0":12.493
    ,"SD1":14.021
    ,"SD2":15.742
    ,"SD3":17.679
    ,"SD4":19.615
  },
  784 : {
     "Day":784
    ,"SD4neg":7.781
    ,"SD3neg":8.856
    ,"SD2neg":9.931
    ,"SD1neg":11.140
    ,"SD0":12.499
    ,"SD1":14.029
    ,"SD2":15.751
    ,"SD3":17.689
    ,"SD4":19.627
  },
  785 : {
     "Day":785
    ,"SD4neg":7.785
    ,"SD3neg":8.860
    ,"SD2neg":9.936
    ,"SD1neg":11.145
    ,"SD0":12.506
    ,"SD1":14.036
    ,"SD2":15.759
    ,"SD3":17.699
    ,"SD4":19.639
  },
  786 : {
     "Day":786
    ,"SD4neg":7.788
    ,"SD3neg":8.864
    ,"SD2neg":9.941
    ,"SD1neg":11.151
    ,"SD0":12.512
    ,"SD1":14.044
    ,"SD2":15.768
    ,"SD3":17.710
    ,"SD4":19.651
  },
  787 : {
     "Day":787
    ,"SD4neg":7.792
    ,"SD3neg":8.869
    ,"SD2neg":9.945
    ,"SD1neg":11.156
    ,"SD0":12.519
    ,"SD1":14.052
    ,"SD2":15.777
    ,"SD3":17.720
    ,"SD4":19.663
  },
  788 : {
     "Day":788
    ,"SD4neg":7.795
    ,"SD3neg":8.873
    ,"SD2neg":9.950
    ,"SD1neg":11.162
    ,"SD0":12.525
    ,"SD1":14.059
    ,"SD2":15.786
    ,"SD3":17.730
    ,"SD4":19.675
  },
  789 : {
     "Day":789
    ,"SD4neg":7.799
    ,"SD3neg":8.877
    ,"SD2neg":9.955
    ,"SD1neg":11.167
    ,"SD0":12.531
    ,"SD1":14.066
    ,"SD2":15.795
    ,"SD3":17.741
    ,"SD4":19.687
  },
  790 : {
     "Day":790
    ,"SD4neg":7.802
    ,"SD3neg":8.881
    ,"SD2neg":9.960
    ,"SD1neg":11.173
    ,"SD0":12.538
    ,"SD1":14.074
    ,"SD2":15.803
    ,"SD3":17.751
    ,"SD4":19.698
  },
  791 : {
     "Day":791
    ,"SD4neg":7.806
    ,"SD3neg":8.885
    ,"SD2neg":9.964
    ,"SD1neg":11.178
    ,"SD0":12.544
    ,"SD1":14.081
    ,"SD2":15.812
    ,"SD3":17.761
    ,"SD4":19.710
  },
  792 : {
     "Day":792
    ,"SD4neg":7.809
    ,"SD3neg":8.889
    ,"SD2neg":9.969
    ,"SD1neg":11.184
    ,"SD0":12.551
    ,"SD1":14.089
    ,"SD2":15.821
    ,"SD3":17.771
    ,"SD4":19.722
  },
  793 : {
     "Day":793
    ,"SD4neg":7.813
    ,"SD3neg":8.893
    ,"SD2neg":9.974
    ,"SD1neg":11.189
    ,"SD0":12.557
    ,"SD1":14.096
    ,"SD2":15.829
    ,"SD3":17.781
    ,"SD4":19.733
  },
  794 : {
     "Day":794
    ,"SD4neg":7.816
    ,"SD3neg":8.898
    ,"SD2neg":9.979
    ,"SD1neg":11.195
    ,"SD0":12.563
    ,"SD1":14.104
    ,"SD2":15.838
    ,"SD3":17.792
    ,"SD4":19.745
  },
  795 : {
     "Day":795
    ,"SD4neg":7.820
    ,"SD3neg":8.902
    ,"SD2neg":9.983
    ,"SD1neg":11.200
    ,"SD0":12.570
    ,"SD1":14.111
    ,"SD2":15.847
    ,"SD3":17.802
    ,"SD4":19.757
  },
  796 : {
     "Day":796
    ,"SD4neg":7.823
    ,"SD3neg":8.906
    ,"SD2neg":9.988
    ,"SD1neg":11.206
    ,"SD0":12.576
    ,"SD1":14.119
    ,"SD2":15.856
    ,"SD3":17.812
    ,"SD4":19.769
  },
  797 : {
     "Day":797
    ,"SD4neg":7.827
    ,"SD3neg":8.910
    ,"SD2neg":9.993
    ,"SD1neg":11.211
    ,"SD0":12.583
    ,"SD1":14.126
    ,"SD2":15.864
    ,"SD3":17.823
    ,"SD4":19.781
  },
  798 : {
     "Day":798
    ,"SD4neg":7.830
    ,"SD3neg":8.914
    ,"SD2neg":9.998
    ,"SD1neg":11.217
    ,"SD0":12.589
    ,"SD1":14.134
    ,"SD2":15.873
    ,"SD3":17.833
    ,"SD4":19.793
  },
  799 : {
     "Day":799
    ,"SD4neg":7.834
    ,"SD3neg":8.918
    ,"SD2neg":10.002
    ,"SD1neg":11.222
    ,"SD0":12.595
    ,"SD1":14.141
    ,"SD2":15.882
    ,"SD3":17.843
    ,"SD4":19.804
  },
  800 : {
     "Day":800
    ,"SD4neg":7.837
    ,"SD3neg":8.922
    ,"SD2neg":10.007
    ,"SD1neg":11.228
    ,"SD0":12.602
    ,"SD1":14.149
    ,"SD2":15.891
    ,"SD3":17.854
    ,"SD4":19.816
  },
  801 : {
     "Day":801
    ,"SD4neg":7.840
    ,"SD3neg":8.926
    ,"SD2neg":10.012
    ,"SD1neg":11.233
    ,"SD0":12.608
    ,"SD1":14.156
    ,"SD2":15.900
    ,"SD3":17.864
    ,"SD4":19.828
  },
  802 : {
     "Day":802
    ,"SD4neg":7.844
    ,"SD3neg":8.930
    ,"SD2neg":10.016
    ,"SD1neg":11.239
    ,"SD0":12.614
    ,"SD1":14.164
    ,"SD2":15.908
    ,"SD3":17.874
    ,"SD4":19.840
  },
  803 : {
     "Day":803
    ,"SD4neg":7.847
    ,"SD3neg":8.934
    ,"SD2neg":10.021
    ,"SD1neg":11.244
    ,"SD0":12.621
    ,"SD1":14.171
    ,"SD2":15.917
    ,"SD3":17.884
    ,"SD4":19.852
  },
  804 : {
     "Day":804
    ,"SD4neg":7.851
    ,"SD3neg":8.938
    ,"SD2neg":10.026
    ,"SD1neg":11.250
    ,"SD0":12.627
    ,"SD1":14.178
    ,"SD2":15.926
    ,"SD3":17.895
    ,"SD4":19.864
  },
  805 : {
     "Day":805
    ,"SD4neg":7.854
    ,"SD3neg":8.942
    ,"SD2neg":10.031
    ,"SD1neg":11.255
    ,"SD0":12.634
    ,"SD1":14.186
    ,"SD2":15.934
    ,"SD3":17.905
    ,"SD4":19.875
  },
  806 : {
     "Day":806
    ,"SD4neg":7.858
    ,"SD3neg":8.946
    ,"SD2neg":10.035
    ,"SD1neg":11.261
    ,"SD0":12.640
    ,"SD1":14.193
    ,"SD2":15.943
    ,"SD3":17.915
    ,"SD4":19.887
  },
  807 : {
     "Day":807
    ,"SD4neg":7.861
    ,"SD3neg":8.951
    ,"SD2neg":10.040
    ,"SD1neg":11.266
    ,"SD0":12.646
    ,"SD1":14.201
    ,"SD2":15.952
    ,"SD3":17.926
    ,"SD4":19.899
  },
  808 : {
     "Day":808
    ,"SD4neg":7.864
    ,"SD3neg":8.955
    ,"SD2neg":10.045
    ,"SD1neg":11.272
    ,"SD0":12.653
    ,"SD1":14.208
    ,"SD2":15.961
    ,"SD3":17.936
    ,"SD4":19.911
  },
  809 : {
     "Day":809
    ,"SD4neg":7.868
    ,"SD3neg":8.959
    ,"SD2neg":10.049
    ,"SD1neg":11.277
    ,"SD0":12.659
    ,"SD1":14.216
    ,"SD2":15.969
    ,"SD3":17.946
    ,"SD4":19.923
  },
  810 : {
     "Day":810
    ,"SD4neg":7.871
    ,"SD3neg":8.963
    ,"SD2neg":10.054
    ,"SD1neg":11.282
    ,"SD0":12.665
    ,"SD1":14.223
    ,"SD2":15.978
    ,"SD3":17.956
    ,"SD4":19.935
  },
  811 : {
     "Day":811
    ,"SD4neg":7.875
    ,"SD3neg":8.967
    ,"SD2neg":10.059
    ,"SD1neg":11.288
    ,"SD0":12.672
    ,"SD1":14.231
    ,"SD2":15.987
    ,"SD3":17.967
    ,"SD4":19.947
  },
  812 : {
     "Day":812
    ,"SD4neg":7.878
    ,"SD3neg":8.971
    ,"SD2neg":10.063
    ,"SD1neg":11.293
    ,"SD0":12.678
    ,"SD1":14.238
    ,"SD2":15.996
    ,"SD3":17.977
    ,"SD4":19.958
  },
  813 : {
     "Day":813
    ,"SD4neg":7.881
    ,"SD3neg":8.975
    ,"SD2neg":10.068
    ,"SD1neg":11.299
    ,"SD0":12.684
    ,"SD1":14.245
    ,"SD2":16.004
    ,"SD3":17.987
    ,"SD4":19.970
  },
  814 : {
     "Day":814
    ,"SD4neg":7.885
    ,"SD3neg":8.979
    ,"SD2neg":10.073
    ,"SD1neg":11.304
    ,"SD0":12.691
    ,"SD1":14.253
    ,"SD2":16.013
    ,"SD3":17.997
    ,"SD4":19.982
  },
  815 : {
     "Day":815
    ,"SD4neg":7.888
    ,"SD3neg":8.983
    ,"SD2neg":10.077
    ,"SD1neg":11.310
    ,"SD0":12.697
    ,"SD1":14.260
    ,"SD2":16.022
    ,"SD3":18.008
    ,"SD4":19.994
  },
  816 : {
     "Day":816
    ,"SD4neg":7.892
    ,"SD3neg":8.987
    ,"SD2neg":10.082
    ,"SD1neg":11.315
    ,"SD0":12.703
    ,"SD1":14.268
    ,"SD2":16.030
    ,"SD3":18.018
    ,"SD4":20.005
  },
  817 : {
     "Day":817
    ,"SD4neg":7.895
    ,"SD3neg":8.991
    ,"SD2neg":10.087
    ,"SD1neg":11.320
    ,"SD0":12.710
    ,"SD1":14.275
    ,"SD2":16.039
    ,"SD3":18.028
    ,"SD4":20.017
  },
  818 : {
     "Day":818
    ,"SD4neg":7.898
    ,"SD3neg":8.995
    ,"SD2neg":10.091
    ,"SD1neg":11.326
    ,"SD0":12.716
    ,"SD1":14.282
    ,"SD2":16.048
    ,"SD3":18.038
    ,"SD4":20.029
  },
  819 : {
     "Day":819
    ,"SD4neg":7.902
    ,"SD3neg":8.999
    ,"SD2neg":10.096
    ,"SD1neg":11.331
    ,"SD0":12.722
    ,"SD1":14.290
    ,"SD2":16.057
    ,"SD3":18.049
    ,"SD4":20.041
  },
  820 : {
     "Day":820
    ,"SD4neg":7.905
    ,"SD3neg":9.003
    ,"SD2neg":10.101
    ,"SD1neg":11.337
    ,"SD0":12.729
    ,"SD1":14.297
    ,"SD2":16.065
    ,"SD3":18.059
    ,"SD4":20.052
  },
  821 : {
     "Day":821
    ,"SD4neg":7.909
    ,"SD3neg":9.007
    ,"SD2neg":10.106
    ,"SD1neg":11.342
    ,"SD0":12.735
    ,"SD1":14.304
    ,"SD2":16.074
    ,"SD3":18.069
    ,"SD4":20.063
  },
  822 : {
     "Day":822
    ,"SD4neg":7.912
    ,"SD3neg":9.011
    ,"SD2neg":10.110
    ,"SD1neg":11.348
    ,"SD0":12.741
    ,"SD1":14.312
    ,"SD2":16.082
    ,"SD3":18.079
    ,"SD4":20.075
  },
  823 : {
     "Day":823
    ,"SD4neg":7.916
    ,"SD3neg":9.015
    ,"SD2neg":10.115
    ,"SD1neg":11.353
    ,"SD0":12.748
    ,"SD1":14.319
    ,"SD2":16.091
    ,"SD3":18.089
    ,"SD4":20.087
  },
  824 : {
     "Day":824
    ,"SD4neg":7.919
    ,"SD3neg":9.019
    ,"SD2neg":10.119
    ,"SD1neg":11.358
    ,"SD0":12.754
    ,"SD1":14.327
    ,"SD2":16.100
    ,"SD3":18.099
    ,"SD4":20.099
  },
  825 : {
     "Day":825
    ,"SD4neg":7.922
    ,"SD3neg":9.023
    ,"SD2neg":10.124
    ,"SD1neg":11.364
    ,"SD0":12.760
    ,"SD1":14.334
    ,"SD2":16.108
    ,"SD3":18.109
    ,"SD4":20.110
  },
  826 : {
     "Day":826
    ,"SD4neg":7.926
    ,"SD3neg":9.027
    ,"SD2neg":10.129
    ,"SD1neg":11.369
    ,"SD0":12.766
    ,"SD1":14.341
    ,"SD2":16.117
    ,"SD3":18.120
    ,"SD4":20.122
  },
  827 : {
     "Day":827
    ,"SD4neg":7.929
    ,"SD3neg":9.031
    ,"SD2neg":10.133
    ,"SD1neg":11.375
    ,"SD0":12.773
    ,"SD1":14.349
    ,"SD2":16.126
    ,"SD3":18.130
    ,"SD4":20.134
  },
  828 : {
     "Day":828
    ,"SD4neg":7.932
    ,"SD3neg":9.035
    ,"SD2neg":10.138
    ,"SD1neg":11.380
    ,"SD0":12.779
    ,"SD1":14.356
    ,"SD2":16.134
    ,"SD3":18.140
    ,"SD4":20.146
  },
  829 : {
     "Day":829
    ,"SD4neg":7.936
    ,"SD3neg":9.039
    ,"SD2neg":10.143
    ,"SD1neg":11.385
    ,"SD0":12.785
    ,"SD1":14.363
    ,"SD2":16.143
    ,"SD3":18.150
    ,"SD4":20.158
  },
  830 : {
     "Day":830
    ,"SD4neg":7.939
    ,"SD3neg":9.043
    ,"SD2neg":10.147
    ,"SD1neg":11.391
    ,"SD0":12.792
    ,"SD1":14.371
    ,"SD2":16.151
    ,"SD3":18.160
    ,"SD4":20.169
  },
  831 : {
     "Day":831
    ,"SD4neg":7.943
    ,"SD3neg":9.047
    ,"SD2neg":10.152
    ,"SD1neg":11.396
    ,"SD0":12.798
    ,"SD1":14.378
    ,"SD2":16.160
    ,"SD3":18.171
    ,"SD4":20.181
  },
  832 : {
     "Day":832
    ,"SD4neg":7.946
    ,"SD3neg":9.051
    ,"SD2neg":10.156
    ,"SD1neg":11.401
    ,"SD0":12.804
    ,"SD1":14.385
    ,"SD2":16.169
    ,"SD3":18.181
    ,"SD4":20.193
  },
  833 : {
     "Day":833
    ,"SD4neg":7.949
    ,"SD3neg":9.055
    ,"SD2neg":10.161
    ,"SD1neg":11.407
    ,"SD0":12.810
    ,"SD1":14.393
    ,"SD2":16.177
    ,"SD3":18.191
    ,"SD4":20.204
  },
  834 : {
     "Day":834
    ,"SD4neg":7.953
    ,"SD3neg":9.059
    ,"SD2neg":10.166
    ,"SD1neg":11.412
    ,"SD0":12.817
    ,"SD1":14.400
    ,"SD2":16.186
    ,"SD3":18.201
    ,"SD4":20.216
  },
  835 : {
     "Day":835
    ,"SD4neg":7.956
    ,"SD3neg":9.063
    ,"SD2neg":10.170
    ,"SD1neg":11.418
    ,"SD0":12.823
    ,"SD1":14.408
    ,"SD2":16.195
    ,"SD3":18.211
    ,"SD4":20.228
  },
  836 : {
     "Day":836
    ,"SD4neg":7.959
    ,"SD3neg":9.067
    ,"SD2neg":10.175
    ,"SD1neg":11.423
    ,"SD0":12.829
    ,"SD1":14.415
    ,"SD2":16.203
    ,"SD3":18.221
    ,"SD4":20.240
  },
  837 : {
     "Day":837
    ,"SD4neg":7.963
    ,"SD3neg":9.071
    ,"SD2neg":10.180
    ,"SD1neg":11.428
    ,"SD0":12.836
    ,"SD1":14.422
    ,"SD2":16.212
    ,"SD3":18.232
    ,"SD4":20.251
  },
  838 : {
     "Day":838
    ,"SD4neg":7.966
    ,"SD3neg":9.075
    ,"SD2neg":10.184
    ,"SD1neg":11.434
    ,"SD0":12.842
    ,"SD1":14.429
    ,"SD2":16.220
    ,"SD3":18.242
    ,"SD4":20.263
  },
  839 : {
     "Day":839
    ,"SD4neg":7.969
    ,"SD3neg":9.079
    ,"SD2neg":10.189
    ,"SD1neg":11.439
    ,"SD0":12.848
    ,"SD1":14.437
    ,"SD2":16.229
    ,"SD3":18.252
    ,"SD4":20.275
  },
  840 : {
     "Day":840
    ,"SD4neg":7.973
    ,"SD3neg":9.083
    ,"SD2neg":10.193
    ,"SD1neg":11.444
    ,"SD0":12.854
    ,"SD1":14.444
    ,"SD2":16.238
    ,"SD3":18.262
    ,"SD4":20.286
  },
  841 : {
     "Day":841
    ,"SD4neg":7.976
    ,"SD3neg":9.087
    ,"SD2neg":10.198
    ,"SD1neg":11.450
    ,"SD0":12.860
    ,"SD1":14.451
    ,"SD2":16.246
    ,"SD3":18.272
    ,"SD4":20.298
  },
  842 : {
     "Day":842
    ,"SD4neg":7.979
    ,"SD3neg":9.091
    ,"SD2neg":10.202
    ,"SD1neg":11.455
    ,"SD0":12.867
    ,"SD1":14.459
    ,"SD2":16.255
    ,"SD3":18.282
    ,"SD4":20.310
  },
  843 : {
     "Day":843
    ,"SD4neg":7.983
    ,"SD3neg":9.095
    ,"SD2neg":10.207
    ,"SD1neg":11.460
    ,"SD0":12.873
    ,"SD1":14.466
    ,"SD2":16.264
    ,"SD3":18.292
    ,"SD4":20.321
  },
  844 : {
     "Day":844
    ,"SD4neg":7.986
    ,"SD3neg":9.099
    ,"SD2neg":10.212
    ,"SD1neg":11.466
    ,"SD0":12.879
    ,"SD1":14.473
    ,"SD2":16.272
    ,"SD3":18.302
    ,"SD4":20.332
  },
  845 : {
     "Day":845
    ,"SD4neg":7.989
    ,"SD3neg":9.103
    ,"SD2neg":10.216
    ,"SD1neg":11.471
    ,"SD0":12.885
    ,"SD1":14.480
    ,"SD2":16.280
    ,"SD3":18.312
    ,"SD4":20.344
  },
  846 : {
     "Day":846
    ,"SD4neg":7.993
    ,"SD3neg":9.107
    ,"SD2neg":10.221
    ,"SD1neg":11.476
    ,"SD0":12.892
    ,"SD1":14.488
    ,"SD2":16.289
    ,"SD3":18.322
    ,"SD4":20.356
  },
  847 : {
     "Day":847
    ,"SD4neg":7.996
    ,"SD3neg":9.111
    ,"SD2neg":10.226
    ,"SD1neg":11.482
    ,"SD0":12.898
    ,"SD1":14.495
    ,"SD2":16.298
    ,"SD3":18.332
    ,"SD4":20.367
  },
  848 : {
     "Day":848
    ,"SD4neg":7.999
    ,"SD3neg":9.115
    ,"SD2neg":10.230
    ,"SD1neg":11.487
    ,"SD0":12.904
    ,"SD1":14.502
    ,"SD2":16.306
    ,"SD3":18.343
    ,"SD4":20.379
  },
  849 : {
     "Day":849
    ,"SD4neg":8.003
    ,"SD3neg":9.119
    ,"SD2neg":10.235
    ,"SD1neg":11.492
    ,"SD0":12.910
    ,"SD1":14.510
    ,"SD2":16.315
    ,"SD3":18.353
    ,"SD4":20.391
  },
  850 : {
     "Day":850
    ,"SD4neg":8.006
    ,"SD3neg":9.123
    ,"SD2neg":10.239
    ,"SD1neg":11.498
    ,"SD0":12.916
    ,"SD1":14.517
    ,"SD2":16.323
    ,"SD3":18.363
    ,"SD4":20.402
  },
  851 : {
     "Day":851
    ,"SD4neg":8.009
    ,"SD3neg":9.127
    ,"SD2neg":10.244
    ,"SD1neg":11.503
    ,"SD0":12.923
    ,"SD1":14.524
    ,"SD2":16.332
    ,"SD3":18.373
    ,"SD4":20.414
  },
  852 : {
     "Day":852
    ,"SD4neg":8.013
    ,"SD3neg":9.130
    ,"SD2neg":10.248
    ,"SD1neg":11.508
    ,"SD0":12.929
    ,"SD1":14.531
    ,"SD2":16.340
    ,"SD3":18.383
    ,"SD4":20.426
  },
  853 : {
     "Day":853
    ,"SD4neg":8.016
    ,"SD3neg":9.134
    ,"SD2neg":10.253
    ,"SD1neg":11.513
    ,"SD0":12.935
    ,"SD1":14.539
    ,"SD2":16.349
    ,"SD3":18.393
    ,"SD4":20.437
  },
  854 : {
     "Day":854
    ,"SD4neg":8.019
    ,"SD3neg":9.138
    ,"SD2neg":10.257
    ,"SD1neg":11.519
    ,"SD0":12.941
    ,"SD1":14.546
    ,"SD2":16.357
    ,"SD3":18.403
    ,"SD4":20.449
  },
  855 : {
     "Day":855
    ,"SD4neg":8.022
    ,"SD3neg":9.142
    ,"SD2neg":10.262
    ,"SD1neg":11.524
    ,"SD0":12.947
    ,"SD1":14.553
    ,"SD2":16.366
    ,"SD3":18.413
    ,"SD4":20.461
  },
  856 : {
     "Day":856
    ,"SD4neg":8.026
    ,"SD3neg":9.146
    ,"SD2neg":10.266
    ,"SD1neg":11.529
    ,"SD0":12.954
    ,"SD1":14.560
    ,"SD2":16.375
    ,"SD3":18.423
    ,"SD4":20.472
  },
  857 : {
     "Day":857
    ,"SD4neg":8.029
    ,"SD3neg":9.150
    ,"SD2neg":10.271
    ,"SD1neg":11.535
    ,"SD0":12.960
    ,"SD1":14.568
    ,"SD2":16.383
    ,"SD3":18.433
    ,"SD4":20.484
  },
  858 : {
     "Day":858
    ,"SD4neg":8.032
    ,"SD3neg":9.154
    ,"SD2neg":10.275
    ,"SD1neg":11.540
    ,"SD0":12.966
    ,"SD1":14.575
    ,"SD2":16.392
    ,"SD3":18.443
    ,"SD4":20.495
  },
  859 : {
     "Day":859
    ,"SD4neg":8.036
    ,"SD3neg":9.158
    ,"SD2neg":10.280
    ,"SD1neg":11.545
    ,"SD0":12.972
    ,"SD1":14.582
    ,"SD2":16.400
    ,"SD3":18.454
    ,"SD4":20.507
  },
  860 : {
     "Day":860
    ,"SD4neg":8.039
    ,"SD3neg":9.162
    ,"SD2neg":10.285
    ,"SD1neg":11.550
    ,"SD0":12.978
    ,"SD1":14.589
    ,"SD2":16.409
    ,"SD3":18.464
    ,"SD4":20.519
  },
  861 : {
     "Day":861
    ,"SD4neg":8.042
    ,"SD3neg":9.166
    ,"SD2neg":10.289
    ,"SD1neg":11.556
    ,"SD0":12.984
    ,"SD1":14.597
    ,"SD2":16.417
    ,"SD3":18.474
    ,"SD4":20.530
  },
  862 : {
     "Day":862
    ,"SD4neg":8.045
    ,"SD3neg":9.169
    ,"SD2neg":10.294
    ,"SD1neg":11.561
    ,"SD0":12.990
    ,"SD1":14.604
    ,"SD2":16.426
    ,"SD3":18.484
    ,"SD4":20.542
  },
  863 : {
     "Day":863
    ,"SD4neg":8.049
    ,"SD3neg":9.174
    ,"SD2neg":10.298
    ,"SD1neg":11.566
    ,"SD0":12.997
    ,"SD1":14.611
    ,"SD2":16.434
    ,"SD3":18.493
    ,"SD4":20.553
  },
  864 : {
     "Day":864
    ,"SD4neg":8.052
    ,"SD3neg":9.177
    ,"SD2neg":10.303
    ,"SD1neg":11.572
    ,"SD0":13.003
    ,"SD1":14.618
    ,"SD2":16.442
    ,"SD3":18.503
    ,"SD4":20.564
  },
  865 : {
     "Day":865
    ,"SD4neg":8.055
    ,"SD3neg":9.181
    ,"SD2neg":10.307
    ,"SD1neg":11.577
    ,"SD0":13.009
    ,"SD1":14.625
    ,"SD2":16.451
    ,"SD3":18.513
    ,"SD4":20.576
  },
  866 : {
     "Day":866
    ,"SD4neg":8.059
    ,"SD3neg":9.185
    ,"SD2neg":10.312
    ,"SD1neg":11.582
    ,"SD0":13.015
    ,"SD1":14.633
    ,"SD2":16.459
    ,"SD3":18.523
    ,"SD4":20.587
  },
  867 : {
     "Day":867
    ,"SD4neg":8.062
    ,"SD3neg":9.189
    ,"SD2neg":10.316
    ,"SD1neg":11.587
    ,"SD0":13.021
    ,"SD1":14.640
    ,"SD2":16.468
    ,"SD3":18.533
    ,"SD4":20.599
  },
  868 : {
     "Day":868
    ,"SD4neg":8.065
    ,"SD3neg":9.193
    ,"SD2neg":10.321
    ,"SD1neg":11.592
    ,"SD0":13.027
    ,"SD1":14.647
    ,"SD2":16.476
    ,"SD3":18.543
    ,"SD4":20.610
  },
  869 : {
     "Day":869
    ,"SD4neg":8.068
    ,"SD3neg":9.197
    ,"SD2neg":10.325
    ,"SD1neg":11.598
    ,"SD0":13.033
    ,"SD1":14.654
    ,"SD2":16.485
    ,"SD3":18.553
    ,"SD4":20.622
  },
  870 : {
     "Day":870
    ,"SD4neg":8.072
    ,"SD3neg":9.201
    ,"SD2neg":10.330
    ,"SD1neg":11.603
    ,"SD0":13.040
    ,"SD1":14.661
    ,"SD2":16.493
    ,"SD3":18.564
    ,"SD4":20.634
  },
  871 : {
     "Day":871
    ,"SD4neg":8.075
    ,"SD3neg":9.205
    ,"SD2neg":10.334
    ,"SD1neg":11.608
    ,"SD0":13.046
    ,"SD1":14.669
    ,"SD2":16.502
    ,"SD3":18.574
    ,"SD4":20.645
  },
  872 : {
     "Day":872
    ,"SD4neg":8.078
    ,"SD3neg":9.208
    ,"SD2neg":10.339
    ,"SD1neg":11.613
    ,"SD0":13.052
    ,"SD1":14.676
    ,"SD2":16.510
    ,"SD3":18.583
    ,"SD4":20.657
  },
  873 : {
     "Day":873
    ,"SD4neg":8.081
    ,"SD3neg":9.212
    ,"SD2neg":10.343
    ,"SD1neg":11.619
    ,"SD0":13.058
    ,"SD1":14.683
    ,"SD2":16.519
    ,"SD3":18.594
    ,"SD4":20.668
  },
  874 : {
     "Day":874
    ,"SD4neg":8.085
    ,"SD3neg":9.216
    ,"SD2neg":10.348
    ,"SD1neg":11.624
    ,"SD0":13.064
    ,"SD1":14.690
    ,"SD2":16.527
    ,"SD3":18.603
    ,"SD4":20.680
  },
  875 : {
     "Day":875
    ,"SD4neg":8.088
    ,"SD3neg":9.220
    ,"SD2neg":10.352
    ,"SD1neg":11.629
    ,"SD0":13.070
    ,"SD1":14.697
    ,"SD2":16.536
    ,"SD3":18.614
    ,"SD4":20.691
  },
  876 : {
     "Day":876
    ,"SD4neg":8.091
    ,"SD3neg":9.224
    ,"SD2neg":10.356
    ,"SD1neg":11.634
    ,"SD0":13.076
    ,"SD1":14.704
    ,"SD2":16.544
    ,"SD3":18.623
    ,"SD4":20.703
  },
  877 : {
     "Day":877
    ,"SD4neg":8.094
    ,"SD3neg":9.228
    ,"SD2neg":10.361
    ,"SD1neg":11.639
    ,"SD0":13.082
    ,"SD1":14.712
    ,"SD2":16.553
    ,"SD3":18.634
    ,"SD4":20.715
  },
  878 : {
     "Day":878
    ,"SD4neg":8.098
    ,"SD3neg":9.232
    ,"SD2neg":10.366
    ,"SD1neg":11.645
    ,"SD0":13.088
    ,"SD1":14.719
    ,"SD2":16.561
    ,"SD3":18.643
    ,"SD4":20.725
  },
  879 : {
     "Day":879
    ,"SD4neg":8.101
    ,"SD3neg":9.236
    ,"SD2neg":10.370
    ,"SD1neg":11.650
    ,"SD0":13.094
    ,"SD1":14.726
    ,"SD2":16.569
    ,"SD3":18.653
    ,"SD4":20.737
  },
  880 : {
     "Day":880
    ,"SD4neg":8.104
    ,"SD3neg":9.239
    ,"SD2neg":10.375
    ,"SD1neg":11.655
    ,"SD0":13.101
    ,"SD1":14.733
    ,"SD2":16.578
    ,"SD3":18.663
    ,"SD4":20.748
  },
  881 : {
     "Day":881
    ,"SD4neg":8.107
    ,"SD3neg":9.243
    ,"SD2neg":10.379
    ,"SD1neg":11.660
    ,"SD0":13.107
    ,"SD1":14.740
    ,"SD2":16.586
    ,"SD3":18.673
    ,"SD4":20.760
  },
  882 : {
     "Day":882
    ,"SD4neg":8.111
    ,"SD3neg":9.247
    ,"SD2neg":10.383
    ,"SD1neg":11.665
    ,"SD0":13.113
    ,"SD1":14.747
    ,"SD2":16.594
    ,"SD3":18.683
    ,"SD4":20.771
  },
  883 : {
     "Day":883
    ,"SD4neg":8.114
    ,"SD3neg":9.251
    ,"SD2neg":10.388
    ,"SD1neg":11.671
    ,"SD0":13.119
    ,"SD1":14.754
    ,"SD2":16.603
    ,"SD3":18.693
    ,"SD4":20.783
  },
  884 : {
     "Day":884
    ,"SD4neg":8.117
    ,"SD3neg":9.255
    ,"SD2neg":10.392
    ,"SD1neg":11.676
    ,"SD0":13.125
    ,"SD1":14.762
    ,"SD2":16.611
    ,"SD3":18.703
    ,"SD4":20.794
  },
  885 : {
     "Day":885
    ,"SD4neg":8.120
    ,"SD3neg":9.259
    ,"SD2neg":10.397
    ,"SD1neg":11.681
    ,"SD0":13.131
    ,"SD1":14.769
    ,"SD2":16.620
    ,"SD3":18.713
    ,"SD4":20.806
  },
  886 : {
     "Day":886
    ,"SD4neg":8.123
    ,"SD3neg":9.262
    ,"SD2neg":10.401
    ,"SD1neg":11.686
    ,"SD0":13.137
    ,"SD1":14.776
    ,"SD2":16.628
    ,"SD3":18.723
    ,"SD4":20.817
  },
  887 : {
     "Day":887
    ,"SD4neg":8.127
    ,"SD3neg":9.266
    ,"SD2neg":10.406
    ,"SD1neg":11.691
    ,"SD0":13.143
    ,"SD1":14.783
    ,"SD2":16.637
    ,"SD3":18.733
    ,"SD4":20.829
  },
  888 : {
     "Day":888
    ,"SD4neg":8.130
    ,"SD3neg":9.270
    ,"SD2neg":10.410
    ,"SD1neg":11.697
    ,"SD0":13.149
    ,"SD1":14.790
    ,"SD2":16.645
    ,"SD3":18.743
    ,"SD4":20.840
  },
  889 : {
     "Day":889
    ,"SD4neg":8.133
    ,"SD3neg":9.274
    ,"SD2neg":10.414
    ,"SD1neg":11.702
    ,"SD0":13.155
    ,"SD1":14.797
    ,"SD2":16.653
    ,"SD3":18.753
    ,"SD4":20.852
  },
  890 : {
     "Day":890
    ,"SD4neg":8.136
    ,"SD3neg":9.278
    ,"SD2neg":10.419
    ,"SD1neg":11.707
    ,"SD0":13.161
    ,"SD1":14.804
    ,"SD2":16.662
    ,"SD3":18.763
    ,"SD4":20.863
  },
  891 : {
     "Day":891
    ,"SD4neg":8.139
    ,"SD3neg":9.281
    ,"SD2neg":10.423
    ,"SD1neg":11.712
    ,"SD0":13.167
    ,"SD1":14.811
    ,"SD2":16.670
    ,"SD3":18.772
    ,"SD4":20.875
  },
  892 : {
     "Day":892
    ,"SD4neg":8.143
    ,"SD3neg":9.285
    ,"SD2neg":10.428
    ,"SD1neg":11.717
    ,"SD0":13.173
    ,"SD1":14.818
    ,"SD2":16.678
    ,"SD3":18.782
    ,"SD4":20.886
  },
  893 : {
     "Day":893
    ,"SD4neg":8.146
    ,"SD3neg":9.289
    ,"SD2neg":10.432
    ,"SD1neg":11.722
    ,"SD0":13.179
    ,"SD1":14.825
    ,"SD2":16.687
    ,"SD3":18.792
    ,"SD4":20.897
  },
  894 : {
     "Day":894
    ,"SD4neg":8.149
    ,"SD3neg":9.293
    ,"SD2neg":10.437
    ,"SD1neg":11.728
    ,"SD0":13.185
    ,"SD1":14.833
    ,"SD2":16.695
    ,"SD3":18.802
    ,"SD4":20.909
  },
  895 : {
     "Day":895
    ,"SD4neg":8.152
    ,"SD3neg":9.297
    ,"SD2neg":10.441
    ,"SD1neg":11.733
    ,"SD0":13.191
    ,"SD1":14.840
    ,"SD2":16.703
    ,"SD3":18.812
    ,"SD4":20.920
  },
  896 : {
     "Day":896
    ,"SD4neg":8.156
    ,"SD3neg":9.301
    ,"SD2neg":10.445
    ,"SD1neg":11.738
    ,"SD0":13.197
    ,"SD1":14.847
    ,"SD2":16.712
    ,"SD3":18.821
    ,"SD4":20.931
  },
  897 : {
     "Day":897
    ,"SD4neg":8.159
    ,"SD3neg":9.304
    ,"SD2neg":10.450
    ,"SD1neg":11.743
    ,"SD0":13.203
    ,"SD1":14.854
    ,"SD2":16.720
    ,"SD3":18.831
    ,"SD4":20.943
  },
  898 : {
     "Day":898
    ,"SD4neg":8.162
    ,"SD3neg":9.308
    ,"SD2neg":10.454
    ,"SD1neg":11.748
    ,"SD0":13.210
    ,"SD1":14.861
    ,"SD2":16.728
    ,"SD3":18.841
    ,"SD4":20.954
  },
  899 : {
     "Day":899
    ,"SD4neg":8.165
    ,"SD3neg":9.312
    ,"SD2neg":10.459
    ,"SD1neg":11.753
    ,"SD0":13.216
    ,"SD1":14.868
    ,"SD2":16.737
    ,"SD3":18.851
    ,"SD4":20.966
  },
  900 : {
     "Day":900
    ,"SD4neg":8.168
    ,"SD3neg":9.316
    ,"SD2neg":10.463
    ,"SD1neg":11.758
    ,"SD0":13.222
    ,"SD1":14.875
    ,"SD2":16.745
    ,"SD3":18.861
    ,"SD4":20.977
  },
  901 : {
     "Day":901
    ,"SD4neg":8.171
    ,"SD3neg":9.319
    ,"SD2neg":10.467
    ,"SD1neg":11.764
    ,"SD0":13.228
    ,"SD1":14.882
    ,"SD2":16.754
    ,"SD3":18.871
    ,"SD4":20.989
  },
  902 : {
     "Day":902
    ,"SD4neg":8.175
    ,"SD3neg":9.323
    ,"SD2neg":10.472
    ,"SD1neg":11.769
    ,"SD0":13.234
    ,"SD1":14.889
    ,"SD2":16.762
    ,"SD3":18.881
    ,"SD4":21.000
  },
  903 : {
     "Day":903
    ,"SD4neg":8.178
    ,"SD3neg":9.327
    ,"SD2neg":10.476
    ,"SD1neg":11.774
    ,"SD0":13.240
    ,"SD1":14.896
    ,"SD2":16.770
    ,"SD3":18.891
    ,"SD4":21.012
  },
  904 : {
     "Day":904
    ,"SD4neg":8.181
    ,"SD3neg":9.331
    ,"SD2neg":10.481
    ,"SD1neg":11.779
    ,"SD0":13.246
    ,"SD1":14.903
    ,"SD2":16.778
    ,"SD3":18.900
    ,"SD4":21.022
  },
  905 : {
     "Day":905
    ,"SD4neg":8.184
    ,"SD3neg":9.335
    ,"SD2neg":10.485
    ,"SD1neg":11.784
    ,"SD0":13.252
    ,"SD1":14.910
    ,"SD2":16.787
    ,"SD3":18.910
    ,"SD4":21.034
  },
  906 : {
     "Day":906
    ,"SD4neg":8.187
    ,"SD3neg":9.338
    ,"SD2neg":10.490
    ,"SD1neg":11.789
    ,"SD0":13.258
    ,"SD1":14.917
    ,"SD2":16.795
    ,"SD3":18.920
    ,"SD4":21.045
  },
  907 : {
     "Day":907
    ,"SD4neg":8.191
    ,"SD3neg":9.342
    ,"SD2neg":10.494
    ,"SD1neg":11.794
    ,"SD0":13.263
    ,"SD1":14.924
    ,"SD2":16.803
    ,"SD3":18.930
    ,"SD4":21.056
  },
  908 : {
     "Day":908
    ,"SD4neg":8.194
    ,"SD3neg":9.346
    ,"SD2neg":10.498
    ,"SD1neg":11.799
    ,"SD0":13.269
    ,"SD1":14.931
    ,"SD2":16.811
    ,"SD3":18.940
    ,"SD4":21.068
  },
  909 : {
     "Day":909
    ,"SD4neg":8.197
    ,"SD3neg":9.350
    ,"SD2neg":10.503
    ,"SD1neg":11.804
    ,"SD0":13.275
    ,"SD1":14.938
    ,"SD2":16.820
    ,"SD3":18.950
    ,"SD4":21.079
  },
  910 : {
     "Day":910
    ,"SD4neg":8.200
    ,"SD3neg":9.353
    ,"SD2neg":10.507
    ,"SD1neg":11.810
    ,"SD0":13.281
    ,"SD1":14.946
    ,"SD2":16.828
    ,"SD3":18.959
    ,"SD4":21.091
  },
  911 : {
     "Day":911
    ,"SD4neg":8.203
    ,"SD3neg":9.357
    ,"SD2neg":10.511
    ,"SD1neg":11.815
    ,"SD0":13.287
    ,"SD1":14.952
    ,"SD2":16.836
    ,"SD3":18.969
    ,"SD4":21.102
  },
  912 : {
     "Day":912
    ,"SD4neg":8.206
    ,"SD3neg":9.361
    ,"SD2neg":10.516
    ,"SD1neg":11.820
    ,"SD0":13.293
    ,"SD1":14.960
    ,"SD2":16.845
    ,"SD3":18.979
    ,"SD4":21.113
  },
  913 : {
     "Day":913
    ,"SD4neg":8.209
    ,"SD3neg":9.365
    ,"SD2neg":10.520
    ,"SD1neg":11.825
    ,"SD0":13.299
    ,"SD1":14.967
    ,"SD2":16.853
    ,"SD3":18.989
    ,"SD4":21.125
  },
  914 : {
     "Day":914
    ,"SD4neg":8.212
    ,"SD3neg":9.368
    ,"SD2neg":10.524
    ,"SD1neg":11.830
    ,"SD0":13.305
    ,"SD1":14.974
    ,"SD2":16.861
    ,"SD3":18.999
    ,"SD4":21.136
  },
  915 : {
     "Day":915
    ,"SD4neg":8.216
    ,"SD3neg":9.372
    ,"SD2neg":10.529
    ,"SD1neg":11.835
    ,"SD0":13.311
    ,"SD1":14.981
    ,"SD2":16.870
    ,"SD3":19.009
    ,"SD4":21.148
  },
  916 : {
     "Day":916
    ,"SD4neg":8.219
    ,"SD3neg":9.376
    ,"SD2neg":10.533
    ,"SD1neg":11.840
    ,"SD0":13.317
    ,"SD1":14.987
    ,"SD2":16.878
    ,"SD3":19.018
    ,"SD4":21.158
  },
  917 : {
     "Day":917
    ,"SD4neg":8.222
    ,"SD3neg":9.380
    ,"SD2neg":10.538
    ,"SD1neg":11.845
    ,"SD0":13.323
    ,"SD1":14.995
    ,"SD2":16.886
    ,"SD3":19.028
    ,"SD4":21.170
  },
  918 : {
     "Day":918
    ,"SD4neg":8.225
    ,"SD3neg":9.384
    ,"SD2neg":10.542
    ,"SD1neg":11.850
    ,"SD0":13.329
    ,"SD1":15.001
    ,"SD2":16.894
    ,"SD3":19.037
    ,"SD4":21.181
  },
  919 : {
     "Day":919
    ,"SD4neg":8.228
    ,"SD3neg":9.387
    ,"SD2neg":10.546
    ,"SD1neg":11.855
    ,"SD0":13.335
    ,"SD1":15.009
    ,"SD2":16.903
    ,"SD3":19.047
    ,"SD4":21.192
  },
  920 : {
     "Day":920
    ,"SD4neg":8.231
    ,"SD3neg":9.391
    ,"SD2neg":10.550
    ,"SD1neg":11.860
    ,"SD0":13.341
    ,"SD1":15.015
    ,"SD2":16.911
    ,"SD3":19.057
    ,"SD4":21.204
  },
  921 : {
     "Day":921
    ,"SD4neg":8.235
    ,"SD3neg":9.395
    ,"SD2neg":10.555
    ,"SD1neg":11.865
    ,"SD0":13.347
    ,"SD1":15.022
    ,"SD2":16.919
    ,"SD3":19.067
    ,"SD4":21.215
  },
  922 : {
     "Day":922
    ,"SD4neg":8.238
    ,"SD3neg":9.398
    ,"SD2neg":10.559
    ,"SD1neg":11.870
    ,"SD0":13.353
    ,"SD1":15.030
    ,"SD2":16.927
    ,"SD3":19.077
    ,"SD4":21.226
  },
  923 : {
     "Day":923
    ,"SD4neg":8.241
    ,"SD3neg":9.402
    ,"SD2neg":10.563
    ,"SD1neg":11.875
    ,"SD0":13.359
    ,"SD1":15.036
    ,"SD2":16.936
    ,"SD3":19.087
    ,"SD4":21.238
  },
  924 : {
     "Day":924
    ,"SD4neg":8.244
    ,"SD3neg":9.406
    ,"SD2neg":10.568
    ,"SD1neg":11.881
    ,"SD0":13.365
    ,"SD1":15.043
    ,"SD2":16.944
    ,"SD3":19.096
    ,"SD4":21.249
  },
  925 : {
     "Day":925
    ,"SD4neg":8.247
    ,"SD3neg":9.409
    ,"SD2neg":10.572
    ,"SD1neg":11.886
    ,"SD0":13.370
    ,"SD1":15.050
    ,"SD2":16.952
    ,"SD3":19.106
    ,"SD4":21.260
  },
  926 : {
     "Day":926
    ,"SD4neg":8.250
    ,"SD3neg":9.413
    ,"SD2neg":10.577
    ,"SD1neg":11.891
    ,"SD0":13.376
    ,"SD1":15.057
    ,"SD2":16.960
    ,"SD3":19.116
    ,"SD4":21.271
  },
  927 : {
     "Day":927
    ,"SD4neg":8.253
    ,"SD3neg":9.417
    ,"SD2neg":10.581
    ,"SD1neg":11.896
    ,"SD0":13.382
    ,"SD1":15.064
    ,"SD2":16.968
    ,"SD3":19.125
    ,"SD4":21.282
  },
  928 : {
     "Day":928
    ,"SD4neg":8.256
    ,"SD3neg":9.421
    ,"SD2neg":10.585
    ,"SD1neg":11.901
    ,"SD0":13.388
    ,"SD1":15.071
    ,"SD2":16.977
    ,"SD3":19.135
    ,"SD4":21.294
  },
  929 : {
     "Day":929
    ,"SD4neg":8.260
    ,"SD3neg":9.425
    ,"SD2neg":10.589
    ,"SD1neg":11.906
    ,"SD0":13.394
    ,"SD1":15.078
    ,"SD2":16.985
    ,"SD3":19.145
    ,"SD4":21.305
  },
  930 : {
     "Day":930
    ,"SD4neg":8.263
    ,"SD3neg":9.428
    ,"SD2neg":10.594
    ,"SD1neg":11.911
    ,"SD0":13.400
    ,"SD1":15.085
    ,"SD2":16.993
    ,"SD3":19.155
    ,"SD4":21.316
  },
  931 : {
     "Day":931
    ,"SD4neg":8.266
    ,"SD3neg":9.432
    ,"SD2neg":10.598
    ,"SD1neg":11.916
    ,"SD0":13.406
    ,"SD1":15.092
    ,"SD2":17.001
    ,"SD3":19.165
    ,"SD4":21.328
  },
  932 : {
     "Day":932
    ,"SD4neg":8.269
    ,"SD3neg":9.436
    ,"SD2neg":10.602
    ,"SD1neg":11.921
    ,"SD0":13.412
    ,"SD1":15.099
    ,"SD2":17.010
    ,"SD3":19.174
    ,"SD4":21.339
  },
  933 : {
     "Day":933
    ,"SD4neg":8.272
    ,"SD3neg":9.439
    ,"SD2neg":10.607
    ,"SD1neg":11.926
    ,"SD0":13.418
    ,"SD1":15.106
    ,"SD2":17.018
    ,"SD3":19.184
    ,"SD4":21.350
  },
  934 : {
     "Day":934
    ,"SD4neg":8.275
    ,"SD3neg":9.443
    ,"SD2neg":10.611
    ,"SD1neg":11.931
    ,"SD0":13.424
    ,"SD1":15.113
    ,"SD2":17.026
    ,"SD3":19.194
    ,"SD4":21.362
  },
  935 : {
     "Day":935
    ,"SD4neg":8.278
    ,"SD3neg":9.447
    ,"SD2neg":10.615
    ,"SD1neg":11.936
    ,"SD0":13.430
    ,"SD1":15.120
    ,"SD2":17.034
    ,"SD3":19.204
    ,"SD4":21.373
  },
  936 : {
     "Day":936
    ,"SD4neg":8.281
    ,"SD3neg":9.450
    ,"SD2neg":10.619
    ,"SD1neg":11.941
    ,"SD0":13.435
    ,"SD1":15.127
    ,"SD2":17.042
    ,"SD3":19.213
    ,"SD4":21.384
  },
  937 : {
     "Day":937
    ,"SD4neg":8.284
    ,"SD3neg":9.454
    ,"SD2neg":10.624
    ,"SD1neg":11.946
    ,"SD0":13.441
    ,"SD1":15.134
    ,"SD2":17.050
    ,"SD3":19.222
    ,"SD4":21.395
  },
  938 : {
     "Day":938
    ,"SD4neg":8.287
    ,"SD3neg":9.458
    ,"SD2neg":10.628
    ,"SD1neg":11.951
    ,"SD0":13.447
    ,"SD1":15.141
    ,"SD2":17.059
    ,"SD3":19.232
    ,"SD4":21.406
  },
  939 : {
     "Day":939
    ,"SD4neg":8.291
    ,"SD3neg":9.461
    ,"SD2neg":10.632
    ,"SD1neg":11.956
    ,"SD0":13.453
    ,"SD1":15.148
    ,"SD2":17.067
    ,"SD3":19.242
    ,"SD4":21.417
  },
  940 : {
     "Day":940
    ,"SD4neg":8.294
    ,"SD3neg":9.465
    ,"SD2neg":10.637
    ,"SD1neg":11.961
    ,"SD0":13.459
    ,"SD1":15.154
    ,"SD2":17.075
    ,"SD3":19.252
    ,"SD4":21.429
  },
  941 : {
     "Day":941
    ,"SD4neg":8.297
    ,"SD3neg":9.469
    ,"SD2neg":10.641
    ,"SD1neg":11.966
    ,"SD0":13.465
    ,"SD1":15.161
    ,"SD2":17.083
    ,"SD3":19.261
    ,"SD4":21.440
  },
  942 : {
     "Day":942
    ,"SD4neg":8.300
    ,"SD3neg":9.472
    ,"SD2neg":10.645
    ,"SD1neg":11.971
    ,"SD0":13.471
    ,"SD1":15.168
    ,"SD2":17.091
    ,"SD3":19.271
    ,"SD4":21.451
  },
  943 : {
     "Day":943
    ,"SD4neg":8.303
    ,"SD3neg":9.476
    ,"SD2neg":10.649
    ,"SD1neg":11.976
    ,"SD0":13.476
    ,"SD1":15.175
    ,"SD2":17.099
    ,"SD3":19.281
    ,"SD4":21.462
  },
  944 : {
     "Day":944
    ,"SD4neg":8.306
    ,"SD3neg":9.480
    ,"SD2neg":10.654
    ,"SD1neg":11.981
    ,"SD0":13.482
    ,"SD1":15.182
    ,"SD2":17.108
    ,"SD3":19.291
    ,"SD4":21.474
  },
  945 : {
     "Day":945
    ,"SD4neg":8.309
    ,"SD3neg":9.483
    ,"SD2neg":10.658
    ,"SD1neg":11.986
    ,"SD0":13.488
    ,"SD1":15.189
    ,"SD2":17.116
    ,"SD3":19.301
    ,"SD4":21.485
  },
  946 : {
     "Day":946
    ,"SD4neg":8.312
    ,"SD3neg":9.487
    ,"SD2neg":10.662
    ,"SD1neg":11.991
    ,"SD0":13.494
    ,"SD1":15.196
    ,"SD2":17.124
    ,"SD3":19.310
    ,"SD4":21.496
  },
  947 : {
     "Day":947
    ,"SD4neg":8.315
    ,"SD3neg":9.491
    ,"SD2neg":10.667
    ,"SD1neg":11.996
    ,"SD0":13.500
    ,"SD1":15.203
    ,"SD2":17.132
    ,"SD3":19.319
    ,"SD4":21.507
  },
  948 : {
     "Day":948
    ,"SD4neg":8.318
    ,"SD3neg":9.495
    ,"SD2neg":10.671
    ,"SD1neg":12.001
    ,"SD0":13.506
    ,"SD1":15.210
    ,"SD2":17.140
    ,"SD3":19.329
    ,"SD4":21.518
  },
  949 : {
     "Day":949
    ,"SD4neg":8.321
    ,"SD3neg":9.498
    ,"SD2neg":10.675
    ,"SD1neg":12.006
    ,"SD0":13.512
    ,"SD1":15.216
    ,"SD2":17.148
    ,"SD3":19.339
    ,"SD4":21.529
  },
  950 : {
     "Day":950
    ,"SD4neg":8.324
    ,"SD3neg":9.502
    ,"SD2neg":10.679
    ,"SD1neg":12.011
    ,"SD0":13.518
    ,"SD1":15.223
    ,"SD2":17.157
    ,"SD3":19.349
    ,"SD4":21.541
  },
  951 : {
     "Day":951
    ,"SD4neg":8.327
    ,"SD3neg":9.505
    ,"SD2neg":10.684
    ,"SD1neg":12.016
    ,"SD0":13.523
    ,"SD1":15.230
    ,"SD2":17.165
    ,"SD3":19.358
    ,"SD4":21.552
  },
  952 : {
     "Day":952
    ,"SD4neg":8.330
    ,"SD3neg":9.509
    ,"SD2neg":10.688
    ,"SD1neg":12.021
    ,"SD0":13.529
    ,"SD1":15.237
    ,"SD2":17.173
    ,"SD3":19.368
    ,"SD4":21.563
  },
  953 : {
     "Day":953
    ,"SD4neg":8.333
    ,"SD3neg":9.513
    ,"SD2neg":10.692
    ,"SD1neg":12.026
    ,"SD0":13.535
    ,"SD1":15.244
    ,"SD2":17.181
    ,"SD3":19.378
    ,"SD4":21.574
  },
  954 : {
     "Day":954
    ,"SD4neg":8.336
    ,"SD3neg":9.516
    ,"SD2neg":10.696
    ,"SD1neg":12.031
    ,"SD0":13.541
    ,"SD1":15.251
    ,"SD2":17.189
    ,"SD3":19.387
    ,"SD4":21.586
  },
  955 : {
     "Day":955
    ,"SD4neg":8.340
    ,"SD3neg":9.520
    ,"SD2neg":10.701
    ,"SD1neg":12.036
    ,"SD0":13.547
    ,"SD1":15.258
    ,"SD2":17.197
    ,"SD3":19.397
    ,"SD4":21.596
  },
  956 : {
     "Day":956
    ,"SD4neg":8.343
    ,"SD3neg":9.524
    ,"SD2neg":10.705
    ,"SD1neg":12.041
    ,"SD0":13.552
    ,"SD1":15.265
    ,"SD2":17.205
    ,"SD3":19.406
    ,"SD4":21.607
  },
  957 : {
     "Day":957
    ,"SD4neg":8.346
    ,"SD3neg":9.528
    ,"SD2neg":10.709
    ,"SD1neg":12.046
    ,"SD0":13.558
    ,"SD1":15.272
    ,"SD2":17.213
    ,"SD3":19.416
    ,"SD4":21.619
  },
  958 : {
     "Day":958
    ,"SD4neg":8.349
    ,"SD3neg":9.531
    ,"SD2neg":10.713
    ,"SD1neg":12.051
    ,"SD0":13.564
    ,"SD1":15.278
    ,"SD2":17.221
    ,"SD3":19.426
    ,"SD4":21.630
  },
  959 : {
     "Day":959
    ,"SD4neg":8.352
    ,"SD3neg":9.535
    ,"SD2neg":10.718
    ,"SD1neg":12.056
    ,"SD0":13.570
    ,"SD1":15.285
    ,"SD2":17.230
    ,"SD3":19.435
    ,"SD4":21.641
  },
  960 : {
     "Day":960
    ,"SD4neg":8.355
    ,"SD3neg":9.538
    ,"SD2neg":10.722
    ,"SD1neg":12.060
    ,"SD0":13.576
    ,"SD1":15.292
    ,"SD2":17.238
    ,"SD3":19.445
    ,"SD4":21.652
  },
  961 : {
     "Day":961
    ,"SD4neg":8.358
    ,"SD3neg":9.542
    ,"SD2neg":10.726
    ,"SD1neg":12.065
    ,"SD0":13.582
    ,"SD1":15.299
    ,"SD2":17.246
    ,"SD3":19.455
    ,"SD4":21.664
  },
  962 : {
     "Day":962
    ,"SD4neg":8.361
    ,"SD3neg":9.545
    ,"SD2neg":10.730
    ,"SD1neg":12.070
    ,"SD0":13.587
    ,"SD1":15.306
    ,"SD2":17.254
    ,"SD3":19.464
    ,"SD4":21.675
  },
  963 : {
     "Day":963
    ,"SD4neg":8.364
    ,"SD3neg":9.549
    ,"SD2neg":10.734
    ,"SD1neg":12.075
    ,"SD0":13.593
    ,"SD1":15.313
    ,"SD2":17.262
    ,"SD3":19.474
    ,"SD4":21.686
  },
  964 : {
     "Day":964
    ,"SD4neg":8.367
    ,"SD3neg":9.553
    ,"SD2neg":10.739
    ,"SD1neg":12.080
    ,"SD0":13.599
    ,"SD1":15.319
    ,"SD2":17.270
    ,"SD3":19.483
    ,"SD4":21.696
  },
  965 : {
     "Day":965
    ,"SD4neg":8.370
    ,"SD3neg":9.557
    ,"SD2neg":10.743
    ,"SD1neg":12.085
    ,"SD0":13.605
    ,"SD1":15.326
    ,"SD2":17.278
    ,"SD3":19.493
    ,"SD4":21.707
  },
  966 : {
     "Day":966
    ,"SD4neg":8.373
    ,"SD3neg":9.560
    ,"SD2neg":10.747
    ,"SD1neg":12.090
    ,"SD0":13.610
    ,"SD1":15.333
    ,"SD2":17.286
    ,"SD3":19.503
    ,"SD4":21.719
  },
  967 : {
     "Day":967
    ,"SD4neg":8.376
    ,"SD3neg":9.564
    ,"SD2neg":10.751
    ,"SD1neg":12.095
    ,"SD0":13.616
    ,"SD1":15.340
    ,"SD2":17.294
    ,"SD3":19.512
    ,"SD4":21.730
  },
  968 : {
     "Day":968
    ,"SD4neg":8.379
    ,"SD3neg":9.567
    ,"SD2neg":10.756
    ,"SD1neg":12.100
    ,"SD0":13.622
    ,"SD1":15.347
    ,"SD2":17.302
    ,"SD3":19.522
    ,"SD4":21.741
  },
  969 : {
     "Day":969
    ,"SD4neg":8.382
    ,"SD3neg":9.571
    ,"SD2neg":10.760
    ,"SD1neg":12.105
    ,"SD0":13.628
    ,"SD1":15.354
    ,"SD2":17.311
    ,"SD3":19.531
    ,"SD4":21.752
  },
  970 : {
     "Day":970
    ,"SD4neg":8.385
    ,"SD3neg":9.575
    ,"SD2neg":10.764
    ,"SD1neg":12.110
    ,"SD0":13.634
    ,"SD1":15.360
    ,"SD2":17.319
    ,"SD3":19.541
    ,"SD4":21.764
  },
  971 : {
     "Day":971
    ,"SD4neg":8.388
    ,"SD3neg":9.578
    ,"SD2neg":10.768
    ,"SD1neg":12.115
    ,"SD0":13.639
    ,"SD1":15.367
    ,"SD2":17.327
    ,"SD3":19.551
    ,"SD4":21.775
  },
  972 : {
     "Day":972
    ,"SD4neg":8.391
    ,"SD3neg":9.582
    ,"SD2neg":10.773
    ,"SD1neg":12.120
    ,"SD0":13.645
    ,"SD1":15.374
    ,"SD2":17.335
    ,"SD3":19.560
    ,"SD4":21.785
  },
  973 : {
     "Day":973
    ,"SD4neg":8.394
    ,"SD3neg":9.585
    ,"SD2neg":10.777
    ,"SD1neg":12.125
    ,"SD0":13.651
    ,"SD1":15.381
    ,"SD2":17.343
    ,"SD3":19.569
    ,"SD4":21.796
  },
  974 : {
     "Day":974
    ,"SD4neg":8.397
    ,"SD3neg":9.589
    ,"SD2neg":10.781
    ,"SD1neg":12.129
    ,"SD0":13.657
    ,"SD1":15.388
    ,"SD2":17.351
    ,"SD3":19.579
    ,"SD4":21.807
  },
  975 : {
     "Day":975
    ,"SD4neg":8.400
    ,"SD3neg":9.593
    ,"SD2neg":10.785
    ,"SD1neg":12.134
    ,"SD0":13.662
    ,"SD1":15.394
    ,"SD2":17.359
    ,"SD3":19.589
    ,"SD4":21.819
  },
  976 : {
     "Day":976
    ,"SD4neg":8.403
    ,"SD3neg":9.596
    ,"SD2neg":10.789
    ,"SD1neg":12.139
    ,"SD0":13.668
    ,"SD1":15.401
    ,"SD2":17.367
    ,"SD3":19.598
    ,"SD4":21.830
  },
  977 : {
     "Day":977
    ,"SD4neg":8.406
    ,"SD3neg":9.600
    ,"SD2neg":10.793
    ,"SD1neg":12.144
    ,"SD0":13.674
    ,"SD1":15.408
    ,"SD2":17.375
    ,"SD3":19.608
    ,"SD4":21.841
  },
  978 : {
     "Day":978
    ,"SD4neg":8.409
    ,"SD3neg":9.603
    ,"SD2neg":10.797
    ,"SD1neg":12.149
    ,"SD0":13.680
    ,"SD1":15.415
    ,"SD2":17.383
    ,"SD3":19.618
    ,"SD4":21.852
  },
  979 : {
     "Day":979
    ,"SD4neg":8.412
    ,"SD3neg":9.607
    ,"SD2neg":10.802
    ,"SD1neg":12.154
    ,"SD0":13.686
    ,"SD1":15.422
    ,"SD2":17.391
    ,"SD3":19.627
    ,"SD4":21.864
  },
  980 : {
     "Day":980
    ,"SD4neg":8.415
    ,"SD3neg":9.611
    ,"SD2neg":10.806
    ,"SD1neg":12.159
    ,"SD0":13.691
    ,"SD1":15.428
    ,"SD2":17.399
    ,"SD3":19.636
    ,"SD4":21.874
  },
  981 : {
     "Day":981
    ,"SD4neg":8.418
    ,"SD3neg":9.614
    ,"SD2neg":10.810
    ,"SD1neg":12.164
    ,"SD0":13.697
    ,"SD1":15.435
    ,"SD2":17.407
    ,"SD3":19.646
    ,"SD4":21.885
  },
  982 : {
     "Day":982
    ,"SD4neg":8.421
    ,"SD3neg":9.618
    ,"SD2neg":10.814
    ,"SD1neg":12.169
    ,"SD0":13.703
    ,"SD1":15.442
    ,"SD2":17.415
    ,"SD3":19.656
    ,"SD4":21.896
  },
  983 : {
     "Day":983
    ,"SD4neg":8.424
    ,"SD3neg":9.621
    ,"SD2neg":10.818
    ,"SD1neg":12.174
    ,"SD0":13.708
    ,"SD1":15.449
    ,"SD2":17.423
    ,"SD3":19.665
    ,"SD4":21.907
  },
  984 : {
     "Day":984
    ,"SD4neg":8.427
    ,"SD3neg":9.625
    ,"SD2neg":10.823
    ,"SD1neg":12.178
    ,"SD0":13.714
    ,"SD1":15.455
    ,"SD2":17.431
    ,"SD3":19.675
    ,"SD4":21.919
  },
  985 : {
     "Day":985
    ,"SD4neg":8.430
    ,"SD3neg":9.628
    ,"SD2neg":10.827
    ,"SD1neg":12.183
    ,"SD0":13.720
    ,"SD1":15.462
    ,"SD2":17.439
    ,"SD3":19.684
    ,"SD4":21.930
  },
  986 : {
     "Day":986
    ,"SD4neg":8.433
    ,"SD3neg":9.632
    ,"SD2neg":10.831
    ,"SD1neg":12.188
    ,"SD0":13.726
    ,"SD1":15.469
    ,"SD2":17.447
    ,"SD3":19.694
    ,"SD4":21.941
  },
  987 : {
     "Day":987
    ,"SD4neg":8.436
    ,"SD3neg":9.636
    ,"SD2neg":10.835
    ,"SD1neg":12.193
    ,"SD0":13.731
    ,"SD1":15.476
    ,"SD2":17.455
    ,"SD3":19.703
    ,"SD4":21.951
  },
  988 : {
     "Day":988
    ,"SD4neg":8.439
    ,"SD3neg":9.639
    ,"SD2neg":10.839
    ,"SD1neg":12.198
    ,"SD0":13.737
    ,"SD1":15.482
    ,"SD2":17.463
    ,"SD3":19.713
    ,"SD4":21.962
  },
  989 : {
     "Day":989
    ,"SD4neg":8.442
    ,"SD3neg":9.643
    ,"SD2neg":10.844
    ,"SD1neg":12.203
    ,"SD0":13.743
    ,"SD1":15.489
    ,"SD2":17.471
    ,"SD3":19.722
    ,"SD4":21.974
  },
  990 : {
     "Day":990
    ,"SD4neg":8.445
    ,"SD3neg":9.646
    ,"SD2neg":10.848
    ,"SD1neg":12.208
    ,"SD0":13.749
    ,"SD1":15.496
    ,"SD2":17.479
    ,"SD3":19.732
    ,"SD4":21.985
  },
  991 : {
     "Day":991
    ,"SD4neg":8.448
    ,"SD3neg":9.650
    ,"SD2neg":10.852
    ,"SD1neg":12.212
    ,"SD0":13.754
    ,"SD1":15.503
    ,"SD2":17.487
    ,"SD3":19.742
    ,"SD4":21.996
  },
  992 : {
     "Day":992
    ,"SD4neg":8.451
    ,"SD3neg":9.653
    ,"SD2neg":10.856
    ,"SD1neg":12.217
    ,"SD0":13.760
    ,"SD1":15.510
    ,"SD2":17.495
    ,"SD3":19.751
    ,"SD4":22.007
  },
  993 : {
     "Day":993
    ,"SD4neg":8.454
    ,"SD3neg":9.657
    ,"SD2neg":10.860
    ,"SD1neg":12.222
    ,"SD0":13.766
    ,"SD1":15.516
    ,"SD2":17.503
    ,"SD3":19.761
    ,"SD4":22.018
  },
  994 : {
     "Day":994
    ,"SD4neg":8.457
    ,"SD3neg":9.661
    ,"SD2neg":10.864
    ,"SD1neg":12.227
    ,"SD0":13.772
    ,"SD1":15.523
    ,"SD2":17.511
    ,"SD3":19.770
    ,"SD4":22.028
  },
  995 : {
     "Day":995
    ,"SD4neg":8.460
    ,"SD3neg":9.664
    ,"SD2neg":10.868
    ,"SD1neg":12.232
    ,"SD0":13.777
    ,"SD1":15.530
    ,"SD2":17.519
    ,"SD3":19.779
    ,"SD4":22.039
  },
  996 : {
     "Day":996
    ,"SD4neg":8.463
    ,"SD3neg":9.668
    ,"SD2neg":10.873
    ,"SD1neg":12.237
    ,"SD0":13.783
    ,"SD1":15.537
    ,"SD2":17.527
    ,"SD3":19.789
    ,"SD4":22.051
  },
  997 : {
     "Day":997
    ,"SD4neg":8.466
    ,"SD3neg":9.671
    ,"SD2neg":10.877
    ,"SD1neg":12.242
    ,"SD0":13.789
    ,"SD1":15.543
    ,"SD2":17.535
    ,"SD3":19.799
    ,"SD4":22.062
  },
  998 : {
     "Day":998
    ,"SD4neg":8.469
    ,"SD3neg":9.675
    ,"SD2neg":10.881
    ,"SD1neg":12.246
    ,"SD0":13.794
    ,"SD1":15.550
    ,"SD2":17.543
    ,"SD3":19.808
    ,"SD4":22.073
  },
  999 : {
     "Day":999
    ,"SD4neg":8.472
    ,"SD3neg":9.678
    ,"SD2neg":10.885
    ,"SD1neg":12.251
    ,"SD0":13.800
    ,"SD1":15.557
    ,"SD2":17.551
    ,"SD3":19.818
    ,"SD4":22.084
  },
  1000 : {
     "Day":1000
    ,"SD4neg":8.475
    ,"SD3neg":9.682
    ,"SD2neg":10.889
    ,"SD1neg":12.256
    ,"SD0":13.806
    ,"SD1":15.564
    ,"SD2":17.559
    ,"SD3":19.827
    ,"SD4":22.095
  },
  1001 : {
     "Day":1001
    ,"SD4neg":8.478
    ,"SD3neg":9.686
    ,"SD2neg":10.893
    ,"SD1neg":12.261
    ,"SD0":13.811
    ,"SD1":15.570
    ,"SD2":17.567
    ,"SD3":19.836
    ,"SD4":22.106
  },
  1002 : {
     "Day":1002
    ,"SD4neg":8.481
    ,"SD3neg":9.689
    ,"SD2neg":10.897
    ,"SD1neg":12.266
    ,"SD0":13.817
    ,"SD1":15.577
    ,"SD2":17.575
    ,"SD3":19.846
    ,"SD4":22.117
  },
  1003 : {
     "Day":1003
    ,"SD4neg":8.484
    ,"SD3neg":9.693
    ,"SD2neg":10.902
    ,"SD1neg":12.271
    ,"SD0":13.823
    ,"SD1":15.584
    ,"SD2":17.583
    ,"SD3":19.855
    ,"SD4":22.128
  },
  1004 : {
     "Day":1004
    ,"SD4neg":8.487
    ,"SD3neg":9.696
    ,"SD2neg":10.906
    ,"SD1neg":12.276
    ,"SD0":13.828
    ,"SD1":15.590
    ,"SD2":17.591
    ,"SD3":19.865
    ,"SD4":22.139
  },
  1005 : {
     "Day":1005
    ,"SD4neg":8.490
    ,"SD3neg":9.700
    ,"SD2neg":10.910
    ,"SD1neg":12.280
    ,"SD0":13.834
    ,"SD1":15.597
    ,"SD2":17.599
    ,"SD3":19.875
    ,"SD4":22.150
  },
  1006 : {
     "Day":1006
    ,"SD4neg":8.493
    ,"SD3neg":9.703
    ,"SD2neg":10.914
    ,"SD1neg":12.285
    ,"SD0":13.840
    ,"SD1":15.604
    ,"SD2":17.607
    ,"SD3":19.884
    ,"SD4":22.161
  },
  1007 : {
     "Day":1007
    ,"SD4neg":8.496
    ,"SD3neg":9.707
    ,"SD2neg":10.918
    ,"SD1neg":12.290
    ,"SD0":13.846
    ,"SD1":15.610
    ,"SD2":17.615
    ,"SD3":19.893
    ,"SD4":22.171
  },
  1008 : {
     "Day":1008
    ,"SD4neg":8.499
    ,"SD3neg":9.711
    ,"SD2neg":10.922
    ,"SD1neg":12.295
    ,"SD0":13.851
    ,"SD1":15.617
    ,"SD2":17.623
    ,"SD3":19.903
    ,"SD4":22.183
  },
  1009 : {
     "Day":1009
    ,"SD4neg":8.502
    ,"SD3neg":9.714
    ,"SD2neg":10.926
    ,"SD1neg":12.300
    ,"SD0":13.857
    ,"SD1":15.624
    ,"SD2":17.631
    ,"SD3":19.912
    ,"SD4":22.194
  },
  1010 : {
     "Day":1010
    ,"SD4neg":8.505
    ,"SD3neg":9.718
    ,"SD2neg":10.930
    ,"SD1neg":12.304
    ,"SD0":13.862
    ,"SD1":15.631
    ,"SD2":17.639
    ,"SD3":19.922
    ,"SD4":22.205
  },
  1011 : {
     "Day":1011
    ,"SD4neg":8.508
    ,"SD3neg":9.721
    ,"SD2neg":10.935
    ,"SD1neg":12.309
    ,"SD0":13.868
    ,"SD1":15.637
    ,"SD2":17.647
    ,"SD3":19.931
    ,"SD4":22.216
  },
  1012 : {
     "Day":1012
    ,"SD4neg":8.510
    ,"SD3neg":9.724
    ,"SD2neg":10.939
    ,"SD1neg":12.314
    ,"SD0":13.874
    ,"SD1":15.644
    ,"SD2":17.655
    ,"SD3":19.941
    ,"SD4":22.227
  },
  1013 : {
     "Day":1013
    ,"SD4neg":8.514
    ,"SD3neg":9.728
    ,"SD2neg":10.943
    ,"SD1neg":12.319
    ,"SD0":13.880
    ,"SD1":15.651
    ,"SD2":17.663
    ,"SD3":19.950
    ,"SD4":22.237
  },
  1014 : {
     "Day":1014
    ,"SD4neg":8.517
    ,"SD3neg":9.732
    ,"SD2neg":10.947
    ,"SD1neg":12.324
    ,"SD0":13.885
    ,"SD1":15.657
    ,"SD2":17.670
    ,"SD3":19.959
    ,"SD4":22.248
  },
  1015 : {
     "Day":1015
    ,"SD4neg":8.519
    ,"SD3neg":9.735
    ,"SD2neg":10.951
    ,"SD1neg":12.329
    ,"SD0":13.891
    ,"SD1":15.664
    ,"SD2":17.678
    ,"SD3":19.969
    ,"SD4":22.259
  },
  1016 : {
     "Day":1016
    ,"SD4neg":8.522
    ,"SD3neg":9.739
    ,"SD2neg":10.955
    ,"SD1neg":12.333
    ,"SD0":13.897
    ,"SD1":15.671
    ,"SD2":17.687
    ,"SD3":19.979
    ,"SD4":22.271
  },
  1017 : {
     "Day":1017
    ,"SD4neg":8.525
    ,"SD3neg":9.742
    ,"SD2neg":10.959
    ,"SD1neg":12.338
    ,"SD0":13.902
    ,"SD1":15.677
    ,"SD2":17.694
    ,"SD3":19.988
    ,"SD4":22.281
  },
  1018 : {
     "Day":1018
    ,"SD4neg":8.528
    ,"SD3neg":9.746
    ,"SD2neg":10.963
    ,"SD1neg":12.343
    ,"SD0":13.908
    ,"SD1":15.684
    ,"SD2":17.702
    ,"SD3":19.998
    ,"SD4":22.293
  },
  1019 : {
     "Day":1019
    ,"SD4neg":8.531
    ,"SD3neg":9.749
    ,"SD2neg":10.968
    ,"SD1neg":12.348
    ,"SD0":13.914
    ,"SD1":15.691
    ,"SD2":17.710
    ,"SD3":20.006
    ,"SD4":22.303
  },
  1020 : {
     "Day":1020
    ,"SD4neg":8.534
    ,"SD3neg":9.753
    ,"SD2neg":10.972
    ,"SD1neg":12.353
    ,"SD0":13.919
    ,"SD1":15.698
    ,"SD2":17.718
    ,"SD3":20.016
    ,"SD4":22.314
  },
  1021 : {
     "Day":1021
    ,"SD4neg":8.537
    ,"SD3neg":9.756
    ,"SD2neg":10.976
    ,"SD1neg":12.357
    ,"SD0":13.925
    ,"SD1":15.704
    ,"SD2":17.726
    ,"SD3":20.026
    ,"SD4":22.325
  },
  1022 : {
     "Day":1022
    ,"SD4neg":8.540
    ,"SD3neg":9.760
    ,"SD2neg":10.980
    ,"SD1neg":12.362
    ,"SD0":13.930
    ,"SD1":15.711
    ,"SD2":17.734
    ,"SD3":20.035
    ,"SD4":22.336
  },
  1023 : {
     "Day":1023
    ,"SD4neg":8.543
    ,"SD3neg":9.763
    ,"SD2neg":10.984
    ,"SD1neg":12.367
    ,"SD0":13.936
    ,"SD1":15.718
    ,"SD2":17.742
    ,"SD3":20.045
    ,"SD4":22.347
  },
  1024 : {
     "Day":1024
    ,"SD4neg":8.546
    ,"SD3neg":9.767
    ,"SD2neg":10.988
    ,"SD1neg":12.372
    ,"SD0":13.942
    ,"SD1":15.724
    ,"SD2":17.750
    ,"SD3":20.054
    ,"SD4":22.358
  },
  1025 : {
     "Day":1025
    ,"SD4neg":8.549
    ,"SD3neg":9.771
    ,"SD2neg":10.992
    ,"SD1neg":12.377
    ,"SD0":13.947
    ,"SD1":15.731
    ,"SD2":17.758
    ,"SD3":20.063
    ,"SD4":22.369
  },
  1026 : {
     "Day":1026
    ,"SD4neg":8.552
    ,"SD3neg":9.774
    ,"SD2neg":10.996
    ,"SD1neg":12.382
    ,"SD0":13.953
    ,"SD1":15.738
    ,"SD2":17.766
    ,"SD3":20.073
    ,"SD4":22.380
  },
  1027 : {
     "Day":1027
    ,"SD4neg":8.555
    ,"SD3neg":9.777
    ,"SD2neg":11.000
    ,"SD1neg":12.386
    ,"SD0":13.959
    ,"SD1":15.744
    ,"SD2":17.774
    ,"SD3":20.082
    ,"SD4":22.391
  },
  1028 : {
     "Day":1028
    ,"SD4neg":8.558
    ,"SD3neg":9.781
    ,"SD2neg":11.004
    ,"SD1neg":12.391
    ,"SD0":13.964
    ,"SD1":15.751
    ,"SD2":17.782
    ,"SD3":20.092
    ,"SD4":22.402
  },
  1029 : {
     "Day":1029
    ,"SD4neg":8.560
    ,"SD3neg":9.784
    ,"SD2neg":11.008
    ,"SD1neg":12.396
    ,"SD0":13.970
    ,"SD1":15.758
    ,"SD2":17.790
    ,"SD3":20.101
    ,"SD4":22.413
  },
  1030 : {
     "Day":1030
    ,"SD4neg":8.564
    ,"SD3neg":9.788
    ,"SD2neg":11.013
    ,"SD1neg":12.401
    ,"SD0":13.976
    ,"SD1":15.764
    ,"SD2":17.797
    ,"SD3":20.110
    ,"SD4":22.423
  },
  1031 : {
     "Day":1031
    ,"SD4neg":8.567
    ,"SD3neg":9.792
    ,"SD2neg":11.017
    ,"SD1neg":12.406
    ,"SD0":13.981
    ,"SD1":15.771
    ,"SD2":17.805
    ,"SD3":20.120
    ,"SD4":22.434
  },
  1032 : {
     "Day":1032
    ,"SD4neg":8.569
    ,"SD3neg":9.795
    ,"SD2neg":11.021
    ,"SD1neg":12.410
    ,"SD0":13.987
    ,"SD1":15.778
    ,"SD2":17.813
    ,"SD3":20.129
    ,"SD4":22.445
  },
  1033 : {
     "Day":1033
    ,"SD4neg":8.572
    ,"SD3neg":9.799
    ,"SD2neg":11.025
    ,"SD1neg":12.415
    ,"SD0":13.992
    ,"SD1":15.784
    ,"SD2":17.821
    ,"SD3":20.139
    ,"SD4":22.456
  },
  1034 : {
     "Day":1034
    ,"SD4neg":8.575
    ,"SD3neg":9.802
    ,"SD2neg":11.029
    ,"SD1neg":12.420
    ,"SD0":13.998
    ,"SD1":15.791
    ,"SD2":17.829
    ,"SD3":20.148
    ,"SD4":22.468
  },
  1035 : {
     "Day":1035
    ,"SD4neg":8.578
    ,"SD3neg":9.806
    ,"SD2neg":11.033
    ,"SD1neg":12.425
    ,"SD0":14.004
    ,"SD1":15.797
    ,"SD2":17.837
    ,"SD3":20.157
    ,"SD4":22.478
  },
  1036 : {
     "Day":1036
    ,"SD4neg":8.581
    ,"SD3neg":9.809
    ,"SD2neg":11.037
    ,"SD1neg":12.429
    ,"SD0":14.009
    ,"SD1":15.804
    ,"SD2":17.845
    ,"SD3":20.167
    ,"SD4":22.489
  },
  1037 : {
     "Day":1037
    ,"SD4neg":8.584
    ,"SD3neg":9.813
    ,"SD2neg":11.041
    ,"SD1neg":12.434
    ,"SD0":14.015
    ,"SD1":15.811
    ,"SD2":17.852
    ,"SD3":20.176
    ,"SD4":22.500
  },
  1038 : {
     "Day":1038
    ,"SD4neg":8.587
    ,"SD3neg":9.816
    ,"SD2neg":11.045
    ,"SD1neg":12.439
    ,"SD0":14.021
    ,"SD1":15.818
    ,"SD2":17.861
    ,"SD3":20.186
    ,"SD4":22.511
  },
  1039 : {
     "Day":1039
    ,"SD4neg":8.590
    ,"SD3neg":9.820
    ,"SD2neg":11.049
    ,"SD1neg":12.444
    ,"SD0":14.026
    ,"SD1":15.824
    ,"SD2":17.868
    ,"SD3":20.195
    ,"SD4":22.522
  },
  1040 : {
     "Day":1040
    ,"SD4neg":8.593
    ,"SD3neg":9.823
    ,"SD2neg":11.053
    ,"SD1neg":12.449
    ,"SD0":14.032
    ,"SD1":15.831
    ,"SD2":17.876
    ,"SD3":20.204
    ,"SD4":22.532
  },
  1041 : {
     "Day":1041
    ,"SD4neg":8.596
    ,"SD3neg":9.827
    ,"SD2neg":11.058
    ,"SD1neg":12.453
    ,"SD0":14.038
    ,"SD1":15.837
    ,"SD2":17.884
    ,"SD3":20.214
    ,"SD4":22.543
  },
  1042 : {
     "Day":1042
    ,"SD4neg":8.599
    ,"SD3neg":9.830
    ,"SD2neg":11.062
    ,"SD1neg":12.458
    ,"SD0":14.043
    ,"SD1":15.844
    ,"SD2":17.892
    ,"SD3":20.223
    ,"SD4":22.554
  },
  1043 : {
     "Day":1043
    ,"SD4neg":8.602
    ,"SD3neg":9.834
    ,"SD2neg":11.066
    ,"SD1neg":12.463
    ,"SD0":14.049
    ,"SD1":15.851
    ,"SD2":17.900
    ,"SD3":20.233
    ,"SD4":22.566
  },
  1044 : {
     "Day":1044
    ,"SD4neg":8.604
    ,"SD3neg":9.837
    ,"SD2neg":11.070
    ,"SD1neg":12.468
    ,"SD0":14.054
    ,"SD1":15.857
    ,"SD2":17.908
    ,"SD3":20.242
    ,"SD4":22.577
  },
  1045 : {
     "Day":1045
    ,"SD4neg":8.608
    ,"SD3neg":9.841
    ,"SD2neg":11.074
    ,"SD1neg":12.472
    ,"SD0":14.060
    ,"SD1":15.864
    ,"SD2":17.915
    ,"SD3":20.251
    ,"SD4":22.587
  },
  1046 : {
     "Day":1046
    ,"SD4neg":8.610
    ,"SD3neg":9.844
    ,"SD2neg":11.078
    ,"SD1neg":12.477
    ,"SD0":14.066
    ,"SD1":15.871
    ,"SD2":17.923
    ,"SD3":20.261
    ,"SD4":22.598
  },
  1047 : {
     "Day":1047
    ,"SD4neg":8.613
    ,"SD3neg":9.848
    ,"SD2neg":11.082
    ,"SD1neg":12.482
    ,"SD0":14.071
    ,"SD1":15.877
    ,"SD2":17.931
    ,"SD3":20.270
    ,"SD4":22.609
  },
  1048 : {
     "Day":1048
    ,"SD4neg":8.616
    ,"SD3neg":9.851
    ,"SD2neg":11.086
    ,"SD1neg":12.487
    ,"SD0":14.077
    ,"SD1":15.884
    ,"SD2":17.939
    ,"SD3":20.280
    ,"SD4":22.620
  },
  1049 : {
     "Day":1049
    ,"SD4neg":8.619
    ,"SD3neg":9.855
    ,"SD2neg":11.090
    ,"SD1neg":12.491
    ,"SD0":14.082
    ,"SD1":15.890
    ,"SD2":17.947
    ,"SD3":20.289
    ,"SD4":22.630
  },
  1050 : {
     "Day":1050
    ,"SD4neg":8.622
    ,"SD3neg":9.858
    ,"SD2neg":11.094
    ,"SD1neg":12.496
    ,"SD0":14.088
    ,"SD1":15.897
    ,"SD2":17.955
    ,"SD3":20.298
    ,"SD4":22.641
  },
  1051 : {
     "Day":1051
    ,"SD4neg":8.625
    ,"SD3neg":9.862
    ,"SD2neg":11.098
    ,"SD1neg":12.501
    ,"SD0":14.094
    ,"SD1":15.904
    ,"SD2":17.963
    ,"SD3":20.308
    ,"SD4":22.652
  },
  1052 : {
     "Day":1052
    ,"SD4neg":8.628
    ,"SD3neg":9.865
    ,"SD2neg":11.102
    ,"SD1neg":12.506
    ,"SD0":14.099
    ,"SD1":15.910
    ,"SD2":17.971
    ,"SD3":20.317
    ,"SD4":22.663
  },
  1053 : {
     "Day":1053
    ,"SD4neg":8.631
    ,"SD3neg":9.868
    ,"SD2neg":11.106
    ,"SD1neg":12.510
    ,"SD0":14.105
    ,"SD1":15.917
    ,"SD2":17.979
    ,"SD3":20.327
    ,"SD4":22.674
  },
  1054 : {
     "Day":1054
    ,"SD4neg":8.634
    ,"SD3neg":9.872
    ,"SD2neg":11.110
    ,"SD1neg":12.515
    ,"SD0":14.110
    ,"SD1":15.923
    ,"SD2":17.986
    ,"SD3":20.335
    ,"SD4":22.685
  },
  1055 : {
     "Day":1055
    ,"SD4neg":8.637
    ,"SD3neg":9.876
    ,"SD2neg":11.114
    ,"SD1neg":12.520
    ,"SD0":14.116
    ,"SD1":15.930
    ,"SD2":17.994
    ,"SD3":20.345
    ,"SD4":22.696
  },
  1056 : {
     "Day":1056
    ,"SD4neg":8.639
    ,"SD3neg":9.879
    ,"SD2neg":11.118
    ,"SD1neg":12.525
    ,"SD0":14.122
    ,"SD1":15.937
    ,"SD2":18.002
    ,"SD3":20.354
    ,"SD4":22.707
  },
  1057 : {
     "Day":1057
    ,"SD4neg":8.642
    ,"SD3neg":9.882
    ,"SD2neg":11.123
    ,"SD1neg":12.529
    ,"SD0":14.127
    ,"SD1":15.943
    ,"SD2":18.010
    ,"SD3":20.364
    ,"SD4":22.718
  },
  1058 : {
     "Day":1058
    ,"SD4neg":8.645
    ,"SD3neg":9.886
    ,"SD2neg":11.127
    ,"SD1neg":12.534
    ,"SD0":14.133
    ,"SD1":15.950
    ,"SD2":18.018
    ,"SD3":20.373
    ,"SD4":22.729
  },
  1059 : {
     "Day":1059
    ,"SD4neg":8.648
    ,"SD3neg":9.890
    ,"SD2neg":11.131
    ,"SD1neg":12.539
    ,"SD0":14.138
    ,"SD1":15.957
    ,"SD2":18.026
    ,"SD3":20.382
    ,"SD4":22.739
  },
  1060 : {
     "Day":1060
    ,"SD4neg":8.651
    ,"SD3neg":9.893
    ,"SD2neg":11.135
    ,"SD1neg":12.544
    ,"SD0":14.144
    ,"SD1":15.963
    ,"SD2":18.034
    ,"SD3":20.392
    ,"SD4":22.750
  },
  1061 : {
     "Day":1061
    ,"SD4neg":8.654
    ,"SD3neg":9.896
    ,"SD2neg":11.139
    ,"SD1neg":12.548
    ,"SD0":14.150
    ,"SD1":15.970
    ,"SD2":18.041
    ,"SD3":20.401
    ,"SD4":22.761
  },
  1062 : {
     "Day":1062
    ,"SD4neg":8.657
    ,"SD3neg":9.900
    ,"SD2neg":11.143
    ,"SD1neg":12.553
    ,"SD0":14.155
    ,"SD1":15.976
    ,"SD2":18.049
    ,"SD3":20.411
    ,"SD4":22.772
  },
  1063 : {
     "Day":1063
    ,"SD4neg":8.660
    ,"SD3neg":9.903
    ,"SD2neg":11.147
    ,"SD1neg":12.558
    ,"SD0":14.161
    ,"SD1":15.983
    ,"SD2":18.057
    ,"SD3":20.420
    ,"SD4":22.782
  },
  1064 : {
     "Day":1064
    ,"SD4neg":8.663
    ,"SD3neg":9.907
    ,"SD2neg":11.151
    ,"SD1neg":12.563
    ,"SD0":14.166
    ,"SD1":15.990
    ,"SD2":18.065
    ,"SD3":20.429
    ,"SD4":22.793
  },
  1065 : {
     "Day":1065
    ,"SD4neg":8.666
    ,"SD3neg":9.910
    ,"SD2neg":11.155
    ,"SD1neg":12.567
    ,"SD0":14.172
    ,"SD1":15.996
    ,"SD2":18.073
    ,"SD3":20.439
    ,"SD4":22.805
  },
  1066 : {
     "Day":1066
    ,"SD4neg":8.668
    ,"SD3neg":9.914
    ,"SD2neg":11.159
    ,"SD1neg":12.572
    ,"SD0":14.178
    ,"SD1":16.003
    ,"SD2":18.081
    ,"SD3":20.448
    ,"SD4":22.816
  },
  1067 : {
     "Day":1067
    ,"SD4neg":8.672
    ,"SD3neg":9.917
    ,"SD2neg":11.163
    ,"SD1neg":12.577
    ,"SD0":14.183
    ,"SD1":16.009
    ,"SD2":18.088
    ,"SD3":20.457
    ,"SD4":22.826
  },
  1068 : {
     "Day":1068
    ,"SD4neg":8.674
    ,"SD3neg":9.921
    ,"SD2neg":11.167
    ,"SD1neg":12.582
    ,"SD0":14.189
    ,"SD1":16.016
    ,"SD2":18.096
    ,"SD3":20.467
    ,"SD4":22.837
  },
  1069 : {
     "Day":1069
    ,"SD4neg":8.677
    ,"SD3neg":9.924
    ,"SD2neg":11.171
    ,"SD1neg":12.586
    ,"SD0":14.194
    ,"SD1":16.023
    ,"SD2":18.104
    ,"SD3":20.476
    ,"SD4":22.848
  },
  1070 : {
     "Day":1070
    ,"SD4neg":8.680
    ,"SD3neg":9.928
    ,"SD2neg":11.175
    ,"SD1neg":12.591
    ,"SD0":14.200
    ,"SD1":16.029
    ,"SD2":18.112
    ,"SD3":20.485
    ,"SD4":22.859
  },
  1071 : {
     "Day":1071
    ,"SD4neg":8.683
    ,"SD3neg":9.931
    ,"SD2neg":11.179
    ,"SD1neg":12.596
    ,"SD0":14.205
    ,"SD1":16.036
    ,"SD2":18.120
    ,"SD3":20.495
    ,"SD4":22.870
  },
  1072 : {
     "Day":1072
    ,"SD4neg":8.686
    ,"SD3neg":9.935
    ,"SD2neg":11.183
    ,"SD1neg":12.601
    ,"SD0":14.211
    ,"SD1":16.042
    ,"SD2":18.127
    ,"SD3":20.504
    ,"SD4":22.880
  },
  1073 : {
     "Day":1073
    ,"SD4neg":8.689
    ,"SD3neg":9.938
    ,"SD2neg":11.187
    ,"SD1neg":12.605
    ,"SD0":14.216
    ,"SD1":16.049
    ,"SD2":18.135
    ,"SD3":20.513
    ,"SD4":22.891
  },
  1074 : {
     "Day":1074
    ,"SD4neg":8.692
    ,"SD3neg":9.942
    ,"SD2neg":11.191
    ,"SD1neg":12.610
    ,"SD0":14.222
    ,"SD1":16.056
    ,"SD2":18.143
    ,"SD3":20.523
    ,"SD4":22.902
  },
  1075 : {
     "Day":1075
    ,"SD4neg":8.694
    ,"SD3neg":9.945
    ,"SD2neg":11.195
    ,"SD1neg":12.615
    ,"SD0":14.228
    ,"SD1":16.062
    ,"SD2":18.151
    ,"SD3":20.532
    ,"SD4":22.913
  },
  1076 : {
     "Day":1076
    ,"SD4neg":8.698
    ,"SD3neg":9.949
    ,"SD2neg":11.200
    ,"SD1neg":12.620
    ,"SD0":14.233
    ,"SD1":16.069
    ,"SD2":18.159
    ,"SD3":20.541
    ,"SD4":22.924
  },
  1077 : {
     "Day":1077
    ,"SD4neg":8.700
    ,"SD3neg":9.952
    ,"SD2neg":11.204
    ,"SD1neg":12.624
    ,"SD0":14.239
    ,"SD1":16.075
    ,"SD2":18.167
    ,"SD3":20.551
    ,"SD4":22.935
  },
  1078 : {
     "Day":1078
    ,"SD4neg":8.703
    ,"SD3neg":9.955
    ,"SD2neg":11.207
    ,"SD1neg":12.629
    ,"SD0":14.244
    ,"SD1":16.082
    ,"SD2":18.175
    ,"SD3":20.560
    ,"SD4":22.946
  },
  1079 : {
     "Day":1079
    ,"SD4neg":8.706
    ,"SD3neg":9.959
    ,"SD2neg":11.211
    ,"SD1neg":12.634
    ,"SD0":14.250
    ,"SD1":16.089
    ,"SD2":18.183
    ,"SD3":20.570
    ,"SD4":22.957
  },
  1080 : {
     "Day":1080
    ,"SD4neg":8.709
    ,"SD3neg":9.962
    ,"SD2neg":11.216
    ,"SD1neg":12.638
    ,"SD0":14.255
    ,"SD1":16.095
    ,"SD2":18.190
    ,"SD3":20.578
    ,"SD4":22.967
  },
  1081 : {
     "Day":1081
    ,"SD4neg":8.712
    ,"SD3neg":9.966
    ,"SD2neg":11.220
    ,"SD1neg":12.643
    ,"SD0":14.261
    ,"SD1":16.102
    ,"SD2":18.198
    ,"SD3":20.588
    ,"SD4":22.978
  },
  1082 : {
     "Day":1082
    ,"SD4neg":8.715
    ,"SD3neg":9.969
    ,"SD2neg":11.224
    ,"SD1neg":12.648
    ,"SD0":14.267
    ,"SD1":16.108
    ,"SD2":18.206
    ,"SD3":20.597
    ,"SD4":22.989
  },
  1083 : {
     "Day":1083
    ,"SD4neg":8.718
    ,"SD3neg":9.973
    ,"SD2neg":11.228
    ,"SD1neg":12.653
    ,"SD0":14.272
    ,"SD1":16.115
    ,"SD2":18.214
    ,"SD3":20.607
    ,"SD4":23.000
  },
  1084 : {
     "Day":1084
    ,"SD4neg":8.721
    ,"SD3neg":9.976
    ,"SD2neg":11.232
    ,"SD1neg":12.657
    ,"SD0":14.278
    ,"SD1":16.121
    ,"SD2":18.221
    ,"SD3":20.616
    ,"SD4":23.010
  },
  1085 : {
     "Day":1085
    ,"SD4neg":8.724
    ,"SD3neg":9.980
    ,"SD2neg":11.236
    ,"SD1neg":12.662
    ,"SD0":14.283
    ,"SD1":16.128
    ,"SD2":18.229
    ,"SD3":20.625
    ,"SD4":23.021
  },
  1086 : {
     "Day":1086
    ,"SD4neg":8.726
    ,"SD3neg":9.983
    ,"SD2neg":11.240
    ,"SD1neg":12.667
    ,"SD0":14.289
    ,"SD1":16.135
    ,"SD2":18.237
    ,"SD3":20.635
    ,"SD4":23.032
  },
  1087 : {
     "Day":1087
    ,"SD4neg":8.729
    ,"SD3neg":9.986
    ,"SD2neg":11.244
    ,"SD1neg":12.671
    ,"SD0":14.294
    ,"SD1":16.141
    ,"SD2":18.245
    ,"SD3":20.644
    ,"SD4":23.043
  },
  1088 : {
     "Day":1088
    ,"SD4neg":8.732
    ,"SD3neg":9.990
    ,"SD2neg":11.248
    ,"SD1neg":12.676
    ,"SD0":14.300
    ,"SD1":16.148
    ,"SD2":18.253
    ,"SD3":20.653
    ,"SD4":23.054
  },
  1089 : {
     "Day":1089
    ,"SD4neg":8.735
    ,"SD3neg":9.993
    ,"SD2neg":11.252
    ,"SD1neg":12.681
    ,"SD0":14.306
    ,"SD1":16.154
    ,"SD2":18.260
    ,"SD3":20.663
    ,"SD4":23.065
  },
  1090 : {
     "Day":1090
    ,"SD4neg":8.738
    ,"SD3neg":9.997
    ,"SD2neg":11.256
    ,"SD1neg":12.686
    ,"SD0":14.311
    ,"SD1":16.161
    ,"SD2":18.268
    ,"SD3":20.672
    ,"SD4":23.076
  },
  1091 : {
     "Day":1091
    ,"SD4neg":8.741
    ,"SD3neg":10.000
    ,"SD2neg":11.260
    ,"SD1neg":12.690
    ,"SD0":14.317
    ,"SD1":16.168
    ,"SD2":18.276
    ,"SD3":20.682
    ,"SD4":23.087
  },
  1092 : {
     "Day":1092
    ,"SD4neg":8.744
    ,"SD3neg":10.004
    ,"SD2neg":11.264
    ,"SD1neg":12.695
    ,"SD0":14.322
    ,"SD1":16.174
    ,"SD2":18.284
    ,"SD3":20.690
    ,"SD4":23.097
  },
  1093 : {
     "Day":1093
    ,"SD4neg":8.747
    ,"SD3neg":10.007
    ,"SD2neg":11.268
    ,"SD1neg":12.700
    ,"SD0":14.328
    ,"SD1":16.181
    ,"SD2":18.292
    ,"SD3":20.700
    ,"SD4":23.108
  },
  1094 : {
     "Day":1094
    ,"SD4neg":8.749
    ,"SD3neg":10.011
    ,"SD2neg":11.272
    ,"SD1neg":12.704
    ,"SD0":14.333
    ,"SD1":16.187
    ,"SD2":18.300
    ,"SD3":20.709
    ,"SD4":23.119
  },
  1095 : {
     "Day":1095
    ,"SD4neg":8.752
    ,"SD3neg":10.014
    ,"SD2neg":11.276
    ,"SD1neg":12.709
    ,"SD0":14.339
    ,"SD1":16.194
    ,"SD2":18.307
    ,"SD3":20.719
    ,"SD4":23.130
  },
  1096 : {
     "Day":1096
    ,"SD4neg":8.755
    ,"SD3neg":10.018
    ,"SD2neg":11.280
    ,"SD1neg":12.714
    ,"SD0":14.344
    ,"SD1":16.200
    ,"SD2":18.315
    ,"SD3":20.728
    ,"SD4":23.140
  },
  1097 : {
     "Day":1097
    ,"SD4neg":8.758
    ,"SD3neg":10.021
    ,"SD2neg":11.284
    ,"SD1neg":12.719
    ,"SD0":14.350
    ,"SD1":16.207
    ,"SD2":18.323
    ,"SD3":20.737
    ,"SD4":23.151
  },
  1098 : {
     "Day":1098
    ,"SD4neg":8.761
    ,"SD3neg":10.024
    ,"SD2neg":11.288
    ,"SD1neg":12.723
    ,"SD0":14.355
    ,"SD1":16.213
    ,"SD2":18.331
    ,"SD3":20.747
    ,"SD4":23.162
  },
  1099 : {
     "Day":1099
    ,"SD4neg":8.764
    ,"SD3neg":10.028
    ,"SD2neg":11.292
    ,"SD1neg":12.728
    ,"SD0":14.361
    ,"SD1":16.220
    ,"SD2":18.338
    ,"SD3":20.755
    ,"SD4":23.172
  },
  1100 : {
     "Day":1100
    ,"SD4neg":8.767
    ,"SD3neg":10.031
    ,"SD2neg":11.296
    ,"SD1neg":12.733
    ,"SD0":14.366
    ,"SD1":16.226
    ,"SD2":18.346
    ,"SD3":20.765
    ,"SD4":23.184
  },
  1101 : {
     "Day":1101
    ,"SD4neg":8.770
    ,"SD3neg":10.035
    ,"SD2neg":11.300
    ,"SD1neg":12.737
    ,"SD0":14.372
    ,"SD1":16.233
    ,"SD2":18.354
    ,"SD3":20.774
    ,"SD4":23.194
  },
  1102 : {
     "Day":1102
    ,"SD4neg":8.772
    ,"SD3neg":10.038
    ,"SD2neg":11.304
    ,"SD1neg":12.742
    ,"SD0":14.378
    ,"SD1":16.240
    ,"SD2":18.362
    ,"SD3":20.784
    ,"SD4":23.205
  },
  1103 : {
     "Day":1103
    ,"SD4neg":8.776
    ,"SD3neg":10.042
    ,"SD2neg":11.308
    ,"SD1neg":12.747
    ,"SD0":14.383
    ,"SD1":16.246
    ,"SD2":18.370
    ,"SD3":20.793
    ,"SD4":23.216
  },
  1104 : {
     "Day":1104
    ,"SD4neg":8.778
    ,"SD3neg":10.045
    ,"SD2neg":11.312
    ,"SD1neg":12.751
    ,"SD0":14.389
    ,"SD1":16.253
    ,"SD2":18.377
    ,"SD3":20.802
    ,"SD4":23.227
  },
  1105 : {
     "Day":1105
    ,"SD4neg":8.781
    ,"SD3neg":10.049
    ,"SD2neg":11.316
    ,"SD1neg":12.756
    ,"SD0":14.394
    ,"SD1":16.259
    ,"SD2":18.385
    ,"SD3":20.812
    ,"SD4":23.238
  },
  1106 : {
     "Day":1106
    ,"SD4neg":8.784
    ,"SD3neg":10.052
    ,"SD2neg":11.320
    ,"SD1neg":12.761
    ,"SD0":14.400
    ,"SD1":16.266
    ,"SD2":18.393
    ,"SD3":20.821
    ,"SD4":23.249
  },
  1107 : {
     "Day":1107
    ,"SD4neg":8.787
    ,"SD3neg":10.056
    ,"SD2neg":11.324
    ,"SD1neg":12.766
    ,"SD0":14.405
    ,"SD1":16.272
    ,"SD2":18.401
    ,"SD3":20.830
    ,"SD4":23.259
  },
  1108 : {
     "Day":1108
    ,"SD4neg":8.790
    ,"SD3neg":10.059
    ,"SD2neg":11.328
    ,"SD1neg":12.770
    ,"SD0":14.411
    ,"SD1":16.279
    ,"SD2":18.409
    ,"SD3":20.839
    ,"SD4":23.270
  },
  1109 : {
     "Day":1109
    ,"SD4neg":8.793
    ,"SD3neg":10.062
    ,"SD2neg":11.332
    ,"SD1neg":12.775
    ,"SD0":14.416
    ,"SD1":16.285
    ,"SD2":18.417
    ,"SD3":20.849
    ,"SD4":23.281
  },
  1110 : {
     "Day":1110
    ,"SD4neg":8.795
    ,"SD3neg":10.066
    ,"SD2neg":11.336
    ,"SD1neg":12.780
    ,"SD0":14.422
    ,"SD1":16.292
    ,"SD2":18.424
    ,"SD3":20.858
    ,"SD4":23.292
  },
  1111 : {
     "Day":1111
    ,"SD4neg":8.798
    ,"SD3neg":10.069
    ,"SD2neg":11.340
    ,"SD1neg":12.784
    ,"SD0":14.427
    ,"SD1":16.299
    ,"SD2":18.432
    ,"SD3":20.867
    ,"SD4":23.302
  },
  1112 : {
     "Day":1112
    ,"SD4neg":8.801
    ,"SD3neg":10.073
    ,"SD2neg":11.344
    ,"SD1neg":12.789
    ,"SD0":14.433
    ,"SD1":16.305
    ,"SD2":18.440
    ,"SD3":20.877
    ,"SD4":23.314
  },
  1113 : {
     "Day":1113
    ,"SD4neg":8.804
    ,"SD3neg":10.076
    ,"SD2neg":11.348
    ,"SD1neg":12.794
    ,"SD0":14.438
    ,"SD1":16.312
    ,"SD2":18.448
    ,"SD3":20.886
    ,"SD4":23.324
  },
  1114 : {
     "Day":1114
    ,"SD4neg":8.807
    ,"SD3neg":10.080
    ,"SD2neg":11.352
    ,"SD1neg":12.798
    ,"SD0":14.444
    ,"SD1":16.318
    ,"SD2":18.455
    ,"SD3":20.895
    ,"SD4":23.334
  },
  1115 : {
     "Day":1115
    ,"SD4neg":8.810
    ,"SD3neg":10.083
    ,"SD2neg":11.356
    ,"SD1neg":12.803
    ,"SD0":14.450
    ,"SD1":16.325
    ,"SD2":18.463
    ,"SD3":20.904
    ,"SD4":23.346
  },
  1116 : {
     "Day":1116
    ,"SD4neg":8.813
    ,"SD3neg":10.086
    ,"SD2neg":11.360
    ,"SD1neg":12.808
    ,"SD0":14.455
    ,"SD1":16.331
    ,"SD2":18.471
    ,"SD3":20.914
    ,"SD4":23.357
  },
  1117 : {
     "Day":1117
    ,"SD4neg":8.815
    ,"SD3neg":10.090
    ,"SD2neg":11.364
    ,"SD1neg":12.812
    ,"SD0":14.460
    ,"SD1":16.338
    ,"SD2":18.479
    ,"SD3":20.923
    ,"SD4":23.368
  },
  1118 : {
     "Day":1118
    ,"SD4neg":8.818
    ,"SD3neg":10.093
    ,"SD2neg":11.368
    ,"SD1neg":12.817
    ,"SD0":14.466
    ,"SD1":16.344
    ,"SD2":18.486
    ,"SD3":20.932
    ,"SD4":23.378
  },
  1119 : {
     "Day":1119
    ,"SD4neg":8.821
    ,"SD3neg":10.097
    ,"SD2neg":11.372
    ,"SD1neg":12.822
    ,"SD0":14.472
    ,"SD1":16.351
    ,"SD2":18.494
    ,"SD3":20.942
    ,"SD4":23.389
  },
  1120 : {
     "Day":1120
    ,"SD4neg":8.824
    ,"SD3neg":10.100
    ,"SD2neg":11.376
    ,"SD1neg":12.827
    ,"SD0":14.477
    ,"SD1":16.357
    ,"SD2":18.502
    ,"SD3":20.951
    ,"SD4":23.400
  },
  1121 : {
     "Day":1121
    ,"SD4neg":8.827
    ,"SD3neg":10.104
    ,"SD2neg":11.380
    ,"SD1neg":12.831
    ,"SD0":14.483
    ,"SD1":16.364
    ,"SD2":18.510
    ,"SD3":20.960
    ,"SD4":23.410
  },
  1122 : {
     "Day":1122
    ,"SD4neg":8.830
    ,"SD3neg":10.107
    ,"SD2neg":11.384
    ,"SD1neg":12.836
    ,"SD0":14.488
    ,"SD1":16.370
    ,"SD2":18.517
    ,"SD3":20.969
    ,"SD4":23.421
  },
  1123 : {
     "Day":1123
    ,"SD4neg":8.833
    ,"SD3neg":10.110
    ,"SD2neg":11.388
    ,"SD1neg":12.841
    ,"SD0":14.494
    ,"SD1":16.377
    ,"SD2":18.525
    ,"SD3":20.979
    ,"SD4":23.432
  },
  1124 : {
     "Day":1124
    ,"SD4neg":8.835
    ,"SD3neg":10.114
    ,"SD2neg":11.392
    ,"SD1neg":12.845
    ,"SD0":14.499
    ,"SD1":16.384
    ,"SD2":18.533
    ,"SD3":20.988
    ,"SD4":23.443
  },
  1125 : {
     "Day":1125
    ,"SD4neg":8.839
    ,"SD3neg":10.117
    ,"SD2neg":11.396
    ,"SD1neg":12.850
    ,"SD0":14.505
    ,"SD1":16.390
    ,"SD2":18.541
    ,"SD3":20.997
    ,"SD4":23.454
  },
  1126 : {
     "Day":1126
    ,"SD4neg":8.841
    ,"SD3neg":10.121
    ,"SD2neg":11.400
    ,"SD1neg":12.855
    ,"SD0":14.510
    ,"SD1":16.397
    ,"SD2":18.549
    ,"SD3":21.007
    ,"SD4":23.465
  },
  1127 : {
     "Day":1127
    ,"SD4neg":8.844
    ,"SD3neg":10.124
    ,"SD2neg":11.404
    ,"SD1neg":12.859
    ,"SD0":14.516
    ,"SD1":16.403
    ,"SD2":18.557
    ,"SD3":21.016
    ,"SD4":23.476
  },
  1128 : {
     "Day":1128
    ,"SD4neg":8.847
    ,"SD3neg":10.128
    ,"SD2neg":11.408
    ,"SD1neg":12.864
    ,"SD0":14.521
    ,"SD1":16.410
    ,"SD2":18.564
    ,"SD3":21.025
    ,"SD4":23.486
  },
  1129 : {
     "Day":1129
    ,"SD4neg":8.850
    ,"SD3neg":10.131
    ,"SD2neg":11.412
    ,"SD1neg":12.869
    ,"SD0":14.527
    ,"SD1":16.416
    ,"SD2":18.572
    ,"SD3":21.034
    ,"SD4":23.497
  },
  1130 : {
     "Day":1130
    ,"SD4neg":8.853
    ,"SD3neg":10.134
    ,"SD2neg":11.416
    ,"SD1neg":12.873
    ,"SD0":14.532
    ,"SD1":16.423
    ,"SD2":18.580
    ,"SD3":21.044
    ,"SD4":23.508
  },
  1131 : {
     "Day":1131
    ,"SD4neg":8.855
    ,"SD3neg":10.138
    ,"SD2neg":11.420
    ,"SD1neg":12.878
    ,"SD0":14.538
    ,"SD1":16.429
    ,"SD2":18.588
    ,"SD3":21.053
    ,"SD4":23.519
  },
  1132 : {
     "Day":1132
    ,"SD4neg":8.859
    ,"SD3neg":10.141
    ,"SD2neg":11.424
    ,"SD1neg":12.883
    ,"SD0":14.543
    ,"SD1":16.436
    ,"SD2":18.595
    ,"SD3":21.062
    ,"SD4":23.529
  },
  1133 : {
     "Day":1133
    ,"SD4neg":8.861
    ,"SD3neg":10.145
    ,"SD2neg":11.428
    ,"SD1neg":12.888
    ,"SD0":14.549
    ,"SD1":16.442
    ,"SD2":18.603
    ,"SD3":21.072
    ,"SD4":23.540
  },
  1134 : {
     "Day":1134
    ,"SD4neg":8.864
    ,"SD3neg":10.148
    ,"SD2neg":11.432
    ,"SD1neg":12.892
    ,"SD0":14.554
    ,"SD1":16.449
    ,"SD2":18.611
    ,"SD3":21.081
    ,"SD4":23.551
  },
  1135 : {
     "Day":1135
    ,"SD4neg":8.867
    ,"SD3neg":10.152
    ,"SD2neg":11.436
    ,"SD1neg":12.897
    ,"SD0":14.560
    ,"SD1":16.455
    ,"SD2":18.619
    ,"SD3":21.090
    ,"SD4":23.562
  },
  1136 : {
     "Day":1136
    ,"SD4neg":8.870
    ,"SD3neg":10.155
    ,"SD2neg":11.440
    ,"SD1neg":12.902
    ,"SD0":14.565
    ,"SD1":16.462
    ,"SD2":18.626
    ,"SD3":21.099
    ,"SD4":23.573
  },
  1137 : {
     "Day":1137
    ,"SD4neg":8.873
    ,"SD3neg":10.158
    ,"SD2neg":11.444
    ,"SD1neg":12.906
    ,"SD0":14.571
    ,"SD1":16.469
    ,"SD2":18.634
    ,"SD3":21.109
    ,"SD4":23.584
  },
  1138 : {
     "Day":1138
    ,"SD4neg":8.875
    ,"SD3neg":10.162
    ,"SD2neg":11.448
    ,"SD1neg":12.911
    ,"SD0":14.576
    ,"SD1":16.475
    ,"SD2":18.642
    ,"SD3":21.118
    ,"SD4":23.595
  },
  1139 : {
     "Day":1139
    ,"SD4neg":8.879
    ,"SD3neg":10.165
    ,"SD2neg":11.452
    ,"SD1neg":12.916
    ,"SD0":14.582
    ,"SD1":16.482
    ,"SD2":18.650
    ,"SD3":21.127
    ,"SD4":23.605
  },
  1140 : {
     "Day":1140
    ,"SD4neg":8.881
    ,"SD3neg":10.169
    ,"SD2neg":11.456
    ,"SD1neg":12.920
    ,"SD0":14.588
    ,"SD1":16.488
    ,"SD2":18.658
    ,"SD3":21.137
    ,"SD4":23.616
  },
  1141 : {
     "Day":1141
    ,"SD4neg":8.884
    ,"SD3neg":10.172
    ,"SD2neg":11.460
    ,"SD1neg":12.925
    ,"SD0":14.593
    ,"SD1":16.495
    ,"SD2":18.665
    ,"SD3":21.146
    ,"SD4":23.627
  },
  1142 : {
     "Day":1142
    ,"SD4neg":8.887
    ,"SD3neg":10.176
    ,"SD2neg":11.464
    ,"SD1neg":12.930
    ,"SD0":14.598
    ,"SD1":16.501
    ,"SD2":18.673
    ,"SD3":21.155
    ,"SD4":23.637
  },
  1143 : {
     "Day":1143
    ,"SD4neg":8.890
    ,"SD3neg":10.179
    ,"SD2neg":11.468
    ,"SD1neg":12.934
    ,"SD0":14.604
    ,"SD1":16.508
    ,"SD2":18.681
    ,"SD3":21.165
    ,"SD4":23.648
  },
  1144 : {
     "Day":1144
    ,"SD4neg":8.893
    ,"SD3neg":10.182
    ,"SD2neg":11.472
    ,"SD1neg":12.939
    ,"SD0":14.610
    ,"SD1":16.514
    ,"SD2":18.689
    ,"SD3":21.174
    ,"SD4":23.659
  },
  1145 : {
     "Day":1145
    ,"SD4neg":8.896
    ,"SD3neg":10.186
    ,"SD2neg":11.476
    ,"SD1neg":12.944
    ,"SD0":14.615
    ,"SD1":16.521
    ,"SD2":18.696
    ,"SD3":21.183
    ,"SD4":23.670
  },
  1146 : {
     "Day":1146
    ,"SD4neg":8.898
    ,"SD3neg":10.189
    ,"SD2neg":11.480
    ,"SD1neg":12.948
    ,"SD0":14.620
    ,"SD1":16.527
    ,"SD2":18.704
    ,"SD3":21.192
    ,"SD4":23.681
  },
  1147 : {
     "Day":1147
    ,"SD4neg":8.901
    ,"SD3neg":10.193
    ,"SD2neg":11.484
    ,"SD1neg":12.953
    ,"SD0":14.626
    ,"SD1":16.534
    ,"SD2":18.712
    ,"SD3":21.202
    ,"SD4":23.692
  },
  1148 : {
     "Day":1148
    ,"SD4neg":8.904
    ,"SD3neg":10.196
    ,"SD2neg":11.488
    ,"SD1neg":12.958
    ,"SD0":14.632
    ,"SD1":16.540
    ,"SD2":18.720
    ,"SD3":21.211
    ,"SD4":23.703
  },
  1149 : {
     "Day":1149
    ,"SD4neg":8.907
    ,"SD3neg":10.200
    ,"SD2neg":11.492
    ,"SD1neg":12.962
    ,"SD0":14.637
    ,"SD1":16.547
    ,"SD2":18.727
    ,"SD3":21.220
    ,"SD4":23.713
  },
  1150 : {
     "Day":1150
    ,"SD4neg":8.910
    ,"SD3neg":10.203
    ,"SD2neg":11.496
    ,"SD1neg":12.967
    ,"SD0":14.643
    ,"SD1":16.553
    ,"SD2":18.735
    ,"SD3":21.230
    ,"SD4":23.724
  },
  1151 : {
     "Day":1151
    ,"SD4neg":8.913
    ,"SD3neg":10.206
    ,"SD2neg":11.500
    ,"SD1neg":12.972
    ,"SD0":14.648
    ,"SD1":16.560
    ,"SD2":18.743
    ,"SD3":21.239
    ,"SD4":23.735
  },
  1152 : {
     "Day":1152
    ,"SD4neg":8.916
    ,"SD3neg":10.210
    ,"SD2neg":11.504
    ,"SD1neg":12.976
    ,"SD0":14.654
    ,"SD1":16.566
    ,"SD2":18.751
    ,"SD3":21.248
    ,"SD4":23.745
  },
  1153 : {
     "Day":1153
    ,"SD4neg":8.918
    ,"SD3neg":10.213
    ,"SD2neg":11.508
    ,"SD1neg":12.981
    ,"SD0":14.659
    ,"SD1":16.573
    ,"SD2":18.759
    ,"SD3":21.257
    ,"SD4":23.756
  },
  1154 : {
     "Day":1154
    ,"SD4neg":8.921
    ,"SD3neg":10.216
    ,"SD2neg":11.512
    ,"SD1neg":12.986
    ,"SD0":14.665
    ,"SD1":16.580
    ,"SD2":18.766
    ,"SD3":21.267
    ,"SD4":23.767
  },
  1155 : {
     "Day":1155
    ,"SD4neg":8.924
    ,"SD3neg":10.220
    ,"SD2neg":11.516
    ,"SD1neg":12.990
    ,"SD0":14.670
    ,"SD1":16.586
    ,"SD2":18.774
    ,"SD3":21.276
    ,"SD4":23.778
  },
  1156 : {
     "Day":1156
    ,"SD4neg":8.927
    ,"SD3neg":10.223
    ,"SD2neg":11.520
    ,"SD1neg":12.995
    ,"SD0":14.676
    ,"SD1":16.593
    ,"SD2":18.782
    ,"SD3":21.285
    ,"SD4":23.789
  },
  1157 : {
     "Day":1157
    ,"SD4neg":8.930
    ,"SD3neg":10.227
    ,"SD2neg":11.524
    ,"SD1neg":13.000
    ,"SD0":14.681
    ,"SD1":16.599
    ,"SD2":18.790
    ,"SD3":21.295
    ,"SD4":23.800
  },
  1158 : {
     "Day":1158
    ,"SD4neg":8.933
    ,"SD3neg":10.230
    ,"SD2neg":11.528
    ,"SD1neg":13.004
    ,"SD0":14.687
    ,"SD1":16.606
    ,"SD2":18.797
    ,"SD3":21.304
    ,"SD4":23.810
  },
  1159 : {
     "Day":1159
    ,"SD4neg":8.936
    ,"SD3neg":10.234
    ,"SD2neg":11.532
    ,"SD1neg":13.009
    ,"SD0":14.692
    ,"SD1":16.612
    ,"SD2":18.805
    ,"SD3":21.313
    ,"SD4":23.821
  },
  1160 : {
     "Day":1160
    ,"SD4neg":8.938
    ,"SD3neg":10.237
    ,"SD2neg":11.536
    ,"SD1neg":13.014
    ,"SD0":14.698
    ,"SD1":16.619
    ,"SD2":18.813
    ,"SD3":21.323
    ,"SD4":23.832
  },
  1161 : {
     "Day":1161
    ,"SD4neg":8.941
    ,"SD3neg":10.240
    ,"SD2neg":11.540
    ,"SD1neg":13.018
    ,"SD0":14.703
    ,"SD1":16.625
    ,"SD2":18.821
    ,"SD3":21.332
    ,"SD4":23.843
  },
  1162 : {
     "Day":1162
    ,"SD4neg":8.944
    ,"SD3neg":10.244
    ,"SD2neg":11.544
    ,"SD1neg":13.023
    ,"SD0":14.709
    ,"SD1":16.632
    ,"SD2":18.828
    ,"SD3":21.341
    ,"SD4":23.854
  },
  1163 : {
     "Day":1163
    ,"SD4neg":8.947
    ,"SD3neg":10.247
    ,"SD2neg":11.548
    ,"SD1neg":13.028
    ,"SD0":14.714
    ,"SD1":16.638
    ,"SD2":18.836
    ,"SD3":21.351
    ,"SD4":23.865
  },
  1164 : {
     "Day":1164
    ,"SD4neg":8.950
    ,"SD3neg":10.251
    ,"SD2neg":11.552
    ,"SD1neg":13.032
    ,"SD0":14.720
    ,"SD1":16.645
    ,"SD2":18.844
    ,"SD3":21.360
    ,"SD4":23.876
  },
  1165 : {
     "Day":1165
    ,"SD4neg":8.953
    ,"SD3neg":10.254
    ,"SD2neg":11.556
    ,"SD1neg":13.037
    ,"SD0":14.725
    ,"SD1":16.651
    ,"SD2":18.852
    ,"SD3":21.369
    ,"SD4":23.886
  },
  1166 : {
     "Day":1166
    ,"SD4neg":8.955
    ,"SD3neg":10.258
    ,"SD2neg":11.560
    ,"SD1neg":13.042
    ,"SD0":14.731
    ,"SD1":16.658
    ,"SD2":18.860
    ,"SD3":21.378
    ,"SD4":23.897
  },
  1167 : {
     "Day":1167
    ,"SD4neg":8.958
    ,"SD3neg":10.261
    ,"SD2neg":11.564
    ,"SD1neg":13.046
    ,"SD0":14.736
    ,"SD1":16.664
    ,"SD2":18.867
    ,"SD3":21.388
    ,"SD4":23.908
  },
  1168 : {
     "Day":1168
    ,"SD4neg":8.961
    ,"SD3neg":10.264
    ,"SD2neg":11.568
    ,"SD1neg":13.051
    ,"SD0":14.742
    ,"SD1":16.671
    ,"SD2":18.875
    ,"SD3":21.397
    ,"SD4":23.918
  },
  1169 : {
     "Day":1169
    ,"SD4neg":8.964
    ,"SD3neg":10.268
    ,"SD2neg":11.572
    ,"SD1neg":13.056
    ,"SD0":14.747
    ,"SD1":16.677
    ,"SD2":18.883
    ,"SD3":21.406
    ,"SD4":23.929
  },
  1170 : {
     "Day":1170
    ,"SD4neg":8.967
    ,"SD3neg":10.271
    ,"SD2neg":11.576
    ,"SD1neg":13.060
    ,"SD0":14.753
    ,"SD1":16.684
    ,"SD2":18.891
    ,"SD3":21.416
    ,"SD4":23.941
  },
  1171 : {
     "Day":1171
    ,"SD4neg":8.970
    ,"SD3neg":10.275
    ,"SD2neg":11.580
    ,"SD1neg":13.065
    ,"SD0":14.758
    ,"SD1":16.690
    ,"SD2":18.898
    ,"SD3":21.424
    ,"SD4":23.951
  },
  1172 : {
     "Day":1172
    ,"SD4neg":8.973
    ,"SD3neg":10.278
    ,"SD2neg":11.584
    ,"SD1neg":13.070
    ,"SD0":14.764
    ,"SD1":16.697
    ,"SD2":18.906
    ,"SD3":21.434
    ,"SD4":23.962
  },
  1173 : {
     "Day":1173
    ,"SD4neg":8.975
    ,"SD3neg":10.281
    ,"SD2neg":11.587
    ,"SD1neg":13.074
    ,"SD0":14.769
    ,"SD1":16.704
    ,"SD2":18.914
    ,"SD3":21.444
    ,"SD4":23.973
  },
  1174 : {
     "Day":1174
    ,"SD4neg":8.978
    ,"SD3neg":10.285
    ,"SD2neg":11.592
    ,"SD1neg":13.079
    ,"SD0":14.775
    ,"SD1":16.710
    ,"SD2":18.922
    ,"SD3":21.452
    ,"SD4":23.983
  },
  1175 : {
     "Day":1175
    ,"SD4neg":8.981
    ,"SD3neg":10.288
    ,"SD2neg":11.595
    ,"SD1neg":13.084
    ,"SD0":14.780
    ,"SD1":16.717
    ,"SD2":18.929
    ,"SD3":21.462
    ,"SD4":23.994
  },
  1176 : {
     "Day":1176
    ,"SD4neg":8.984
    ,"SD3neg":10.292
    ,"SD2neg":11.599
    ,"SD1neg":13.088
    ,"SD0":14.786
    ,"SD1":16.723
    ,"SD2":18.937
    ,"SD3":21.471
    ,"SD4":24.005
  },
  1177 : {
     "Day":1177
    ,"SD4neg":8.987
    ,"SD3neg":10.295
    ,"SD2neg":11.604
    ,"SD1neg":13.093
    ,"SD0":14.791
    ,"SD1":16.729
    ,"SD2":18.945
    ,"SD3":21.480
    ,"SD4":24.016
  },
  1178 : {
     "Day":1178
    ,"SD4neg":8.990
    ,"SD3neg":10.299
    ,"SD2neg":11.607
    ,"SD1neg":13.098
    ,"SD0":14.797
    ,"SD1":16.736
    ,"SD2":18.953
    ,"SD3":21.490
    ,"SD4":24.027
  },
  1179 : {
     "Day":1179
    ,"SD4neg":8.992
    ,"SD3neg":10.302
    ,"SD2neg":11.611
    ,"SD1neg":13.102
    ,"SD0":14.802
    ,"SD1":16.743
    ,"SD2":18.961
    ,"SD3":21.499
    ,"SD4":24.038
  },
  1180 : {
     "Day":1180
    ,"SD4neg":8.996
    ,"SD3neg":10.305
    ,"SD2neg":11.615
    ,"SD1neg":13.107
    ,"SD0":14.808
    ,"SD1":16.749
    ,"SD2":18.968
    ,"SD3":21.508
    ,"SD4":24.048
  },
  1181 : {
     "Day":1181
    ,"SD4neg":8.998
    ,"SD3neg":10.309
    ,"SD2neg":11.619
    ,"SD1neg":13.112
    ,"SD0":14.813
    ,"SD1":16.756
    ,"SD2":18.976
    ,"SD3":21.518
    ,"SD4":24.059
  },
  1182 : {
     "Day":1182
    ,"SD4neg":9.001
    ,"SD3neg":10.312
    ,"SD2neg":11.623
    ,"SD1neg":13.116
    ,"SD0":14.819
    ,"SD1":16.762
    ,"SD2":18.984
    ,"SD3":21.527
    ,"SD4":24.070
  },
  1183 : {
     "Day":1183
    ,"SD4neg":9.004
    ,"SD3neg":10.315
    ,"SD2neg":11.627
    ,"SD1neg":13.121
    ,"SD0":14.824
    ,"SD1":16.769
    ,"SD2":18.992
    ,"SD3":21.537
    ,"SD4":24.081
  },
  1184 : {
     "Day":1184
    ,"SD4neg":9.007
    ,"SD3neg":10.319
    ,"SD2neg":11.631
    ,"SD1neg":13.126
    ,"SD0":14.830
    ,"SD1":16.775
    ,"SD2":18.999
    ,"SD3":21.545
    ,"SD4":24.092
  },
  1185 : {
     "Day":1185
    ,"SD4neg":9.009
    ,"SD3neg":10.322
    ,"SD2neg":11.635
    ,"SD1neg":13.130
    ,"SD0":14.835
    ,"SD1":16.782
    ,"SD2":19.007
    ,"SD3":21.555
    ,"SD4":24.103
  },
  1186 : {
     "Day":1186
    ,"SD4neg":9.012
    ,"SD3neg":10.326
    ,"SD2neg":11.639
    ,"SD1neg":13.135
    ,"SD0":14.841
    ,"SD1":16.788
    ,"SD2":19.015
    ,"SD3":21.564
    ,"SD4":24.114
  },
  1187 : {
     "Day":1187
    ,"SD4neg":9.015
    ,"SD3neg":10.329
    ,"SD2neg":11.643
    ,"SD1neg":13.140
    ,"SD0":14.846
    ,"SD1":16.795
    ,"SD2":19.023
    ,"SD3":21.573
    ,"SD4":24.124
  },
  1188 : {
     "Day":1188
    ,"SD4neg":9.018
    ,"SD3neg":10.333
    ,"SD2neg":11.647
    ,"SD1neg":13.144
    ,"SD0":14.852
    ,"SD1":16.801
    ,"SD2":19.031
    ,"SD3":21.583
    ,"SD4":24.135
  },
  1189 : {
     "Day":1189
    ,"SD4neg":9.021
    ,"SD3neg":10.336
    ,"SD2neg":11.651
    ,"SD1neg":13.149
    ,"SD0":14.857
    ,"SD1":16.808
    ,"SD2":19.038
    ,"SD3":21.592
    ,"SD4":24.146
  },
  1190 : {
     "Day":1190
    ,"SD4neg":9.024
    ,"SD3neg":10.339
    ,"SD2neg":11.655
    ,"SD1neg":13.154
    ,"SD0":14.863
    ,"SD1":16.814
    ,"SD2":19.046
    ,"SD3":21.601
    ,"SD4":24.156
  },
  1191 : {
     "Day":1191
    ,"SD4neg":9.027
    ,"SD3neg":10.343
    ,"SD2neg":11.659
    ,"SD1neg":13.158
    ,"SD0":14.868
    ,"SD1":16.821
    ,"SD2":19.054
    ,"SD3":21.611
    ,"SD4":24.168
  },
  1192 : {
     "Day":1192
    ,"SD4neg":9.029
    ,"SD3neg":10.346
    ,"SD2neg":11.663
    ,"SD1neg":13.163
    ,"SD0":14.874
    ,"SD1":16.827
    ,"SD2":19.062
    ,"SD3":21.620
    ,"SD4":24.179
  },
  1193 : {
     "Day":1193
    ,"SD4neg":9.032
    ,"SD3neg":10.350
    ,"SD2neg":11.667
    ,"SD1neg":13.168
    ,"SD0":14.879
    ,"SD1":16.834
    ,"SD2":19.069
    ,"SD3":21.629
    ,"SD4":24.189
  },
  1194 : {
     "Day":1194
    ,"SD4neg":9.035
    ,"SD3neg":10.353
    ,"SD2neg":11.671
    ,"SD1neg":13.172
    ,"SD0":14.885
    ,"SD1":16.840
    ,"SD2":19.077
    ,"SD3":21.639
    ,"SD4":24.200
  },
  1195 : {
     "Day":1195
    ,"SD4neg":9.038
    ,"SD3neg":10.356
    ,"SD2neg":11.675
    ,"SD1neg":13.177
    ,"SD0":14.890
    ,"SD1":16.847
    ,"SD2":19.085
    ,"SD3":21.648
    ,"SD4":24.211
  },
  1196 : {
     "Day":1196
    ,"SD4neg":9.041
    ,"SD3neg":10.360
    ,"SD2neg":11.679
    ,"SD1neg":13.182
    ,"SD0":14.896
    ,"SD1":16.853
    ,"SD2":19.093
    ,"SD3":21.657
    ,"SD4":24.222
  },
  1197 : {
     "Day":1197
    ,"SD4neg":9.044
    ,"SD3neg":10.363
    ,"SD2neg":11.683
    ,"SD1neg":13.186
    ,"SD0":14.901
    ,"SD1":16.860
    ,"SD2":19.100
    ,"SD3":21.667
    ,"SD4":24.233
  },
  1198 : {
     "Day":1198
    ,"SD4neg":9.046
    ,"SD3neg":10.367
    ,"SD2neg":11.687
    ,"SD1neg":13.191
    ,"SD0":14.907
    ,"SD1":16.867
    ,"SD2":19.108
    ,"SD3":21.676
    ,"SD4":24.244
  },
  1199 : {
     "Day":1199
    ,"SD4neg":9.049
    ,"SD3neg":10.370
    ,"SD2neg":11.691
    ,"SD1neg":13.196
    ,"SD0":14.912
    ,"SD1":16.873
    ,"SD2":19.116
    ,"SD3":21.685
    ,"SD4":24.254
  },
  1200 : {
     "Day":1200
    ,"SD4neg":9.052
    ,"SD3neg":10.373
    ,"SD2neg":11.695
    ,"SD1neg":13.200
    ,"SD0":14.918
    ,"SD1":16.880
    ,"SD2":19.124
    ,"SD3":21.694
    ,"SD4":24.265
  },
  1201 : {
     "Day":1201
    ,"SD4neg":9.055
    ,"SD3neg":10.377
    ,"SD2neg":11.699
    ,"SD1neg":13.205
    ,"SD0":14.923
    ,"SD1":16.886
    ,"SD2":19.132
    ,"SD3":21.704
    ,"SD4":24.276
  },
  1202 : {
     "Day":1202
    ,"SD4neg":9.058
    ,"SD3neg":10.380
    ,"SD2neg":11.703
    ,"SD1neg":13.210
    ,"SD0":14.929
    ,"SD1":16.893
    ,"SD2":19.139
    ,"SD3":21.713
    ,"SD4":24.286
  },
  1203 : {
     "Day":1203
    ,"SD4neg":9.061
    ,"SD3neg":10.384
    ,"SD2neg":11.707
    ,"SD1neg":13.214
    ,"SD0":14.934
    ,"SD1":16.899
    ,"SD2":19.147
    ,"SD3":21.722
    ,"SD4":24.298
  },
  1204 : {
     "Day":1204
    ,"SD4neg":9.063
    ,"SD3neg":10.387
    ,"SD2neg":11.711
    ,"SD1neg":13.219
    ,"SD0":14.940
    ,"SD1":16.906
    ,"SD2":19.155
    ,"SD3":21.732
    ,"SD4":24.309
  },
  1205 : {
     "Day":1205
    ,"SD4neg":9.066
    ,"SD3neg":10.391
    ,"SD2neg":11.715
    ,"SD1neg":13.224
    ,"SD0":14.945
    ,"SD1":16.912
    ,"SD2":19.163
    ,"SD3":21.741
    ,"SD4":24.319
  },
  1206 : {
     "Day":1206
    ,"SD4neg":9.069
    ,"SD3neg":10.394
    ,"SD2neg":11.719
    ,"SD1neg":13.228
    ,"SD0":14.951
    ,"SD1":16.919
    ,"SD2":19.170
    ,"SD3":21.750
    ,"SD4":24.330
  },
  1207 : {
     "Day":1207
    ,"SD4neg":9.072
    ,"SD3neg":10.397
    ,"SD2neg":11.723
    ,"SD1neg":13.233
    ,"SD0":14.956
    ,"SD1":16.925
    ,"SD2":19.178
    ,"SD3":21.760
    ,"SD4":24.342
  },
  1208 : {
     "Day":1208
    ,"SD4neg":9.075
    ,"SD3neg":10.401
    ,"SD2neg":11.727
    ,"SD1neg":13.238
    ,"SD0":14.962
    ,"SD1":16.932
    ,"SD2":19.186
    ,"SD3":21.769
    ,"SD4":24.352
  },
  1209 : {
     "Day":1209
    ,"SD4neg":9.078
    ,"SD3neg":10.404
    ,"SD2neg":11.731
    ,"SD1neg":13.242
    ,"SD0":14.967
    ,"SD1":16.938
    ,"SD2":19.194
    ,"SD3":21.778
    ,"SD4":24.363
  },
  1210 : {
     "Day":1210
    ,"SD4neg":9.080
    ,"SD3neg":10.407
    ,"SD2neg":11.734
    ,"SD1neg":13.247
    ,"SD0":14.973
    ,"SD1":16.945
    ,"SD2":19.202
    ,"SD3":21.788
    ,"SD4":24.374
  },
  1211 : {
     "Day":1211
    ,"SD4neg":9.083
    ,"SD3neg":10.411
    ,"SD2neg":11.739
    ,"SD1neg":13.252
    ,"SD0":14.978
    ,"SD1":16.951
    ,"SD2":19.209
    ,"SD3":21.797
    ,"SD4":24.384
  },
  1212 : {
     "Day":1212
    ,"SD4neg":9.086
    ,"SD3neg":10.414
    ,"SD2neg":11.742
    ,"SD1neg":13.256
    ,"SD0":14.984
    ,"SD1":16.958
    ,"SD2":19.217
    ,"SD3":21.806
    ,"SD4":24.395
  },
  1213 : {
     "Day":1213
    ,"SD4neg":9.089
    ,"SD3neg":10.418
    ,"SD2neg":11.746
    ,"SD1neg":13.261
    ,"SD0":14.989
    ,"SD1":16.964
    ,"SD2":19.225
    ,"SD3":21.816
    ,"SD4":24.407
  },
  1214 : {
     "Day":1214
    ,"SD4neg":9.092
    ,"SD3neg":10.421
    ,"SD2neg":11.750
    ,"SD1neg":13.266
    ,"SD0":14.995
    ,"SD1":16.971
    ,"SD2":19.233
    ,"SD3":21.825
    ,"SD4":24.417
  },
  1215 : {
     "Day":1215
    ,"SD4neg":9.095
    ,"SD3neg":10.425
    ,"SD2neg":11.754
    ,"SD1neg":13.270
    ,"SD0":15.000
    ,"SD1":16.977
    ,"SD2":19.241
    ,"SD3":21.834
    ,"SD4":24.428
  },
  1216 : {
     "Day":1216
    ,"SD4neg":9.097
    ,"SD3neg":10.428
    ,"SD2neg":11.758
    ,"SD1neg":13.275
    ,"SD0":15.006
    ,"SD1":16.984
    ,"SD2":19.248
    ,"SD3":21.844
    ,"SD4":24.439
  },
  1217 : {
     "Day":1217
    ,"SD4neg":9.100
    ,"SD3neg":10.431
    ,"SD2neg":11.762
    ,"SD1neg":13.280
    ,"SD0":15.011
    ,"SD1":16.990
    ,"SD2":19.256
    ,"SD3":21.853
    ,"SD4":24.449
  },
  1218 : {
     "Day":1218
    ,"SD4neg":9.103
    ,"SD3neg":10.435
    ,"SD2neg":11.766
    ,"SD1neg":13.284
    ,"SD0":15.017
    ,"SD1":16.997
    ,"SD2":19.264
    ,"SD3":21.862
    ,"SD4":24.461
  },
  1219 : {
     "Day":1219
    ,"SD4neg":9.106
    ,"SD3neg":10.438
    ,"SD2neg":11.770
    ,"SD1neg":13.289
    ,"SD0":15.022
    ,"SD1":17.004
    ,"SD2":19.272
    ,"SD3":21.872
    ,"SD4":24.472
  },
  1220 : {
     "Day":1220
    ,"SD4neg":9.109
    ,"SD3neg":10.442
    ,"SD2neg":11.774
    ,"SD1neg":13.294
    ,"SD0":15.028
    ,"SD1":17.010
    ,"SD2":19.279
    ,"SD3":21.881
    ,"SD4":24.482
  },
  1221 : {
     "Day":1221
    ,"SD4neg":9.112
    ,"SD3neg":10.445
    ,"SD2neg":11.778
    ,"SD1neg":13.298
    ,"SD0":15.033
    ,"SD1":17.017
    ,"SD2":19.287
    ,"SD3":21.890
    ,"SD4":24.493
  },
  1222 : {
     "Day":1222
    ,"SD4neg":9.114
    ,"SD3neg":10.448
    ,"SD2neg":11.782
    ,"SD1neg":13.303
    ,"SD0":15.039
    ,"SD1":17.023
    ,"SD2":19.295
    ,"SD3":21.900
    ,"SD4":24.504
  },
  1223 : {
     "Day":1223
    ,"SD4neg":9.117
    ,"SD3neg":10.452
    ,"SD2neg":11.786
    ,"SD1neg":13.307
    ,"SD0":15.044
    ,"SD1":17.030
    ,"SD2":19.303
    ,"SD3":21.909
    ,"SD4":24.515
  },
  1224 : {
     "Day":1224
    ,"SD4neg":9.120
    ,"SD3neg":10.455
    ,"SD2neg":11.790
    ,"SD1neg":13.312
    ,"SD0":15.050
    ,"SD1":17.036
    ,"SD2":19.311
    ,"SD3":21.918
    ,"SD4":24.526
  },
  1225 : {
     "Day":1225
    ,"SD4neg":9.123
    ,"SD3neg":10.458
    ,"SD2neg":11.794
    ,"SD1neg":13.317
    ,"SD0":15.055
    ,"SD1":17.043
    ,"SD2":19.318
    ,"SD3":21.928
    ,"SD4":24.537
  },
  1226 : {
     "Day":1226
    ,"SD4neg":9.126
    ,"SD3neg":10.462
    ,"SD2neg":11.798
    ,"SD1neg":13.321
    ,"SD0":15.061
    ,"SD1":17.049
    ,"SD2":19.326
    ,"SD3":21.937
    ,"SD4":24.547
  },
  1227 : {
     "Day":1227
    ,"SD4neg":9.129
    ,"SD3neg":10.465
    ,"SD2neg":11.802
    ,"SD1neg":13.326
    ,"SD0":15.066
    ,"SD1":17.056
    ,"SD2":19.334
    ,"SD3":21.946
    ,"SD4":24.559
  },
  1228 : {
     "Day":1228
    ,"SD4neg":9.131
    ,"SD3neg":10.469
    ,"SD2neg":11.806
    ,"SD1neg":13.331
    ,"SD0":15.072
    ,"SD1":17.062
    ,"SD2":19.342
    ,"SD3":21.956
    ,"SD4":24.570
  },
  1229 : {
     "Day":1229
    ,"SD4neg":9.134
    ,"SD3neg":10.472
    ,"SD2neg":11.810
    ,"SD1neg":13.335
    ,"SD0":15.077
    ,"SD1":17.069
    ,"SD2":19.350
    ,"SD3":21.965
    ,"SD4":24.581
  },
  1230 : {
     "Day":1230
    ,"SD4neg":9.137
    ,"SD3neg":10.475
    ,"SD2neg":11.814
    ,"SD1neg":13.340
    ,"SD0":15.083
    ,"SD1":17.075
    ,"SD2":19.357
    ,"SD3":21.974
    ,"SD4":24.591
  },
  1231 : {
     "Day":1231
    ,"SD4neg":9.140
    ,"SD3neg":10.479
    ,"SD2neg":11.818
    ,"SD1neg":13.345
    ,"SD0":15.088
    ,"SD1":17.082
    ,"SD2":19.365
    ,"SD3":21.984
    ,"SD4":24.603
  },
  1232 : {
     "Day":1232
    ,"SD4neg":9.143
    ,"SD3neg":10.482
    ,"SD2neg":11.822
    ,"SD1neg":13.349
    ,"SD0":15.094
    ,"SD1":17.089
    ,"SD2":19.373
    ,"SD3":21.993
    ,"SD4":24.614
  },
  1233 : {
     "Day":1233
    ,"SD4neg":9.146
    ,"SD3neg":10.486
    ,"SD2neg":11.826
    ,"SD1neg":13.354
    ,"SD0":15.099
    ,"SD1":17.095
    ,"SD2":19.381
    ,"SD3":22.002
    ,"SD4":24.624
  },
  1234 : {
     "Day":1234
    ,"SD4neg":9.148
    ,"SD3neg":10.489
    ,"SD2neg":11.830
    ,"SD1neg":13.359
    ,"SD0":15.105
    ,"SD1":17.102
    ,"SD2":19.389
    ,"SD3":22.012
    ,"SD4":24.635
  },
  1235 : {
     "Day":1235
    ,"SD4neg":9.151
    ,"SD3neg":10.492
    ,"SD2neg":11.834
    ,"SD1neg":13.363
    ,"SD0":15.110
    ,"SD1":17.108
    ,"SD2":19.397
    ,"SD3":22.022
    ,"SD4":24.646
  },
  1236 : {
     "Day":1236
    ,"SD4neg":9.154
    ,"SD3neg":10.496
    ,"SD2neg":11.838
    ,"SD1neg":13.368
    ,"SD0":15.116
    ,"SD1":17.115
    ,"SD2":19.404
    ,"SD3":22.030
    ,"SD4":24.657
  },
  1237 : {
     "Day":1237
    ,"SD4neg":9.157
    ,"SD3neg":10.499
    ,"SD2neg":11.842
    ,"SD1neg":13.373
    ,"SD0":15.121
    ,"SD1":17.121
    ,"SD2":19.412
    ,"SD3":22.040
    ,"SD4":24.668
  },
  1238 : {
     "Day":1238
    ,"SD4neg":9.159
    ,"SD3neg":10.502
    ,"SD2neg":11.845
    ,"SD1neg":13.377
    ,"SD0":15.127
    ,"SD1":17.128
    ,"SD2":19.420
    ,"SD3":22.049
    ,"SD4":24.679
  },
  1239 : {
     "Day":1239
    ,"SD4neg":9.163
    ,"SD3neg":10.506
    ,"SD2neg":11.850
    ,"SD1neg":13.382
    ,"SD0":15.132
    ,"SD1":17.134
    ,"SD2":19.427
    ,"SD3":22.058
    ,"SD4":24.689
  },
  1240 : {
     "Day":1240
    ,"SD4neg":9.165
    ,"SD3neg":10.509
    ,"SD2neg":11.853
    ,"SD1neg":13.387
    ,"SD0":15.138
    ,"SD1":17.141
    ,"SD2":19.435
    ,"SD3":22.068
    ,"SD4":24.701
  },
  1241 : {
     "Day":1241
    ,"SD4neg":9.168
    ,"SD3neg":10.513
    ,"SD2neg":11.857
    ,"SD1neg":13.391
    ,"SD0":15.143
    ,"SD1":17.147
    ,"SD2":19.443
    ,"SD3":22.078
    ,"SD4":24.712
  },
  1242 : {
     "Day":1242
    ,"SD4neg":9.171
    ,"SD3neg":10.516
    ,"SD2neg":11.861
    ,"SD1neg":13.396
    ,"SD0":15.149
    ,"SD1":17.154
    ,"SD2":19.451
    ,"SD3":22.086
    ,"SD4":24.722
  },
  1243 : {
     "Day":1243
    ,"SD4neg":9.174
    ,"SD3neg":10.520
    ,"SD2neg":11.865
    ,"SD1neg":13.401
    ,"SD0":15.154
    ,"SD1":17.160
    ,"SD2":19.459
    ,"SD3":22.096
    ,"SD4":24.733
  },
  1244 : {
     "Day":1244
    ,"SD4neg":9.176
    ,"SD3neg":10.523
    ,"SD2neg":11.869
    ,"SD1neg":13.405
    ,"SD0":15.160
    ,"SD1":17.167
    ,"SD2":19.467
    ,"SD3":22.106
    ,"SD4":24.744
  },
  1245 : {
     "Day":1245
    ,"SD4neg":9.180
    ,"SD3neg":10.526
    ,"SD2neg":11.873
    ,"SD1neg":13.410
    ,"SD0":15.165
    ,"SD1":17.173
    ,"SD2":19.474
    ,"SD3":22.114
    ,"SD4":24.755
  },
  1246 : {
     "Day":1246
    ,"SD4neg":9.182
    ,"SD3neg":10.530
    ,"SD2neg":11.877
    ,"SD1neg":13.414
    ,"SD0":15.171
    ,"SD1":17.180
    ,"SD2":19.482
    ,"SD3":22.124
    ,"SD4":24.766
  },
  1247 : {
     "Day":1247
    ,"SD4neg":9.185
    ,"SD3neg":10.533
    ,"SD2neg":11.881
    ,"SD1neg":13.419
    ,"SD0":15.176
    ,"SD1":17.186
    ,"SD2":19.490
    ,"SD3":22.134
    ,"SD4":24.777
  },
  1248 : {
     "Day":1248
    ,"SD4neg":9.188
    ,"SD3neg":10.537
    ,"SD2neg":11.885
    ,"SD1neg":13.424
    ,"SD0":15.182
    ,"SD1":17.193
    ,"SD2":19.498
    ,"SD3":22.142
    ,"SD4":24.787
  },
  1249 : {
     "Day":1249
    ,"SD4neg":9.191
    ,"SD3neg":10.540
    ,"SD2neg":11.889
    ,"SD1neg":13.428
    ,"SD0":15.187
    ,"SD1":17.199
    ,"SD2":19.506
    ,"SD3":22.152
    ,"SD4":24.799
  },
  1250 : {
     "Day":1250
    ,"SD4neg":9.193
    ,"SD3neg":10.543
    ,"SD2neg":11.893
    ,"SD1neg":13.433
    ,"SD0":15.193
    ,"SD1":17.206
    ,"SD2":19.513
    ,"SD3":22.162
    ,"SD4":24.810
  },
  1251 : {
     "Day":1251
    ,"SD4neg":9.196
    ,"SD3neg":10.546
    ,"SD2neg":11.897
    ,"SD1neg":13.438
    ,"SD0":15.198
    ,"SD1":17.213
    ,"SD2":19.521
    ,"SD3":22.171
    ,"SD4":24.821
  },
  1252 : {
     "Day":1252
    ,"SD4neg":9.199
    ,"SD3neg":10.550
    ,"SD2neg":11.901
    ,"SD1neg":13.442
    ,"SD0":15.204
    ,"SD1":17.219
    ,"SD2":19.529
    ,"SD3":22.180
    ,"SD4":24.831
  },
  1253 : {
     "Day":1253
    ,"SD4neg":9.202
    ,"SD3neg":10.553
    ,"SD2neg":11.905
    ,"SD1neg":13.447
    ,"SD0":15.209
    ,"SD1":17.226
    ,"SD2":19.537
    ,"SD3":22.190
    ,"SD4":24.843
  },
  1254 : {
     "Day":1254
    ,"SD4neg":9.205
    ,"SD3neg":10.557
    ,"SD2neg":11.909
    ,"SD1neg":13.452
    ,"SD0":15.215
    ,"SD1":17.232
    ,"SD2":19.545
    ,"SD3":22.199
    ,"SD4":24.854
  },
  1255 : {
     "Day":1255
    ,"SD4neg":9.208
    ,"SD3neg":10.560
    ,"SD2neg":11.913
    ,"SD1neg":13.456
    ,"SD0":15.220
    ,"SD1":17.239
    ,"SD2":19.552
    ,"SD3":22.208
    ,"SD4":24.864
  },
  1256 : {
     "Day":1256
    ,"SD4neg":9.210
    ,"SD3neg":10.563
    ,"SD2neg":11.917
    ,"SD1neg":13.461
    ,"SD0":15.226
    ,"SD1":17.245
    ,"SD2":19.560
    ,"SD3":22.218
    ,"SD4":24.875
  },
  1257 : {
     "Day":1257
    ,"SD4neg":9.213
    ,"SD3neg":10.567
    ,"SD2neg":11.921
    ,"SD1neg":13.465
    ,"SD0":15.231
    ,"SD1":17.252
    ,"SD2":19.568
    ,"SD3":22.227
    ,"SD4":24.887
  },
  1258 : {
     "Day":1258
    ,"SD4neg":9.216
    ,"SD3neg":10.570
    ,"SD2neg":11.925
    ,"SD1neg":13.470
    ,"SD0":15.237
    ,"SD1":17.258
    ,"SD2":19.576
    ,"SD3":22.236
    ,"SD4":24.897
  },
  1259 : {
     "Day":1259
    ,"SD4neg":9.219
    ,"SD3neg":10.574
    ,"SD2neg":11.929
    ,"SD1neg":13.475
    ,"SD0":15.242
    ,"SD1":17.265
    ,"SD2":19.584
    ,"SD3":22.246
    ,"SD4":24.908
  },
  1260 : {
     "Day":1260
    ,"SD4neg":9.221
    ,"SD3neg":10.577
    ,"SD2neg":11.932
    ,"SD1neg":13.479
    ,"SD0":15.248
    ,"SD1":17.271
    ,"SD2":19.592
    ,"SD3":22.256
    ,"SD4":24.919
  },
  1261 : {
     "Day":1261
    ,"SD4neg":9.224
    ,"SD3neg":10.581
    ,"SD2neg":11.937
    ,"SD1neg":13.484
    ,"SD0":15.253
    ,"SD1":17.278
    ,"SD2":19.599
    ,"SD3":22.264
    ,"SD4":24.930
  },
  1262 : {
     "Day":1262
    ,"SD4neg":9.227
    ,"SD3neg":10.584
    ,"SD2neg":11.940
    ,"SD1neg":13.489
    ,"SD0":15.259
    ,"SD1":17.285
    ,"SD2":19.607
    ,"SD3":22.274
    ,"SD4":24.941
  },
  1263 : {
     "Day":1263
    ,"SD4neg":9.230
    ,"SD3neg":10.587
    ,"SD2neg":11.944
    ,"SD1neg":13.493
    ,"SD0":15.264
    ,"SD1":17.291
    ,"SD2":19.615
    ,"SD3":22.284
    ,"SD4":24.952
  },
  1264 : {
     "Day":1264
    ,"SD4neg":9.233
    ,"SD3neg":10.590
    ,"SD2neg":11.948
    ,"SD1neg":13.498
    ,"SD0":15.270
    ,"SD1":17.298
    ,"SD2":19.623
    ,"SD3":22.293
    ,"SD4":24.964
  },
  1265 : {
     "Day":1265
    ,"SD4neg":9.236
    ,"SD3neg":10.594
    ,"SD2neg":11.952
    ,"SD1neg":13.503
    ,"SD0":15.275
    ,"SD1":17.304
    ,"SD2":19.631
    ,"SD3":22.302
    ,"SD4":24.974
  },
  1266 : {
     "Day":1266
    ,"SD4neg":9.238
    ,"SD3neg":10.597
    ,"SD2neg":11.956
    ,"SD1neg":13.507
    ,"SD0":15.281
    ,"SD1":17.311
    ,"SD2":19.638
    ,"SD3":22.312
    ,"SD4":24.985
  },
  1267 : {
     "Day":1267
    ,"SD4neg":9.241
    ,"SD3neg":10.601
    ,"SD2neg":11.960
    ,"SD1neg":13.512
    ,"SD0":15.286
    ,"SD1":17.317
    ,"SD2":19.646
    ,"SD3":22.322
    ,"SD4":24.997
  },
  1268 : {
     "Day":1268
    ,"SD4neg":9.244
    ,"SD3neg":10.604
    ,"SD2neg":11.964
    ,"SD1neg":13.517
    ,"SD0":15.292
    ,"SD1":17.324
    ,"SD2":19.654
    ,"SD3":22.330
    ,"SD4":25.007
  },
  1269 : {
     "Day":1269
    ,"SD4neg":9.247
    ,"SD3neg":10.607
    ,"SD2neg":11.968
    ,"SD1neg":13.521
    ,"SD0":15.297
    ,"SD1":17.330
    ,"SD2":19.662
    ,"SD3":22.340
    ,"SD4":25.018
  },
  1270 : {
     "Day":1270
    ,"SD4neg":9.249
    ,"SD3neg":10.611
    ,"SD2neg":11.972
    ,"SD1neg":13.526
    ,"SD0":15.303
    ,"SD1":17.337
    ,"SD2":19.670
    ,"SD3":22.350
    ,"SD4":25.029
  },
  1271 : {
     "Day":1271
    ,"SD4neg":9.253
    ,"SD3neg":10.614
    ,"SD2neg":11.976
    ,"SD1neg":13.531
    ,"SD0":15.308
    ,"SD1":17.343
    ,"SD2":19.677
    ,"SD3":22.359
    ,"SD4":25.040
  },
  1272 : {
     "Day":1272
    ,"SD4neg":9.255
    ,"SD3neg":10.618
    ,"SD2neg":11.980
    ,"SD1neg":13.535
    ,"SD0":15.314
    ,"SD1":17.350
    ,"SD2":19.685
    ,"SD3":22.368
    ,"SD4":25.051
  },
  1273 : {
     "Day":1273
    ,"SD4neg":9.258
    ,"SD3neg":10.621
    ,"SD2neg":11.984
    ,"SD1neg":13.540
    ,"SD0":15.319
    ,"SD1":17.356
    ,"SD2":19.693
    ,"SD3":22.378
    ,"SD4":25.062
  },
  1274 : {
     "Day":1274
    ,"SD4neg":9.261
    ,"SD3neg":10.624
    ,"SD2neg":11.988
    ,"SD1neg":13.544
    ,"SD0":15.324
    ,"SD1":17.363
    ,"SD2":19.701
    ,"SD3":22.387
    ,"SD4":25.073
  },
  1275 : {
     "Day":1275
    ,"SD4neg":9.264
    ,"SD3neg":10.628
    ,"SD2neg":11.992
    ,"SD1neg":13.549
    ,"SD0":15.330
    ,"SD1":17.369
    ,"SD2":19.709
    ,"SD3":22.396
    ,"SD4":25.084
  },
  1276 : {
     "Day":1276
    ,"SD4neg":9.266
    ,"SD3neg":10.631
    ,"SD2neg":11.996
    ,"SD1neg":13.554
    ,"SD0":15.336
    ,"SD1":17.376
    ,"SD2":19.717
    ,"SD3":22.406
    ,"SD4":25.095
  },
  1277 : {
     "Day":1277
    ,"SD4neg":9.269
    ,"SD3neg":10.634
    ,"SD2neg":11.999
    ,"SD1neg":13.558
    ,"SD0":15.341
    ,"SD1":17.383
    ,"SD2":19.725
    ,"SD3":22.415
    ,"SD4":25.106
  },
  1278 : {
     "Day":1278
    ,"SD4neg":9.272
    ,"SD3neg":10.638
    ,"SD2neg":12.004
    ,"SD1neg":13.563
    ,"SD0":15.346
    ,"SD1":17.389
    ,"SD2":19.732
    ,"SD3":22.424
    ,"SD4":25.117
  },
  1279 : {
     "Day":1279
    ,"SD4neg":9.275
    ,"SD3neg":10.641
    ,"SD2neg":12.007
    ,"SD1neg":13.568
    ,"SD0":15.352
    ,"SD1":17.396
    ,"SD2":19.740
    ,"SD3":22.434
    ,"SD4":25.128
  },
  1280 : {
     "Day":1280
    ,"SD4neg":9.277
    ,"SD3neg":10.644
    ,"SD2neg":12.011
    ,"SD1neg":13.572
    ,"SD0":15.358
    ,"SD1":17.402
    ,"SD2":19.748
    ,"SD3":22.444
    ,"SD4":25.139
  },
  1281 : {
     "Day":1281
    ,"SD4neg":9.280
    ,"SD3neg":10.648
    ,"SD2neg":12.015
    ,"SD1neg":13.577
    ,"SD0":15.363
    ,"SD1":17.409
    ,"SD2":19.756
    ,"SD3":22.453
    ,"SD4":25.151
  },
  1282 : {
     "Day":1282
    ,"SD4neg":9.283
    ,"SD3neg":10.651
    ,"SD2neg":12.019
    ,"SD1neg":13.582
    ,"SD0":15.368
    ,"SD1":17.415
    ,"SD2":19.764
    ,"SD3":22.462
    ,"SD4":25.161
  },
  1283 : {
     "Day":1283
    ,"SD4neg":9.286
    ,"SD3neg":10.655
    ,"SD2neg":12.023
    ,"SD1neg":13.586
    ,"SD0":15.374
    ,"SD1":17.422
    ,"SD2":19.772
    ,"SD3":22.472
    ,"SD4":25.172
  },
  1284 : {
     "Day":1284
    ,"SD4neg":9.289
    ,"SD3neg":10.658
    ,"SD2neg":12.027
    ,"SD1neg":13.591
    ,"SD0":15.380
    ,"SD1":17.429
    ,"SD2":19.780
    ,"SD3":22.481
    ,"SD4":25.183
  },
  1285 : {
     "Day":1285
    ,"SD4neg":9.292
    ,"SD3neg":10.661
    ,"SD2neg":12.031
    ,"SD1neg":13.596
    ,"SD0":15.385
    ,"SD1":17.435
    ,"SD2":19.787
    ,"SD3":22.490
    ,"SD4":25.194
  },
  1286 : {
     "Day":1286
    ,"SD4neg":9.294
    ,"SD3neg":10.665
    ,"SD2neg":12.035
    ,"SD1neg":13.600
    ,"SD0":15.390
    ,"SD1":17.442
    ,"SD2":19.795
    ,"SD3":22.500
    ,"SD4":25.205
  },
  1287 : {
     "Day":1287
    ,"SD4neg":9.297
    ,"SD3neg":10.668
    ,"SD2neg":12.039
    ,"SD1neg":13.605
    ,"SD0":15.396
    ,"SD1":17.448
    ,"SD2":19.803
    ,"SD3":22.510
    ,"SD4":25.216
  },
  1288 : {
     "Day":1288
    ,"SD4neg":9.300
    ,"SD3neg":10.671
    ,"SD2neg":12.043
    ,"SD1neg":13.609
    ,"SD0":15.402
    ,"SD1":17.455
    ,"SD2":19.811
    ,"SD3":22.519
    ,"SD4":25.228
  },
  1289 : {
     "Day":1289
    ,"SD4neg":9.303
    ,"SD3neg":10.675
    ,"SD2neg":12.047
    ,"SD1neg":13.614
    ,"SD0":15.407
    ,"SD1":17.461
    ,"SD2":19.819
    ,"SD3":22.528
    ,"SD4":25.238
  },
  1290 : {
     "Day":1290
    ,"SD4neg":9.305
    ,"SD3neg":10.678
    ,"SD2neg":12.051
    ,"SD1neg":13.619
    ,"SD0":15.412
    ,"SD1":17.468
    ,"SD2":19.826
    ,"SD3":22.538
    ,"SD4":25.249
  },
  1291 : {
     "Day":1291
    ,"SD4neg":9.308
    ,"SD3neg":10.681
    ,"SD2neg":12.055
    ,"SD1neg":13.623
    ,"SD0":15.418
    ,"SD1":17.474
    ,"SD2":19.834
    ,"SD3":22.547
    ,"SD4":25.261
  },
  1292 : {
     "Day":1292
    ,"SD4neg":9.311
    ,"SD3neg":10.685
    ,"SD2neg":12.059
    ,"SD1neg":13.628
    ,"SD0":15.423
    ,"SD1":17.481
    ,"SD2":19.842
    ,"SD3":22.556
    ,"SD4":25.271
  },
  1293 : {
     "Day":1293
    ,"SD4neg":9.314
    ,"SD3neg":10.688
    ,"SD2neg":12.063
    ,"SD1neg":13.633
    ,"SD0":15.429
    ,"SD1":17.487
    ,"SD2":19.850
    ,"SD3":22.566
    ,"SD4":25.282
  },
  1294 : {
     "Day":1294
    ,"SD4neg":9.316
    ,"SD3neg":10.691
    ,"SD2neg":12.066
    ,"SD1neg":13.637
    ,"SD0":15.434
    ,"SD1":17.494
    ,"SD2":19.858
    ,"SD3":22.576
    ,"SD4":25.293
  },
  1295 : {
     "Day":1295
    ,"SD4neg":9.319
    ,"SD3neg":10.695
    ,"SD2neg":12.070
    ,"SD1neg":13.642
    ,"SD0":15.440
    ,"SD1":17.501
    ,"SD2":19.866
    ,"SD3":22.585
    ,"SD4":25.305
  },
  1296 : {
     "Day":1296
    ,"SD4neg":9.322
    ,"SD3neg":10.698
    ,"SD2neg":12.074
    ,"SD1neg":13.647
    ,"SD0":15.445
    ,"SD1":17.507
    ,"SD2":19.873
    ,"SD3":22.594
    ,"SD4":25.315
  },
  1297 : {
     "Day":1297
    ,"SD4neg":9.325
    ,"SD3neg":10.702
    ,"SD2neg":12.078
    ,"SD1neg":13.651
    ,"SD0":15.451
    ,"SD1":17.514
    ,"SD2":19.881
    ,"SD3":22.604
    ,"SD4":25.326
  },
  1298 : {
     "Day":1298
    ,"SD4neg":9.328
    ,"SD3neg":10.705
    ,"SD2neg":12.082
    ,"SD1neg":13.656
    ,"SD0":15.456
    ,"SD1":17.520
    ,"SD2":19.889
    ,"SD3":22.613
    ,"SD4":25.338
  },
  1299 : {
     "Day":1299
    ,"SD4neg":9.330
    ,"SD3neg":10.708
    ,"SD2neg":12.086
    ,"SD1neg":13.660
    ,"SD0":15.462
    ,"SD1":17.527
    ,"SD2":19.897
    ,"SD3":22.623
    ,"SD4":25.349
  },
  1300 : {
     "Day":1300
    ,"SD4neg":9.333
    ,"SD3neg":10.712
    ,"SD2neg":12.090
    ,"SD1neg":13.665
    ,"SD0":15.467
    ,"SD1":17.533
    ,"SD2":19.905
    ,"SD3":22.632
    ,"SD4":25.359
  },
  1301 : {
     "Day":1301
    ,"SD4neg":9.336
    ,"SD3neg":10.715
    ,"SD2neg":12.094
    ,"SD1neg":13.670
    ,"SD0":15.473
    ,"SD1":17.540
    ,"SD2":19.913
    ,"SD3":22.642
    ,"SD4":25.371
  },
  1302 : {
     "Day":1302
    ,"SD4neg":9.339
    ,"SD3neg":10.718
    ,"SD2neg":12.098
    ,"SD1neg":13.674
    ,"SD0":15.478
    ,"SD1":17.546
    ,"SD2":19.921
    ,"SD3":22.651
    ,"SD4":25.382
  },
  1303 : {
     "Day":1303
    ,"SD4neg":9.342
    ,"SD3neg":10.722
    ,"SD2neg":12.102
    ,"SD1neg":13.679
    ,"SD0":15.484
    ,"SD1":17.553
    ,"SD2":19.928
    ,"SD3":22.660
    ,"SD4":25.392
  },
  1304 : {
     "Day":1304
    ,"SD4neg":9.344
    ,"SD3neg":10.725
    ,"SD2neg":12.106
    ,"SD1neg":13.684
    ,"SD0":15.489
    ,"SD1":17.559
    ,"SD2":19.936
    ,"SD3":22.670
    ,"SD4":25.404
  },
  1305 : {
     "Day":1305
    ,"SD4neg":9.347
    ,"SD3neg":10.728
    ,"SD2neg":12.110
    ,"SD1neg":13.688
    ,"SD0":15.495
    ,"SD1":17.566
    ,"SD2":19.944
    ,"SD3":22.679
    ,"SD4":25.415
  },
  1306 : {
     "Day":1306
    ,"SD4neg":9.350
    ,"SD3neg":10.732
    ,"SD2neg":12.114
    ,"SD1neg":13.693
    ,"SD0":15.500
    ,"SD1":17.573
    ,"SD2":19.952
    ,"SD3":22.689
    ,"SD4":25.426
  },
  1307 : {
     "Day":1307
    ,"SD4neg":9.353
    ,"SD3neg":10.735
    ,"SD2neg":12.118
    ,"SD1neg":13.697
    ,"SD0":15.506
    ,"SD1":17.579
    ,"SD2":19.960
    ,"SD3":22.698
    ,"SD4":25.437
  },
  1308 : {
     "Day":1308
    ,"SD4neg":9.355
    ,"SD3neg":10.738
    ,"SD2neg":12.121
    ,"SD1neg":13.702
    ,"SD0":15.511
    ,"SD1":17.586
    ,"SD2":19.968
    ,"SD3":22.708
    ,"SD4":25.448
  },
  1309 : {
     "Day":1309
    ,"SD4neg":9.358
    ,"SD3neg":10.742
    ,"SD2neg":12.125
    ,"SD1neg":13.707
    ,"SD0":15.517
    ,"SD1":17.592
    ,"SD2":19.976
    ,"SD3":22.717
    ,"SD4":25.459
  },
  1310 : {
     "Day":1310
    ,"SD4neg":9.361
    ,"SD3neg":10.745
    ,"SD2neg":12.129
    ,"SD1neg":13.711
    ,"SD0":15.522
    ,"SD1":17.599
    ,"SD2":19.984
    ,"SD3":22.727
    ,"SD4":25.471
  },
  1311 : {
     "Day":1311
    ,"SD4neg":9.364
    ,"SD3neg":10.749
    ,"SD2neg":12.133
    ,"SD1neg":13.716
    ,"SD0":15.528
    ,"SD1":17.605
    ,"SD2":19.991
    ,"SD3":22.736
    ,"SD4":25.481
  },
  1312 : {
     "Day":1312
    ,"SD4neg":9.367
    ,"SD3neg":10.752
    ,"SD2neg":12.137
    ,"SD1neg":13.721
    ,"SD0":15.533
    ,"SD1":17.612
    ,"SD2":19.999
    ,"SD3":22.746
    ,"SD4":25.492
  },
  1313 : {
     "Day":1313
    ,"SD4neg":9.369
    ,"SD3neg":10.755
    ,"SD2neg":12.141
    ,"SD1neg":13.725
    ,"SD0":15.539
    ,"SD1":17.618
    ,"SD2":20.007
    ,"SD3":22.755
    ,"SD4":25.504
  },
  1314 : {
     "Day":1314
    ,"SD4neg":9.372
    ,"SD3neg":10.758
    ,"SD2neg":12.145
    ,"SD1neg":13.730
    ,"SD0":15.544
    ,"SD1":17.625
    ,"SD2":20.015
    ,"SD3":22.765
    ,"SD4":25.515
  },
  1315 : {
     "Day":1315
    ,"SD4neg":9.375
    ,"SD3neg":10.762
    ,"SD2neg":12.149
    ,"SD1neg":13.735
    ,"SD0":15.550
    ,"SD1":17.631
    ,"SD2":20.023
    ,"SD3":22.774
    ,"SD4":25.525
  },
  1316 : {
     "Day":1316
    ,"SD4neg":9.377
    ,"SD3neg":10.765
    ,"SD2neg":12.153
    ,"SD1neg":13.739
    ,"SD0":15.555
    ,"SD1":17.638
    ,"SD2":20.030
    ,"SD3":22.784
    ,"SD4":25.537
  },
  1317 : {
     "Day":1317
    ,"SD4neg":9.380
    ,"SD3neg":10.768
    ,"SD2neg":12.157
    ,"SD1neg":13.744
    ,"SD0":15.561
    ,"SD1":17.645
    ,"SD2":20.039
    ,"SD3":22.793
    ,"SD4":25.548
  },
  1318 : {
     "Day":1318
    ,"SD4neg":9.383
    ,"SD3neg":10.772
    ,"SD2neg":12.161
    ,"SD1neg":13.748
    ,"SD0":15.566
    ,"SD1":17.651
    ,"SD2":20.046
    ,"SD3":22.803
    ,"SD4":25.559
  },
  1319 : {
     "Day":1319
    ,"SD4neg":9.386
    ,"SD3neg":10.775
    ,"SD2neg":12.165
    ,"SD1neg":13.753
    ,"SD0":15.572
    ,"SD1":17.658
    ,"SD2":20.054
    ,"SD3":22.812
    ,"SD4":25.570
  },
  1320 : {
     "Day":1320
    ,"SD4neg":9.389
    ,"SD3neg":10.779
    ,"SD2neg":12.168
    ,"SD1neg":13.758
    ,"SD0":15.577
    ,"SD1":17.664
    ,"SD2":20.062
    ,"SD3":22.822
    ,"SD4":25.581
  },
  1321 : {
     "Day":1321
    ,"SD4neg":9.391
    ,"SD3neg":10.782
    ,"SD2neg":12.172
    ,"SD1neg":13.762
    ,"SD0":15.583
    ,"SD1":17.671
    ,"SD2":20.070
    ,"SD3":22.831
    ,"SD4":25.592
  },
  1322 : {
     "Day":1322
    ,"SD4neg":9.394
    ,"SD3neg":10.785
    ,"SD2neg":12.176
    ,"SD1neg":13.767
    ,"SD0":15.588
    ,"SD1":17.677
    ,"SD2":20.078
    ,"SD3":22.841
    ,"SD4":25.604
  },
  1323 : {
     "Day":1323
    ,"SD4neg":9.397
    ,"SD3neg":10.789
    ,"SD2neg":12.180
    ,"SD1neg":13.772
    ,"SD0":15.594
    ,"SD1":17.684
    ,"SD2":20.086
    ,"SD3":22.850
    ,"SD4":25.614
  },
  1324 : {
     "Day":1324
    ,"SD4neg":9.400
    ,"SD3neg":10.792
    ,"SD2neg":12.184
    ,"SD1neg":13.776
    ,"SD0":15.599
    ,"SD1":17.691
    ,"SD2":20.094
    ,"SD3":22.860
    ,"SD4":25.626
  },
  1325 : {
     "Day":1325
    ,"SD4neg":9.402
    ,"SD3neg":10.795
    ,"SD2neg":12.188
    ,"SD1neg":13.781
    ,"SD0":15.605
    ,"SD1":17.697
    ,"SD2":20.102
    ,"SD3":22.869
    ,"SD4":25.637
  },
  1326 : {
     "Day":1326
    ,"SD4neg":9.405
    ,"SD3neg":10.798
    ,"SD2neg":12.192
    ,"SD1neg":13.785
    ,"SD0":15.610
    ,"SD1":17.704
    ,"SD2":20.109
    ,"SD3":22.879
    ,"SD4":25.648
  },
  1327 : {
     "Day":1327
    ,"SD4neg":9.408
    ,"SD3neg":10.802
    ,"SD2neg":12.196
    ,"SD1neg":13.790
    ,"SD0":15.616
    ,"SD1":17.710
    ,"SD2":20.117
    ,"SD3":22.888
    ,"SD4":25.660
  },
  1328 : {
     "Day":1328
    ,"SD4neg":9.411
    ,"SD3neg":10.805
    ,"SD2neg":12.200
    ,"SD1neg":13.795
    ,"SD0":15.621
    ,"SD1":17.717
    ,"SD2":20.125
    ,"SD3":22.898
    ,"SD4":25.670
  },
  1329 : {
     "Day":1329
    ,"SD4neg":9.413
    ,"SD3neg":10.808
    ,"SD2neg":12.204
    ,"SD1neg":13.799
    ,"SD0":15.627
    ,"SD1":17.723
    ,"SD2":20.133
    ,"SD3":22.907
    ,"SD4":25.681
  },
  1330 : {
     "Day":1330
    ,"SD4neg":9.416
    ,"SD3neg":10.812
    ,"SD2neg":12.208
    ,"SD1neg":13.804
    ,"SD0":15.632
    ,"SD1":17.730
    ,"SD2":20.141
    ,"SD3":22.917
    ,"SD4":25.693
  },
  1331 : {
     "Day":1331
    ,"SD4neg":9.419
    ,"SD3neg":10.815
    ,"SD2neg":12.211
    ,"SD1neg":13.808
    ,"SD0":15.638
    ,"SD1":17.737
    ,"SD2":20.149
    ,"SD3":22.927
    ,"SD4":25.704
  },
  1332 : {
     "Day":1332
    ,"SD4neg":9.422
    ,"SD3neg":10.819
    ,"SD2neg":12.215
    ,"SD1neg":13.813
    ,"SD0":15.643
    ,"SD1":17.743
    ,"SD2":20.156
    ,"SD3":22.935
    ,"SD4":25.714
  },
  1333 : {
     "Day":1333
    ,"SD4neg":9.424
    ,"SD3neg":10.822
    ,"SD2neg":12.219
    ,"SD1neg":13.818
    ,"SD0":15.649
    ,"SD1":17.750
    ,"SD2":20.164
    ,"SD3":22.945
    ,"SD4":25.726
  },
  1334 : {
     "Day":1334
    ,"SD4neg":9.427
    ,"SD3neg":10.825
    ,"SD2neg":12.223
    ,"SD1neg":13.822
    ,"SD0":15.654
    ,"SD1":17.756
    ,"SD2":20.172
    ,"SD3":22.955
    ,"SD4":25.737
  },
  1335 : {
     "Day":1335
    ,"SD4neg":9.430
    ,"SD3neg":10.828
    ,"SD2neg":12.227
    ,"SD1neg":13.827
    ,"SD0":15.660
    ,"SD1":17.763
    ,"SD2":20.180
    ,"SD3":22.964
    ,"SD4":25.749
  },
  1336 : {
     "Day":1336
    ,"SD4neg":9.432
    ,"SD3neg":10.832
    ,"SD2neg":12.231
    ,"SD1neg":13.831
    ,"SD0":15.665
    ,"SD1":17.769
    ,"SD2":20.188
    ,"SD3":22.974
    ,"SD4":25.760
  },
  1337 : {
     "Day":1337
    ,"SD4neg":9.435
    ,"SD3neg":10.835
    ,"SD2neg":12.235
    ,"SD1neg":13.836
    ,"SD0":15.670
    ,"SD1":17.776
    ,"SD2":20.196
    ,"SD3":22.983
    ,"SD4":25.770
  },
  1338 : {
     "Day":1338
    ,"SD4neg":9.438
    ,"SD3neg":10.838
    ,"SD2neg":12.239
    ,"SD1neg":13.841
    ,"SD0":15.676
    ,"SD1":17.782
    ,"SD2":20.204
    ,"SD3":22.993
    ,"SD4":25.782
  },
  1339 : {
     "Day":1339
    ,"SD4neg":9.441
    ,"SD3neg":10.842
    ,"SD2neg":12.243
    ,"SD1neg":13.845
    ,"SD0":15.682
    ,"SD1":17.789
    ,"SD2":20.212
    ,"SD3":23.002
    ,"SD4":25.793
  },
  1340 : {
     "Day":1340
    ,"SD4neg":9.443
    ,"SD3neg":10.845
    ,"SD2neg":12.247
    ,"SD1neg":13.850
    ,"SD0":15.687
    ,"SD1":17.796
    ,"SD2":20.220
    ,"SD3":23.012
    ,"SD4":25.805
  },
  1341 : {
     "Day":1341
    ,"SD4neg":9.446
    ,"SD3neg":10.848
    ,"SD2neg":12.251
    ,"SD1neg":13.855
    ,"SD0":15.692
    ,"SD1":17.802
    ,"SD2":20.227
    ,"SD3":23.021
    ,"SD4":25.815
  },
  1342 : {
     "Day":1342
    ,"SD4neg":9.449
    ,"SD3neg":10.852
    ,"SD2neg":12.254
    ,"SD1neg":13.859
    ,"SD0":15.698
    ,"SD1":17.809
    ,"SD2":20.235
    ,"SD3":23.031
    ,"SD4":25.826
  },
  1343 : {
     "Day":1343
    ,"SD4neg":9.452
    ,"SD3neg":10.855
    ,"SD2neg":12.258
    ,"SD1neg":13.864
    ,"SD0":15.703
    ,"SD1":17.815
    ,"SD2":20.243
    ,"SD3":23.040
    ,"SD4":25.838
  },
  1344 : {
     "Day":1344
    ,"SD4neg":9.454
    ,"SD3neg":10.858
    ,"SD2neg":12.262
    ,"SD1neg":13.868
    ,"SD0":15.709
    ,"SD1":17.822
    ,"SD2":20.251
    ,"SD3":23.050
    ,"SD4":25.849
  },
  1345 : {
     "Day":1345
    ,"SD4neg":9.457
    ,"SD3neg":10.861
    ,"SD2neg":12.266
    ,"SD1neg":13.873
    ,"SD0":15.714
    ,"SD1":17.828
    ,"SD2":20.259
    ,"SD3":23.060
    ,"SD4":25.860
  },
  1346 : {
     "Day":1346
    ,"SD4neg":9.460
    ,"SD3neg":10.865
    ,"SD2neg":12.270
    ,"SD1neg":13.878
    ,"SD0":15.720
    ,"SD1":17.835
    ,"SD2":20.267
    ,"SD3":23.069
    ,"SD4":25.871
  },
  1347 : {
     "Day":1347
    ,"SD4neg":9.463
    ,"SD3neg":10.868
    ,"SD2neg":12.274
    ,"SD1neg":13.882
    ,"SD0":15.725
    ,"SD1":17.841
    ,"SD2":20.275
    ,"SD3":23.078
    ,"SD4":25.882
  },
  1348 : {
     "Day":1348
    ,"SD4neg":9.465
    ,"SD3neg":10.871
    ,"SD2neg":12.278
    ,"SD1neg":13.887
    ,"SD0":15.731
    ,"SD1":17.848
    ,"SD2":20.283
    ,"SD3":23.088
    ,"SD4":25.894
  },
  1349 : {
     "Day":1349
    ,"SD4neg":9.468
    ,"SD3neg":10.875
    ,"SD2neg":12.282
    ,"SD1neg":13.891
    ,"SD0":15.736
    ,"SD1":17.855
    ,"SD2":20.291
    ,"SD3":23.098
    ,"SD4":25.905
  },
  1350 : {
     "Day":1350
    ,"SD4neg":9.471
    ,"SD3neg":10.878
    ,"SD2neg":12.285
    ,"SD1neg":13.896
    ,"SD0":15.742
    ,"SD1":17.861
    ,"SD2":20.299
    ,"SD3":23.108
    ,"SD4":25.916
  },
  1351 : {
     "Day":1351
    ,"SD4neg":9.474
    ,"SD3neg":10.882
    ,"SD2neg":12.290
    ,"SD1neg":13.901
    ,"SD0":15.747
    ,"SD1":17.868
    ,"SD2":20.306
    ,"SD3":23.117
    ,"SD4":25.927
  },
  1352 : {
     "Day":1352
    ,"SD4neg":9.476
    ,"SD3neg":10.885
    ,"SD2neg":12.293
    ,"SD1neg":13.905
    ,"SD0":15.753
    ,"SD1":17.874
    ,"SD2":20.314
    ,"SD3":23.126
    ,"SD4":25.938
  },
  1353 : {
     "Day":1353
    ,"SD4neg":9.479
    ,"SD3neg":10.888
    ,"SD2neg":12.297
    ,"SD1neg":13.910
    ,"SD0":15.758
    ,"SD1":17.881
    ,"SD2":20.322
    ,"SD3":23.136
    ,"SD4":25.950
  },
  1354 : {
     "Day":1354
    ,"SD4neg":9.481
    ,"SD3neg":10.891
    ,"SD2neg":12.301
    ,"SD1neg":13.914
    ,"SD0":15.764
    ,"SD1":17.887
    ,"SD2":20.330
    ,"SD3":23.146
    ,"SD4":25.961
  },
  1355 : {
     "Day":1355
    ,"SD4neg":9.484
    ,"SD3neg":10.895
    ,"SD2neg":12.305
    ,"SD1neg":13.919
    ,"SD0":15.769
    ,"SD1":17.894
    ,"SD2":20.338
    ,"SD3":23.155
    ,"SD4":25.972
  },
  1356 : {
     "Day":1356
    ,"SD4neg":9.487
    ,"SD3neg":10.898
    ,"SD2neg":12.309
    ,"SD1neg":13.924
    ,"SD0":15.775
    ,"SD1":17.900
    ,"SD2":20.346
    ,"SD3":23.164
    ,"SD4":25.983
  },
  1357 : {
     "Day":1357
    ,"SD4neg":9.490
    ,"SD3neg":10.901
    ,"SD2neg":12.313
    ,"SD1neg":13.928
    ,"SD0":15.780
    ,"SD1":17.907
    ,"SD2":20.354
    ,"SD3":23.174
    ,"SD4":25.994
  },
  1358 : {
     "Day":1358
    ,"SD4neg":9.492
    ,"SD3neg":10.905
    ,"SD2neg":12.317
    ,"SD1neg":13.933
    ,"SD0":15.786
    ,"SD1":17.914
    ,"SD2":20.362
    ,"SD3":23.184
    ,"SD4":26.006
  },
  1359 : {
     "Day":1359
    ,"SD4neg":9.495
    ,"SD3neg":10.908
    ,"SD2neg":12.320
    ,"SD1neg":13.937
    ,"SD0":15.791
    ,"SD1":17.920
    ,"SD2":20.370
    ,"SD3":23.193
    ,"SD4":26.017
  },
  1360 : {
     "Day":1360
    ,"SD4neg":9.498
    ,"SD3neg":10.911
    ,"SD2neg":12.324
    ,"SD1neg":13.942
    ,"SD0":15.797
    ,"SD1":17.927
    ,"SD2":20.378
    ,"SD3":23.203
    ,"SD4":26.028
  },
  1361 : {
     "Day":1361
    ,"SD4neg":9.501
    ,"SD3neg":10.915
    ,"SD2neg":12.328
    ,"SD1neg":13.947
    ,"SD0":15.802
    ,"SD1":17.933
    ,"SD2":20.385
    ,"SD3":23.212
    ,"SD4":26.039
  },
  1362 : {
     "Day":1362
    ,"SD4neg":9.503
    ,"SD3neg":10.918
    ,"SD2neg":12.332
    ,"SD1neg":13.951
    ,"SD0":15.808
    ,"SD1":17.940
    ,"SD2":20.393
    ,"SD3":23.222
    ,"SD4":26.050
  },
  1363 : {
     "Day":1363
    ,"SD4neg":9.506
    ,"SD3neg":10.921
    ,"SD2neg":12.336
    ,"SD1neg":13.956
    ,"SD0":15.813
    ,"SD1":17.946
    ,"SD2":20.401
    ,"SD3":23.231
    ,"SD4":26.061
  },
  1364 : {
     "Day":1364
    ,"SD4neg":9.509
    ,"SD3neg":10.924
    ,"SD2neg":12.340
    ,"SD1neg":13.960
    ,"SD0":15.818
    ,"SD1":17.953
    ,"SD2":20.409
    ,"SD3":23.241
    ,"SD4":26.073
  },
  1365 : {
     "Day":1365
    ,"SD4neg":9.511
    ,"SD3neg":10.928
    ,"SD2neg":12.344
    ,"SD1neg":13.965
    ,"SD0":15.824
    ,"SD1":17.960
    ,"SD2":20.417
    ,"SD3":23.251
    ,"SD4":26.085
  },
  1366 : {
     "Day":1366
    ,"SD4neg":9.514
    ,"SD3neg":10.931
    ,"SD2neg":12.348
    ,"SD1neg":13.970
    ,"SD0":15.830
    ,"SD1":17.966
    ,"SD2":20.425
    ,"SD3":23.261
    ,"SD4":26.096
  },
  1367 : {
     "Day":1367
    ,"SD4neg":9.517
    ,"SD3neg":10.934
    ,"SD2neg":12.352
    ,"SD1neg":13.974
    ,"SD0":15.835
    ,"SD1":17.973
    ,"SD2":20.433
    ,"SD3":23.270
    ,"SD4":26.106
  },
  1368 : {
     "Day":1368
    ,"SD4neg":9.520
    ,"SD3neg":10.938
    ,"SD2neg":12.355
    ,"SD1neg":13.979
    ,"SD0":15.840
    ,"SD1":17.979
    ,"SD2":20.441
    ,"SD3":23.279
    ,"SD4":26.118
  },
  1369 : {
     "Day":1369
    ,"SD4neg":9.522
    ,"SD3neg":10.941
    ,"SD2neg":12.359
    ,"SD1neg":13.983
    ,"SD0":15.846
    ,"SD1":17.986
    ,"SD2":20.449
    ,"SD3":23.289
    ,"SD4":26.129
  },
  1370 : {
     "Day":1370
    ,"SD4neg":9.525
    ,"SD3neg":10.944
    ,"SD2neg":12.363
    ,"SD1neg":13.988
    ,"SD0":15.851
    ,"SD1":17.992
    ,"SD2":20.457
    ,"SD3":23.299
    ,"SD4":26.140
  },
  1371 : {
     "Day":1371
    ,"SD4neg":9.528
    ,"SD3neg":10.947
    ,"SD2neg":12.367
    ,"SD1neg":13.993
    ,"SD0":15.857
    ,"SD1":17.999
    ,"SD2":20.465
    ,"SD3":23.308
    ,"SD4":26.152
  },
  1372 : {
     "Day":1372
    ,"SD4neg":9.530
    ,"SD3neg":10.950
    ,"SD2neg":12.371
    ,"SD1neg":13.997
    ,"SD0":15.862
    ,"SD1":18.006
    ,"SD2":20.473
    ,"SD3":23.318
    ,"SD4":26.163
  },
  1373 : {
     "Day":1373
    ,"SD4neg":9.533
    ,"SD3neg":10.954
    ,"SD2neg":12.375
    ,"SD1neg":14.002
    ,"SD0":15.868
    ,"SD1":18.012
    ,"SD2":20.480
    ,"SD3":23.327
    ,"SD4":26.174
  },
  1374 : {
     "Day":1374
    ,"SD4neg":9.536
    ,"SD3neg":10.957
    ,"SD2neg":12.379
    ,"SD1neg":14.006
    ,"SD0":15.873
    ,"SD1":18.019
    ,"SD2":20.488
    ,"SD3":23.337
    ,"SD4":26.185
  },
  1375 : {
     "Day":1375
    ,"SD4neg":9.538
    ,"SD3neg":10.961
    ,"SD2neg":12.383
    ,"SD1neg":14.011
    ,"SD0":15.879
    ,"SD1":18.025
    ,"SD2":20.496
    ,"SD3":23.346
    ,"SD4":26.197
  },
  1376 : {
     "Day":1376
    ,"SD4neg":9.541
    ,"SD3neg":10.964
    ,"SD2neg":12.386
    ,"SD1neg":14.015
    ,"SD0":15.884
    ,"SD1":18.032
    ,"SD2":20.504
    ,"SD3":23.356
    ,"SD4":26.208
  },
  1377 : {
     "Day":1377
    ,"SD4neg":9.544
    ,"SD3neg":10.967
    ,"SD2neg":12.390
    ,"SD1neg":14.020
    ,"SD0":15.890
    ,"SD1":18.038
    ,"SD2":20.512
    ,"SD3":23.366
    ,"SD4":26.220
  },
  1378 : {
     "Day":1378
    ,"SD4neg":9.546
    ,"SD3neg":10.970
    ,"SD2neg":12.394
    ,"SD1neg":14.025
    ,"SD0":15.895
    ,"SD1":18.045
    ,"SD2":20.520
    ,"SD3":23.376
    ,"SD4":26.231
  },
  1379 : {
     "Day":1379
    ,"SD4neg":9.549
    ,"SD3neg":10.974
    ,"SD2neg":12.398
    ,"SD1neg":14.029
    ,"SD0":15.901
    ,"SD1":18.051
    ,"SD2":20.528
    ,"SD3":23.385
    ,"SD4":26.241
  },
  1380 : {
     "Day":1380
    ,"SD4neg":9.552
    ,"SD3neg":10.977
    ,"SD2neg":12.402
    ,"SD1neg":14.034
    ,"SD0":15.906
    ,"SD1":18.058
    ,"SD2":20.536
    ,"SD3":23.394
    ,"SD4":26.253
  },
  1381 : {
     "Day":1381
    ,"SD4neg":9.555
    ,"SD3neg":10.980
    ,"SD2neg":12.406
    ,"SD1neg":14.038
    ,"SD0":15.912
    ,"SD1":18.065
    ,"SD2":20.544
    ,"SD3":23.404
    ,"SD4":26.264
  },
  1382 : {
     "Day":1382
    ,"SD4neg":9.557
    ,"SD3neg":10.983
    ,"SD2neg":12.410
    ,"SD1neg":14.043
    ,"SD0":15.917
    ,"SD1":18.071
    ,"SD2":20.552
    ,"SD3":23.414
    ,"SD4":26.276
  },
  1383 : {
     "Day":1383
    ,"SD4neg":9.560
    ,"SD3neg":10.987
    ,"SD2neg":12.413
    ,"SD1neg":14.048
    ,"SD0":15.923
    ,"SD1":18.078
    ,"SD2":20.560
    ,"SD3":23.423
    ,"SD4":26.287
  },
  1384 : {
     "Day":1384
    ,"SD4neg":9.563
    ,"SD3neg":10.990
    ,"SD2neg":12.417
    ,"SD1neg":14.052
    ,"SD0":15.928
    ,"SD1":18.084
    ,"SD2":20.568
    ,"SD3":23.433
    ,"SD4":26.299
  },
  1385 : {
     "Day":1385
    ,"SD4neg":9.565
    ,"SD3neg":10.993
    ,"SD2neg":12.421
    ,"SD1neg":14.057
    ,"SD0":15.934
    ,"SD1":18.091
    ,"SD2":20.576
    ,"SD3":23.443
    ,"SD4":26.310
  },
  1386 : {
     "Day":1386
    ,"SD4neg":9.568
    ,"SD3neg":10.997
    ,"SD2neg":12.425
    ,"SD1neg":14.061
    ,"SD0":15.939
    ,"SD1":18.097
    ,"SD2":20.583
    ,"SD3":23.452
    ,"SD4":26.320
  },
  1387 : {
     "Day":1387
    ,"SD4neg":9.571
    ,"SD3neg":11.000
    ,"SD2neg":12.429
    ,"SD1neg":14.066
    ,"SD0":15.944
    ,"SD1":18.104
    ,"SD2":20.591
    ,"SD3":23.462
    ,"SD4":26.332
  },
  1388 : {
     "Day":1388
    ,"SD4neg":9.573
    ,"SD3neg":11.003
    ,"SD2neg":12.433
    ,"SD1neg":14.071
    ,"SD0":15.950
    ,"SD1":18.111
    ,"SD2":20.599
    ,"SD3":23.471
    ,"SD4":26.343
  },
  1389 : {
     "Day":1389
    ,"SD4neg":9.576
    ,"SD3neg":11.006
    ,"SD2neg":12.437
    ,"SD1neg":14.075
    ,"SD0":15.955
    ,"SD1":18.117
    ,"SD2":20.607
    ,"SD3":23.481
    ,"SD4":26.355
  },
  1390 : {
     "Day":1390
    ,"SD4neg":9.579
    ,"SD3neg":11.010
    ,"SD2neg":12.440
    ,"SD1neg":14.080
    ,"SD0":15.961
    ,"SD1":18.124
    ,"SD2":20.615
    ,"SD3":23.491
    ,"SD4":26.366
  },
  1391 : {
     "Day":1391
    ,"SD4neg":9.581
    ,"SD3neg":11.013
    ,"SD2neg":12.444
    ,"SD1neg":14.084
    ,"SD0":15.966
    ,"SD1":18.130
    ,"SD2":20.623
    ,"SD3":23.501
    ,"SD4":26.378
  },
  1392 : {
     "Day":1392
    ,"SD4neg":9.584
    ,"SD3neg":11.016
    ,"SD2neg":12.448
    ,"SD1neg":14.089
    ,"SD0":15.972
    ,"SD1":18.137
    ,"SD2":20.631
    ,"SD3":23.509
    ,"SD4":26.388
  },
  1393 : {
     "Day":1393
    ,"SD4neg":9.587
    ,"SD3neg":11.020
    ,"SD2neg":12.452
    ,"SD1neg":14.093
    ,"SD0":15.977
    ,"SD1":18.143
    ,"SD2":20.639
    ,"SD3":23.519
    ,"SD4":26.400
  },
  1394 : {
     "Day":1394
    ,"SD4neg":9.590
    ,"SD3neg":11.023
    ,"SD2neg":12.456
    ,"SD1neg":14.098
    ,"SD0":15.983
    ,"SD1":18.150
    ,"SD2":20.647
    ,"SD3":23.529
    ,"SD4":26.411
  },
  1395 : {
     "Day":1395
    ,"SD4neg":9.592
    ,"SD3neg":11.026
    ,"SD2neg":12.460
    ,"SD1neg":14.103
    ,"SD0":15.988
    ,"SD1":18.157
    ,"SD2":20.655
    ,"SD3":23.539
    ,"SD4":26.422
  },
  1396 : {
     "Day":1396
    ,"SD4neg":9.595
    ,"SD3neg":11.029
    ,"SD2neg":12.464
    ,"SD1neg":14.107
    ,"SD0":15.994
    ,"SD1":18.163
    ,"SD2":20.663
    ,"SD3":23.548
    ,"SD4":26.434
  },
  1397 : {
     "Day":1397
    ,"SD4neg":9.597
    ,"SD3neg":11.032
    ,"SD2neg":12.467
    ,"SD1neg":14.112
    ,"SD0":15.999
    ,"SD1":18.170
    ,"SD2":20.671
    ,"SD3":23.558
    ,"SD4":26.445
  },
  1398 : {
     "Day":1398
    ,"SD4neg":9.600
    ,"SD3neg":11.036
    ,"SD2neg":12.471
    ,"SD1neg":14.116
    ,"SD0":16.005
    ,"SD1":18.176
    ,"SD2":20.679
    ,"SD3":23.568
    ,"SD4":26.457
  },
  1399 : {
     "Day":1399
    ,"SD4neg":9.603
    ,"SD3neg":11.039
    ,"SD2neg":12.475
    ,"SD1neg":14.121
    ,"SD0":16.010
    ,"SD1":18.183
    ,"SD2":20.687
    ,"SD3":23.578
    ,"SD4":26.468
  },
  1400 : {
     "Day":1400
    ,"SD4neg":9.606
    ,"SD3neg":11.042
    ,"SD2neg":12.479
    ,"SD1neg":14.126
    ,"SD0":16.016
    ,"SD1":18.189
    ,"SD2":20.694
    ,"SD3":23.587
    ,"SD4":26.479
  },
  1401 : {
     "Day":1401
    ,"SD4neg":9.608
    ,"SD3neg":11.046
    ,"SD2neg":12.483
    ,"SD1neg":14.130
    ,"SD0":16.021
    ,"SD1":18.196
    ,"SD2":20.702
    ,"SD3":23.596
    ,"SD4":26.490
  },
  1402 : {
     "Day":1402
    ,"SD4neg":9.611
    ,"SD3neg":11.049
    ,"SD2neg":12.487
    ,"SD1neg":14.135
    ,"SD0":16.026
    ,"SD1":18.203
    ,"SD2":20.710
    ,"SD3":23.606
    ,"SD4":26.502
  },
  1403 : {
     "Day":1403
    ,"SD4neg":9.614
    ,"SD3neg":11.052
    ,"SD2neg":12.491
    ,"SD1neg":14.139
    ,"SD0":16.032
    ,"SD1":18.209
    ,"SD2":20.718
    ,"SD3":23.616
    ,"SD4":26.513
  },
  1404 : {
     "Day":1404
    ,"SD4neg":9.616
    ,"SD3neg":11.055
    ,"SD2neg":12.494
    ,"SD1neg":14.144
    ,"SD0":16.038
    ,"SD1":18.216
    ,"SD2":20.726
    ,"SD3":23.626
    ,"SD4":26.525
  },
  1405 : {
     "Day":1405
    ,"SD4neg":9.619
    ,"SD3neg":11.059
    ,"SD2neg":12.498
    ,"SD1neg":14.148
    ,"SD0":16.043
    ,"SD1":18.222
    ,"SD2":20.734
    ,"SD3":23.635
    ,"SD4":26.536
  },
  1406 : {
     "Day":1406
    ,"SD4neg":9.621
    ,"SD3neg":11.062
    ,"SD2neg":12.502
    ,"SD1neg":14.153
    ,"SD0":16.048
    ,"SD1":18.229
    ,"SD2":20.742
    ,"SD3":23.645
    ,"SD4":26.548
  },
  1407 : {
     "Day":1407
    ,"SD4neg":9.624
    ,"SD3neg":11.065
    ,"SD2neg":12.506
    ,"SD1neg":14.157
    ,"SD0":16.054
    ,"SD1":18.236
    ,"SD2":20.750
    ,"SD3":23.655
    ,"SD4":26.559
  },
  1408 : {
     "Day":1408
    ,"SD4neg":9.627
    ,"SD3neg":11.069
    ,"SD2neg":12.510
    ,"SD1neg":14.162
    ,"SD0":16.059
    ,"SD1":18.242
    ,"SD2":20.758
    ,"SD3":23.664
    ,"SD4":26.570
  },
  1409 : {
     "Day":1409
    ,"SD4neg":9.630
    ,"SD3neg":11.072
    ,"SD2neg":12.514
    ,"SD1neg":14.167
    ,"SD0":16.065
    ,"SD1":18.249
    ,"SD2":20.766
    ,"SD3":23.673
    ,"SD4":26.581
  },
  1410 : {
     "Day":1410
    ,"SD4neg":9.632
    ,"SD3neg":11.075
    ,"SD2neg":12.518
    ,"SD1neg":14.171
    ,"SD0":16.070
    ,"SD1":18.255
    ,"SD2":20.774
    ,"SD3":23.683
    ,"SD4":26.593
  },
  1411 : {
     "Day":1411
    ,"SD4neg":9.635
    ,"SD3neg":11.078
    ,"SD2neg":12.521
    ,"SD1neg":14.176
    ,"SD0":16.076
    ,"SD1":18.262
    ,"SD2":20.782
    ,"SD3":23.693
    ,"SD4":26.604
  },
  1412 : {
     "Day":1412
    ,"SD4neg":9.637
    ,"SD3neg":11.081
    ,"SD2neg":12.525
    ,"SD1neg":14.180
    ,"SD0":16.081
    ,"SD1":18.268
    ,"SD2":20.790
    ,"SD3":23.703
    ,"SD4":26.615
  },
  1413 : {
     "Day":1413
    ,"SD4neg":9.640
    ,"SD3neg":11.085
    ,"SD2neg":12.529
    ,"SD1neg":14.185
    ,"SD0":16.087
    ,"SD1":18.275
    ,"SD2":20.798
    ,"SD3":23.713
    ,"SD4":26.627
  },
  1414 : {
     "Day":1414
    ,"SD4neg":9.643
    ,"SD3neg":11.088
    ,"SD2neg":12.533
    ,"SD1neg":14.190
    ,"SD0":16.092
    ,"SD1":18.282
    ,"SD2":20.806
    ,"SD3":23.722
    ,"SD4":26.639
  },
  1415 : {
     "Day":1415
    ,"SD4neg":9.645
    ,"SD3neg":11.091
    ,"SD2neg":12.537
    ,"SD1neg":14.194
    ,"SD0":16.098
    ,"SD1":18.288
    ,"SD2":20.814
    ,"SD3":23.732
    ,"SD4":26.650
  },
  1416 : {
     "Day":1416
    ,"SD4neg":9.648
    ,"SD3neg":11.094
    ,"SD2neg":12.540
    ,"SD1neg":14.199
    ,"SD0":16.103
    ,"SD1":18.295
    ,"SD2":20.822
    ,"SD3":23.742
    ,"SD4":26.662
  },
  1417 : {
     "Day":1417
    ,"SD4neg":9.651
    ,"SD3neg":11.098
    ,"SD2neg":12.545
    ,"SD1neg":14.203
    ,"SD0":16.109
    ,"SD1":18.301
    ,"SD2":20.830
    ,"SD3":23.751
    ,"SD4":26.672
  },
  1418 : {
     "Day":1418
    ,"SD4neg":9.654
    ,"SD3neg":11.101
    ,"SD2neg":12.548
    ,"SD1neg":14.208
    ,"SD0":16.114
    ,"SD1":18.308
    ,"SD2":20.837
    ,"SD3":23.760
    ,"SD4":26.683
  },
  1419 : {
     "Day":1419
    ,"SD4neg":9.656
    ,"SD3neg":11.104
    ,"SD2neg":12.552
    ,"SD1neg":14.212
    ,"SD0":16.119
    ,"SD1":18.314
    ,"SD2":20.846
    ,"SD3":23.770
    ,"SD4":26.695
  },
  1420 : {
     "Day":1420
    ,"SD4neg":9.659
    ,"SD3neg":11.107
    ,"SD2neg":12.556
    ,"SD1neg":14.217
    ,"SD0":16.125
    ,"SD1":18.321
    ,"SD2":20.854
    ,"SD3":23.780
    ,"SD4":26.706
  },
  1421 : {
     "Day":1421
    ,"SD4neg":9.661
    ,"SD3neg":11.111
    ,"SD2neg":12.560
    ,"SD1neg":14.221
    ,"SD0":16.130
    ,"SD1":18.328
    ,"SD2":20.862
    ,"SD3":23.790
    ,"SD4":26.718
  },
  1422 : {
     "Day":1422
    ,"SD4neg":9.664
    ,"SD3neg":11.114
    ,"SD2neg":12.564
    ,"SD1neg":14.226
    ,"SD0":16.136
    ,"SD1":18.334
    ,"SD2":20.870
    ,"SD3":23.800
    ,"SD4":26.730
  },
  1423 : {
     "Day":1423
    ,"SD4neg":9.667
    ,"SD3neg":11.117
    ,"SD2neg":12.567
    ,"SD1neg":14.231
    ,"SD0":16.141
    ,"SD1":18.341
    ,"SD2":20.878
    ,"SD3":23.809
    ,"SD4":26.741
  },
  1424 : {
     "Day":1424
    ,"SD4neg":9.669
    ,"SD3neg":11.120
    ,"SD2neg":12.571
    ,"SD1neg":14.235
    ,"SD0":16.147
    ,"SD1":18.347
    ,"SD2":20.886
    ,"SD3":23.819
    ,"SD4":26.752
  },
  1425 : {
     "Day":1425
    ,"SD4neg":9.672
    ,"SD3neg":11.123
    ,"SD2neg":12.575
    ,"SD1neg":14.240
    ,"SD0":16.152
    ,"SD1":18.354
    ,"SD2":20.894
    ,"SD3":23.829
    ,"SD4":26.764
  },
  1426 : {
     "Day":1426
    ,"SD4neg":9.675
    ,"SD3neg":11.127
    ,"SD2neg":12.579
    ,"SD1neg":14.244
    ,"SD0":16.158
    ,"SD1":18.361
    ,"SD2":20.902
    ,"SD3":23.839
    ,"SD4":26.776
  },
  1427 : {
     "Day":1427
    ,"SD4neg":9.677
    ,"SD3neg":11.130
    ,"SD2neg":12.583
    ,"SD1neg":14.249
    ,"SD0":16.163
    ,"SD1":18.367
    ,"SD2":20.909
    ,"SD3":23.847
    ,"SD4":26.786
  },
  1428 : {
     "Day":1428
    ,"SD4neg":9.680
    ,"SD3neg":11.133
    ,"SD2neg":12.587
    ,"SD1neg":14.253
    ,"SD0":16.169
    ,"SD1":18.374
    ,"SD2":20.917
    ,"SD3":23.857
    ,"SD4":26.797
  },
  1429 : {
     "Day":1429
    ,"SD4neg":9.683
    ,"SD3neg":11.137
    ,"SD2neg":12.591
    ,"SD1neg":14.258
    ,"SD0":16.174
    ,"SD1":18.380
    ,"SD2":20.925
    ,"SD3":23.867
    ,"SD4":26.809
  },
  1430 : {
     "Day":1430
    ,"SD4neg":9.685
    ,"SD3neg":11.140
    ,"SD2neg":12.594
    ,"SD1neg":14.263
    ,"SD0":16.180
    ,"SD1":18.387
    ,"SD2":20.933
    ,"SD3":23.877
    ,"SD4":26.821
  },
  1431 : {
     "Day":1431
    ,"SD4neg":9.688
    ,"SD3neg":11.143
    ,"SD2neg":12.598
    ,"SD1neg":14.267
    ,"SD0":16.185
    ,"SD1":18.393
    ,"SD2":20.941
    ,"SD3":23.887
    ,"SD4":26.832
  },
  1432 : {
     "Day":1432
    ,"SD4neg":9.691
    ,"SD3neg":11.146
    ,"SD2neg":12.602
    ,"SD1neg":14.272
    ,"SD0":16.191
    ,"SD1":18.400
    ,"SD2":20.949
    ,"SD3":23.896
    ,"SD4":26.844
  },
  1433 : {
     "Day":1433
    ,"SD4neg":9.693
    ,"SD3neg":11.149
    ,"SD2neg":12.606
    ,"SD1neg":14.276
    ,"SD0":16.196
    ,"SD1":18.407
    ,"SD2":20.957
    ,"SD3":23.906
    ,"SD4":26.855
  },
  1434 : {
     "Day":1434
    ,"SD4neg":9.696
    ,"SD3neg":11.153
    ,"SD2neg":12.610
    ,"SD1neg":14.281
    ,"SD0":16.202
    ,"SD1":18.413
    ,"SD2":20.965
    ,"SD3":23.916
    ,"SD4":26.867
  },
  1435 : {
     "Day":1435
    ,"SD4neg":9.698
    ,"SD3neg":11.156
    ,"SD2neg":12.613
    ,"SD1neg":14.285
    ,"SD0":16.207
    ,"SD1":18.420
    ,"SD2":20.973
    ,"SD3":23.926
    ,"SD4":26.878
  },
  1436 : {
     "Day":1436
    ,"SD4neg":9.701
    ,"SD3neg":11.159
    ,"SD2neg":12.617
    ,"SD1neg":14.290
    ,"SD0":16.212
    ,"SD1":18.426
    ,"SD2":20.981
    ,"SD3":23.935
    ,"SD4":26.890
  },
  1437 : {
     "Day":1437
    ,"SD4neg":9.704
    ,"SD3neg":11.162
    ,"SD2neg":12.621
    ,"SD1neg":14.294
    ,"SD0":16.218
    ,"SD1":18.433
    ,"SD2":20.989
    ,"SD3":23.945
    ,"SD4":26.901
  },
  1438 : {
     "Day":1438
    ,"SD4neg":9.706
    ,"SD3neg":11.165
    ,"SD2neg":12.625
    ,"SD1neg":14.299
    ,"SD0":16.223
    ,"SD1":18.440
    ,"SD2":20.997
    ,"SD3":23.955
    ,"SD4":26.913
  },
  1439 : {
     "Day":1439
    ,"SD4neg":9.709
    ,"SD3neg":11.169
    ,"SD2neg":12.629
    ,"SD1neg":14.303
    ,"SD0":16.229
    ,"SD1":18.446
    ,"SD2":21.005
    ,"SD3":23.965
    ,"SD4":26.924
  },
  1440 : {
     "Day":1440
    ,"SD4neg":9.712
    ,"SD3neg":11.172
    ,"SD2neg":12.633
    ,"SD1neg":14.308
    ,"SD0":16.234
    ,"SD1":18.453
    ,"SD2":21.013
    ,"SD3":23.974
    ,"SD4":26.935
  },
  1441 : {
     "Day":1441
    ,"SD4neg":9.714
    ,"SD3neg":11.175
    ,"SD2neg":12.636
    ,"SD1neg":14.313
    ,"SD0":16.240
    ,"SD1":18.459
    ,"SD2":21.021
    ,"SD3":23.984
    ,"SD4":26.946
  },
  1442 : {
     "Day":1442
    ,"SD4neg":9.717
    ,"SD3neg":11.179
    ,"SD2neg":12.640
    ,"SD1neg":14.317
    ,"SD0":16.245
    ,"SD1":18.466
    ,"SD2":21.029
    ,"SD3":23.993
    ,"SD4":26.958
  },
  1443 : {
     "Day":1443
    ,"SD4neg":9.720
    ,"SD3neg":11.182
    ,"SD2neg":12.644
    ,"SD1neg":14.322
    ,"SD0":16.251
    ,"SD1":18.472
    ,"SD2":21.037
    ,"SD3":24.003
    ,"SD4":26.969
  },
  1444 : {
     "Day":1444
    ,"SD4neg":9.722
    ,"SD3neg":11.185
    ,"SD2neg":12.648
    ,"SD1neg":14.326
    ,"SD0":16.256
    ,"SD1":18.479
    ,"SD2":21.045
    ,"SD3":24.013
    ,"SD4":26.981
  },
  1445 : {
     "Day":1445
    ,"SD4neg":9.725
    ,"SD3neg":11.188
    ,"SD2neg":12.652
    ,"SD1neg":14.331
    ,"SD0":16.262
    ,"SD1":18.486
    ,"SD2":21.053
    ,"SD3":24.023
    ,"SD4":26.992
  },
  1446 : {
     "Day":1446
    ,"SD4neg":9.727
    ,"SD3neg":11.191
    ,"SD2neg":12.655
    ,"SD1neg":14.335
    ,"SD0":16.267
    ,"SD1":18.492
    ,"SD2":21.061
    ,"SD3":24.033
    ,"SD4":27.004
  },
  1447 : {
     "Day":1447
    ,"SD4neg":9.730
    ,"SD3neg":11.195
    ,"SD2neg":12.659
    ,"SD1neg":14.340
    ,"SD0":16.272
    ,"SD1":18.499
    ,"SD2":21.069
    ,"SD3":24.042
    ,"SD4":27.016
  },
  1448 : {
     "Day":1448
    ,"SD4neg":9.733
    ,"SD3neg":11.198
    ,"SD2neg":12.663
    ,"SD1neg":14.344
    ,"SD0":16.278
    ,"SD1":18.505
    ,"SD2":21.077
    ,"SD3":24.052
    ,"SD4":27.027
  },
  1449 : {
     "Day":1449
    ,"SD4neg":9.735
    ,"SD3neg":11.201
    ,"SD2neg":12.667
    ,"SD1neg":14.349
    ,"SD0":16.283
    ,"SD1":18.512
    ,"SD2":21.085
    ,"SD3":24.062
    ,"SD4":27.039
  },
  1450 : {
     "Day":1450
    ,"SD4neg":9.738
    ,"SD3neg":11.204
    ,"SD2neg":12.671
    ,"SD1neg":14.354
    ,"SD0":16.289
    ,"SD1":18.519
    ,"SD2":21.093
    ,"SD3":24.072
    ,"SD4":27.050
  },
  1451 : {
     "Day":1451
    ,"SD4neg":9.740
    ,"SD3neg":11.207
    ,"SD2neg":12.674
    ,"SD1neg":14.358
    ,"SD0":16.294
    ,"SD1":18.525
    ,"SD2":21.101
    ,"SD3":24.081
    ,"SD4":27.062
  },
  1452 : {
     "Day":1452
    ,"SD4neg":9.743
    ,"SD3neg":11.211
    ,"SD2neg":12.678
    ,"SD1neg":14.363
    ,"SD0":16.300
    ,"SD1":18.532
    ,"SD2":21.109
    ,"SD3":24.091
    ,"SD4":27.073
  },
  1453 : {
     "Day":1453
    ,"SD4neg":9.746
    ,"SD3neg":11.214
    ,"SD2neg":12.682
    ,"SD1neg":14.367
    ,"SD0":16.305
    ,"SD1":18.539
    ,"SD2":21.117
    ,"SD3":24.101
    ,"SD4":27.085
  },
  1454 : {
     "Day":1454
    ,"SD4neg":9.748
    ,"SD3neg":11.217
    ,"SD2neg":12.686
    ,"SD1neg":14.372
    ,"SD0":16.311
    ,"SD1":18.545
    ,"SD2":21.125
    ,"SD3":24.111
    ,"SD4":27.096
  },
  1455 : {
     "Day":1455
    ,"SD4neg":9.751
    ,"SD3neg":11.221
    ,"SD2neg":12.690
    ,"SD1neg":14.376
    ,"SD0":16.316
    ,"SD1":18.552
    ,"SD2":21.133
    ,"SD3":24.120
    ,"SD4":27.107
  },
  1456 : {
     "Day":1456
    ,"SD4neg":9.754
    ,"SD3neg":11.224
    ,"SD2neg":12.694
    ,"SD1neg":14.381
    ,"SD0":16.322
    ,"SD1":18.558
    ,"SD2":21.141
    ,"SD3":24.130
    ,"SD4":27.118
  },
  1457 : {
     "Day":1457
    ,"SD4neg":9.756
    ,"SD3neg":11.227
    ,"SD2neg":12.697
    ,"SD1neg":14.386
    ,"SD0":16.327
    ,"SD1":18.565
    ,"SD2":21.149
    ,"SD3":24.139
    ,"SD4":27.130
  },
  1458 : {
     "Day":1458
    ,"SD4neg":9.759
    ,"SD3neg":11.230
    ,"SD2neg":12.701
    ,"SD1neg":14.390
    ,"SD0":16.332
    ,"SD1":18.571
    ,"SD2":21.157
    ,"SD3":24.149
    ,"SD4":27.142
  },
  1459 : {
     "Day":1459
    ,"SD4neg":9.761
    ,"SD3neg":11.233
    ,"SD2neg":12.705
    ,"SD1neg":14.395
    ,"SD0":16.338
    ,"SD1":18.578
    ,"SD2":21.165
    ,"SD3":24.159
    ,"SD4":27.153
  },
  1460 : {
     "Day":1460
    ,"SD4neg":9.764
    ,"SD3neg":11.236
    ,"SD2neg":12.709
    ,"SD1neg":14.399
    ,"SD0":16.343
    ,"SD1":18.585
    ,"SD2":21.173
    ,"SD3":24.169
    ,"SD4":27.165
  },
  1461 : {
     "Day":1461
    ,"SD4neg":9.767
    ,"SD3neg":11.240
    ,"SD2neg":12.713
    ,"SD1neg":14.404
    ,"SD0":16.349
    ,"SD1":18.591
    ,"SD2":21.181
    ,"SD3":24.178
    ,"SD4":27.176
  },
  1462 : {
     "Day":1462
    ,"SD4neg":9.769
    ,"SD3neg":11.243
    ,"SD2neg":12.716
    ,"SD1neg":14.408
    ,"SD0":16.354
    ,"SD1":18.598
    ,"SD2":21.189
    ,"SD3":24.188
    ,"SD4":27.188
  },
  1463 : {
     "Day":1463
    ,"SD4neg":9.772
    ,"SD3neg":11.246
    ,"SD2neg":12.720
    ,"SD1neg":14.413
    ,"SD0":16.360
    ,"SD1":18.604
    ,"SD2":21.197
    ,"SD3":24.198
    ,"SD4":27.199
  },
  1464 : {
     "Day":1464
    ,"SD4neg":9.774
    ,"SD3neg":11.249
    ,"SD2neg":12.724
    ,"SD1neg":14.417
    ,"SD0":16.365
    ,"SD1":18.611
    ,"SD2":21.205
    ,"SD3":24.208
    ,"SD4":27.211
  },
  1465 : {
     "Day":1465
    ,"SD4neg":9.777
    ,"SD3neg":11.252
    ,"SD2neg":12.728
    ,"SD1neg":14.422
    ,"SD0":16.371
    ,"SD1":18.618
    ,"SD2":21.213
    ,"SD3":24.218
    ,"SD4":27.223
  },
  1466 : {
     "Day":1466
    ,"SD4neg":9.780
    ,"SD3neg":11.256
    ,"SD2neg":12.732
    ,"SD1neg":14.426
    ,"SD0":16.376
    ,"SD1":18.624
    ,"SD2":21.221
    ,"SD3":24.228
    ,"SD4":27.234
  },
  1467 : {
     "Day":1467
    ,"SD4neg":9.782
    ,"SD3neg":11.259
    ,"SD2neg":12.735
    ,"SD1neg":14.431
    ,"SD0":16.382
    ,"SD1":18.631
    ,"SD2":21.229
    ,"SD3":24.237
    ,"SD4":27.246
  },
  1468 : {
     "Day":1468
    ,"SD4neg":9.785
    ,"SD3neg":11.262
    ,"SD2neg":12.739
    ,"SD1neg":14.435
    ,"SD0":16.387
    ,"SD1":18.637
    ,"SD2":21.237
    ,"SD3":24.247
    ,"SD4":27.257
  },
  1469 : {
     "Day":1469
    ,"SD4neg":9.787
    ,"SD3neg":11.265
    ,"SD2neg":12.743
    ,"SD1neg":14.440
    ,"SD0":16.393
    ,"SD1":18.644
    ,"SD2":21.245
    ,"SD3":24.257
    ,"SD4":27.269
  },
  1470 : {
     "Day":1470
    ,"SD4neg":9.790
    ,"SD3neg":11.268
    ,"SD2neg":12.747
    ,"SD1neg":14.445
    ,"SD0":16.398
    ,"SD1":18.651
    ,"SD2":21.253
    ,"SD3":24.267
    ,"SD4":27.281
  },
  1471 : {
     "Day":1471
    ,"SD4neg":9.793
    ,"SD3neg":11.272
    ,"SD2neg":12.751
    ,"SD1neg":14.449
    ,"SD0":16.404
    ,"SD1":18.657
    ,"SD2":21.261
    ,"SD3":24.277
    ,"SD4":27.292
  },
  1472 : {
     "Day":1472
    ,"SD4neg":9.795
    ,"SD3neg":11.275
    ,"SD2neg":12.754
    ,"SD1neg":14.454
    ,"SD0":16.409
    ,"SD1":18.664
    ,"SD2":21.269
    ,"SD3":24.286
    ,"SD4":27.304
  },
  1473 : {
     "Day":1473
    ,"SD4neg":9.798
    ,"SD3neg":11.278
    ,"SD2neg":12.758
    ,"SD1neg":14.458
    ,"SD0":16.414
    ,"SD1":18.670
    ,"SD2":21.277
    ,"SD3":24.296
    ,"SD4":27.315
  },
  1474 : {
     "Day":1474
    ,"SD4neg":9.800
    ,"SD3neg":11.281
    ,"SD2neg":12.762
    ,"SD1neg":14.463
    ,"SD0":16.420
    ,"SD1":18.677
    ,"SD2":21.285
    ,"SD3":24.306
    ,"SD4":27.327
  },
  1475 : {
     "Day":1475
    ,"SD4neg":9.803
    ,"SD3neg":11.284
    ,"SD2neg":12.766
    ,"SD1neg":14.467
    ,"SD0":16.425
    ,"SD1":18.683
    ,"SD2":21.293
    ,"SD3":24.316
    ,"SD4":27.338
  },
  1476 : {
     "Day":1476
    ,"SD4neg":9.806
    ,"SD3neg":11.288
    ,"SD2neg":12.770
    ,"SD1neg":14.472
    ,"SD0":16.431
    ,"SD1":18.690
    ,"SD2":21.301
    ,"SD3":24.326
    ,"SD4":27.350
  },
  1477 : {
     "Day":1477
    ,"SD4neg":9.808
    ,"SD3neg":11.291
    ,"SD2neg":12.773
    ,"SD1neg":14.476
    ,"SD0":16.436
    ,"SD1":18.697
    ,"SD2":21.309
    ,"SD3":24.336
    ,"SD4":27.362
  },
  1478 : {
     "Day":1478
    ,"SD4neg":9.811
    ,"SD3neg":11.294
    ,"SD2neg":12.777
    ,"SD1neg":14.481
    ,"SD0":16.442
    ,"SD1":18.703
    ,"SD2":21.317
    ,"SD3":24.345
    ,"SD4":27.373
  },
  1479 : {
     "Day":1479
    ,"SD4neg":9.813
    ,"SD3neg":11.297
    ,"SD2neg":12.781
    ,"SD1neg":14.485
    ,"SD0":16.447
    ,"SD1":18.710
    ,"SD2":21.325
    ,"SD3":24.355
    ,"SD4":27.385
  },
  1480 : {
     "Day":1480
    ,"SD4neg":9.816
    ,"SD3neg":11.300
    ,"SD2neg":12.785
    ,"SD1neg":14.490
    ,"SD0":16.453
    ,"SD1":18.717
    ,"SD2":21.333
    ,"SD3":24.365
    ,"SD4":27.396
  },
  1481 : {
     "Day":1481
    ,"SD4neg":9.818
    ,"SD3neg":11.303
    ,"SD2neg":12.788
    ,"SD1neg":14.494
    ,"SD0":16.458
    ,"SD1":18.723
    ,"SD2":21.341
    ,"SD3":24.375
    ,"SD4":27.408
  },
  1482 : {
     "Day":1482
    ,"SD4neg":9.821
    ,"SD3neg":11.307
    ,"SD2neg":12.792
    ,"SD1neg":14.499
    ,"SD0":16.464
    ,"SD1":18.730
    ,"SD2":21.349
    ,"SD3":24.384
    ,"SD4":27.419
  },
  1483 : {
     "Day":1483
    ,"SD4neg":9.823
    ,"SD3neg":11.310
    ,"SD2neg":12.796
    ,"SD1neg":14.503
    ,"SD0":16.469
    ,"SD1":18.736
    ,"SD2":21.357
    ,"SD3":24.394
    ,"SD4":27.431
  },
  1484 : {
     "Day":1484
    ,"SD4neg":9.826
    ,"SD3neg":11.313
    ,"SD2neg":12.800
    ,"SD1neg":14.508
    ,"SD0":16.474
    ,"SD1":18.743
    ,"SD2":21.365
    ,"SD3":24.403
    ,"SD4":27.442
  },
  1485 : {
     "Day":1485
    ,"SD4neg":9.829
    ,"SD3neg":11.317
    ,"SD2neg":12.804
    ,"SD1neg":14.513
    ,"SD0":16.480
    ,"SD1":18.749
    ,"SD2":21.373
    ,"SD3":24.413
    ,"SD4":27.453
  },
  1486 : {
     "Day":1486
    ,"SD4neg":9.832
    ,"SD3neg":11.320
    ,"SD2neg":12.808
    ,"SD1neg":14.517
    ,"SD0":16.485
    ,"SD1":18.756
    ,"SD2":21.381
    ,"SD3":24.423
    ,"SD4":27.465
  },
  1487 : {
     "Day":1487
    ,"SD4neg":9.834
    ,"SD3neg":11.323
    ,"SD2neg":12.811
    ,"SD1neg":14.522
    ,"SD0":16.491
    ,"SD1":18.763
    ,"SD2":21.389
    ,"SD3":24.433
    ,"SD4":27.477
  },
  1488 : {
     "Day":1488
    ,"SD4neg":9.837
    ,"SD3neg":11.326
    ,"SD2neg":12.815
    ,"SD1neg":14.526
    ,"SD0":16.496
    ,"SD1":18.769
    ,"SD2":21.397
    ,"SD3":24.443
    ,"SD4":27.488
  },
  1489 : {
     "Day":1489
    ,"SD4neg":9.839
    ,"SD3neg":11.329
    ,"SD2neg":12.819
    ,"SD1neg":14.531
    ,"SD0":16.502
    ,"SD1":18.776
    ,"SD2":21.405
    ,"SD3":24.453
    ,"SD4":27.500
  },
  1490 : {
     "Day":1490
    ,"SD4neg":9.842
    ,"SD3neg":11.332
    ,"SD2neg":12.823
    ,"SD1neg":14.535
    ,"SD0":16.507
    ,"SD1":18.782
    ,"SD2":21.413
    ,"SD3":24.462
    ,"SD4":27.511
  },
  1491 : {
     "Day":1491
    ,"SD4neg":9.845
    ,"SD3neg":11.336
    ,"SD2neg":12.827
    ,"SD1neg":14.540
    ,"SD0":16.513
    ,"SD1":18.789
    ,"SD2":21.421
    ,"SD3":24.472
    ,"SD4":27.523
  },
  1492 : {
     "Day":1492
    ,"SD4neg":9.847
    ,"SD3neg":11.339
    ,"SD2neg":12.830
    ,"SD1neg":14.544
    ,"SD0":16.518
    ,"SD1":18.796
    ,"SD2":21.429
    ,"SD3":24.482
    ,"SD4":27.535
  },
  1493 : {
     "Day":1493
    ,"SD4neg":9.850
    ,"SD3neg":11.342
    ,"SD2neg":12.834
    ,"SD1neg":14.549
    ,"SD0":16.524
    ,"SD1":18.802
    ,"SD2":21.438
    ,"SD3":24.492
    ,"SD4":27.546
  },
  1494 : {
     "Day":1494
    ,"SD4neg":9.852
    ,"SD3neg":11.345
    ,"SD2neg":12.838
    ,"SD1neg":14.553
    ,"SD0":16.529
    ,"SD1":18.809
    ,"SD2":21.445
    ,"SD3":24.502
    ,"SD4":27.558
  },
  1495 : {
     "Day":1495
    ,"SD4neg":9.855
    ,"SD3neg":11.348
    ,"SD2neg":12.842
    ,"SD1neg":14.558
    ,"SD0":16.534
    ,"SD1":18.815
    ,"SD2":21.454
    ,"SD3":24.512
    ,"SD4":27.570
  },
  1496 : {
     "Day":1496
    ,"SD4neg":9.857
    ,"SD3neg":11.351
    ,"SD2neg":12.845
    ,"SD1neg":14.562
    ,"SD0":16.540
    ,"SD1":18.822
    ,"SD2":21.462
    ,"SD3":24.521
    ,"SD4":27.581
  },
  1497 : {
     "Day":1497
    ,"SD4neg":9.860
    ,"SD3neg":11.355
    ,"SD2neg":12.849
    ,"SD1neg":14.567
    ,"SD0":16.545
    ,"SD1":18.829
    ,"SD2":21.470
    ,"SD3":24.531
    ,"SD4":27.593
  },
  1498 : {
     "Day":1498
    ,"SD4neg":9.863
    ,"SD3neg":11.358
    ,"SD2neg":12.853
    ,"SD1neg":14.572
    ,"SD0":16.551
    ,"SD1":18.835
    ,"SD2":21.478
    ,"SD3":24.541
    ,"SD4":27.605
  },
  1499 : {
     "Day":1499
    ,"SD4neg":9.865
    ,"SD3neg":11.361
    ,"SD2neg":12.857
    ,"SD1neg":14.576
    ,"SD0":16.556
    ,"SD1":18.842
    ,"SD2":21.486
    ,"SD3":24.551
    ,"SD4":27.616
  },
  1500 : {
     "Day":1500
    ,"SD4neg":9.868
    ,"SD3neg":11.364
    ,"SD2neg":12.861
    ,"SD1neg":14.581
    ,"SD0":16.562
    ,"SD1":18.849
    ,"SD2":21.494
    ,"SD3":24.561
    ,"SD4":27.628
  },
  1501 : {
     "Day":1501
    ,"SD4neg":9.870
    ,"SD3neg":11.367
    ,"SD2neg":12.864
    ,"SD1neg":14.585
    ,"SD0":16.567
    ,"SD1":18.855
    ,"SD2":21.502
    ,"SD3":24.571
    ,"SD4":27.639
  },
  1502 : {
     "Day":1502
    ,"SD4neg":9.873
    ,"SD3neg":11.371
    ,"SD2neg":12.868
    ,"SD1neg":14.590
    ,"SD0":16.573
    ,"SD1":18.862
    ,"SD2":21.510
    ,"SD3":24.581
    ,"SD4":27.651
  },
  1503 : {
     "Day":1503
    ,"SD4neg":9.875
    ,"SD3neg":11.374
    ,"SD2neg":12.872
    ,"SD1neg":14.594
    ,"SD0":16.578
    ,"SD1":18.868
    ,"SD2":21.518
    ,"SD3":24.590
    ,"SD4":27.663
  },
  1504 : {
     "Day":1504
    ,"SD4neg":9.878
    ,"SD3neg":11.377
    ,"SD2neg":12.876
    ,"SD1neg":14.599
    ,"SD0":16.584
    ,"SD1":18.875
    ,"SD2":21.526
    ,"SD3":24.600
    ,"SD4":27.674
  },
  1505 : {
     "Day":1505
    ,"SD4neg":9.881
    ,"SD3neg":11.380
    ,"SD2neg":12.879
    ,"SD1neg":14.603
    ,"SD0":16.589
    ,"SD1":18.881
    ,"SD2":21.534
    ,"SD3":24.610
    ,"SD4":27.686
  },
  1506 : {
     "Day":1506
    ,"SD4neg":9.883
    ,"SD3neg":11.383
    ,"SD2neg":12.883
    ,"SD1neg":14.608
    ,"SD0":16.594
    ,"SD1":18.888
    ,"SD2":21.542
    ,"SD3":24.620
    ,"SD4":27.698
  },
  1507 : {
     "Day":1507
    ,"SD4neg":9.886
    ,"SD3neg":11.386
    ,"SD2neg":12.887
    ,"SD1neg":14.612
    ,"SD0":16.600
    ,"SD1":18.895
    ,"SD2":21.550
    ,"SD3":24.630
    ,"SD4":27.709
  },
  1508 : {
     "Day":1508
    ,"SD4neg":9.888
    ,"SD3neg":11.390
    ,"SD2neg":12.891
    ,"SD1neg":14.617
    ,"SD0":16.605
    ,"SD1":18.901
    ,"SD2":21.558
    ,"SD3":24.640
    ,"SD4":27.721
  },
  1509 : {
     "Day":1509
    ,"SD4neg":9.891
    ,"SD3neg":11.393
    ,"SD2neg":12.895
    ,"SD1neg":14.621
    ,"SD0":16.611
    ,"SD1":18.908
    ,"SD2":21.566
    ,"SD3":24.650
    ,"SD4":27.733
  },
  1510 : {
     "Day":1510
    ,"SD4neg":9.893
    ,"SD3neg":11.396
    ,"SD2neg":12.898
    ,"SD1neg":14.626
    ,"SD0":16.616
    ,"SD1":18.915
    ,"SD2":21.574
    ,"SD3":24.659
    ,"SD4":27.744
  },
  1511 : {
     "Day":1511
    ,"SD4neg":9.896
    ,"SD3neg":11.399
    ,"SD2neg":12.902
    ,"SD1neg":14.630
    ,"SD0":16.622
    ,"SD1":18.921
    ,"SD2":21.582
    ,"SD3":24.669
    ,"SD4":27.756
  },
  1512 : {
     "Day":1512
    ,"SD4neg":9.899
    ,"SD3neg":11.402
    ,"SD2neg":12.906
    ,"SD1neg":14.635
    ,"SD0":16.627
    ,"SD1":18.928
    ,"SD2":21.590
    ,"SD3":24.679
    ,"SD4":27.768
  },
  1513 : {
     "Day":1513
    ,"SD4neg":9.901
    ,"SD3neg":11.405
    ,"SD2neg":12.910
    ,"SD1neg":14.639
    ,"SD0":16.633
    ,"SD1":18.935
    ,"SD2":21.599
    ,"SD3":24.690
    ,"SD4":27.780
  },
  1514 : {
     "Day":1514
    ,"SD4neg":9.903
    ,"SD3neg":11.408
    ,"SD2neg":12.913
    ,"SD1neg":14.644
    ,"SD0":16.638
    ,"SD1":18.941
    ,"SD2":21.607
    ,"SD3":24.699
    ,"SD4":27.792
  },
  1515 : {
     "Day":1515
    ,"SD4neg":9.906
    ,"SD3neg":11.411
    ,"SD2neg":12.917
    ,"SD1neg":14.648
    ,"SD0":16.644
    ,"SD1":18.948
    ,"SD2":21.615
    ,"SD3":24.709
    ,"SD4":27.804
  },
  1516 : {
     "Day":1516
    ,"SD4neg":9.908
    ,"SD3neg":11.415
    ,"SD2neg":12.921
    ,"SD1neg":14.653
    ,"SD0":16.649
    ,"SD1":18.954
    ,"SD2":21.623
    ,"SD3":24.719
    ,"SD4":27.815
  },
  1517 : {
     "Day":1517
    ,"SD4neg":9.911
    ,"SD3neg":11.418
    ,"SD2neg":12.925
    ,"SD1neg":14.657
    ,"SD0":16.654
    ,"SD1":18.961
    ,"SD2":21.631
    ,"SD3":24.729
    ,"SD4":27.827
  },
  1518 : {
     "Day":1518
    ,"SD4neg":9.914
    ,"SD3neg":11.421
    ,"SD2neg":12.928
    ,"SD1neg":14.662
    ,"SD0":16.660
    ,"SD1":18.968
    ,"SD2":21.639
    ,"SD3":24.739
    ,"SD4":27.839
  },
  1519 : {
     "Day":1519
    ,"SD4neg":9.916
    ,"SD3neg":11.424
    ,"SD2neg":12.932
    ,"SD1neg":14.666
    ,"SD0":16.665
    ,"SD1":18.974
    ,"SD2":21.647
    ,"SD3":24.749
    ,"SD4":27.851
  },
  1520 : {
     "Day":1520
    ,"SD4neg":9.919
    ,"SD3neg":11.427
    ,"SD2neg":12.936
    ,"SD1neg":14.671
    ,"SD0":16.671
    ,"SD1":18.981
    ,"SD2":21.655
    ,"SD3":24.759
    ,"SD4":27.862
  },
  1521 : {
     "Day":1521
    ,"SD4neg":9.921
    ,"SD3neg":11.431
    ,"SD2neg":12.940
    ,"SD1neg":14.676
    ,"SD0":16.676
    ,"SD1":18.988
    ,"SD2":21.663
    ,"SD3":24.769
    ,"SD4":27.874
  },
  1522 : {
     "Day":1522
    ,"SD4neg":9.924
    ,"SD3neg":11.434
    ,"SD2neg":12.944
    ,"SD1neg":14.680
    ,"SD0":16.682
    ,"SD1":18.994
    ,"SD2":21.671
    ,"SD3":24.779
    ,"SD4":27.886
  },
  1523 : {
     "Day":1523
    ,"SD4neg":9.926
    ,"SD3neg":11.437
    ,"SD2neg":12.947
    ,"SD1neg":14.685
    ,"SD0":16.687
    ,"SD1":19.001
    ,"SD2":21.679
    ,"SD3":24.788
    ,"SD4":27.897
  },
  1524 : {
     "Day":1524
    ,"SD4neg":9.929
    ,"SD3neg":11.440
    ,"SD2neg":12.951
    ,"SD1neg":14.689
    ,"SD0":16.693
    ,"SD1":19.007
    ,"SD2":21.688
    ,"SD3":24.798
    ,"SD4":27.909
  },
  1525 : {
     "Day":1525
    ,"SD4neg":9.932
    ,"SD3neg":11.443
    ,"SD2neg":12.955
    ,"SD1neg":14.694
    ,"SD0":16.698
    ,"SD1":19.014
    ,"SD2":21.696
    ,"SD3":24.808
    ,"SD4":27.921
  },
  1526 : {
     "Day":1526
    ,"SD4neg":9.934
    ,"SD3neg":11.446
    ,"SD2neg":12.959
    ,"SD1neg":14.698
    ,"SD0":16.704
    ,"SD1":19.021
    ,"SD2":21.704
    ,"SD3":24.818
    ,"SD4":27.932
  },
  1527 : {
     "Day":1527
    ,"SD4neg":9.937
    ,"SD3neg":11.449
    ,"SD2neg":12.962
    ,"SD1neg":14.703
    ,"SD0":16.709
    ,"SD1":19.027
    ,"SD2":21.712
    ,"SD3":24.828
    ,"SD4":27.944
  },
  1528 : {
     "Day":1528
    ,"SD4neg":9.939
    ,"SD3neg":11.453
    ,"SD2neg":12.966
    ,"SD1neg":14.707
    ,"SD0":16.714
    ,"SD1":19.034
    ,"SD2":21.720
    ,"SD3":24.838
    ,"SD4":27.956
  },
  1529 : {
     "Day":1529
    ,"SD4neg":9.942
    ,"SD3neg":11.456
    ,"SD2neg":12.970
    ,"SD1neg":14.712
    ,"SD0":16.720
    ,"SD1":19.040
    ,"SD2":21.728
    ,"SD3":24.848
    ,"SD4":27.967
  },
  1530 : {
     "Day":1530
    ,"SD4neg":9.944
    ,"SD3neg":11.459
    ,"SD2neg":12.974
    ,"SD1neg":14.716
    ,"SD0":16.725
    ,"SD1":19.047
    ,"SD2":21.736
    ,"SD3":24.857
    ,"SD4":27.979
  },
  1531 : {
     "Day":1531
    ,"SD4neg":9.947
    ,"SD3neg":11.462
    ,"SD2neg":12.977
    ,"SD1neg":14.721
    ,"SD0":16.731
    ,"SD1":19.054
    ,"SD2":21.744
    ,"SD3":24.867
    ,"SD4":27.991
  },
  1532 : {
     "Day":1532
    ,"SD4neg":9.949
    ,"SD3neg":11.465
    ,"SD2neg":12.981
    ,"SD1neg":14.725
    ,"SD0":16.736
    ,"SD1":19.060
    ,"SD2":21.752
    ,"SD3":24.877
    ,"SD4":28.002
  },
  1533 : {
     "Day":1533
    ,"SD4neg":9.952
    ,"SD3neg":11.469
    ,"SD2neg":12.985
    ,"SD1neg":14.730
    ,"SD0":16.742
    ,"SD1":19.067
    ,"SD2":21.760
    ,"SD3":24.887
    ,"SD4":28.014
  },
  1534 : {
     "Day":1534
    ,"SD4neg":9.955
    ,"SD3neg":11.472
    ,"SD2neg":12.989
    ,"SD1neg":14.734
    ,"SD0":16.747
    ,"SD1":19.074
    ,"SD2":21.768
    ,"SD3":24.897
    ,"SD4":28.026
  },
  1535 : {
     "Day":1535
    ,"SD4neg":9.957
    ,"SD3neg":11.475
    ,"SD2neg":12.993
    ,"SD1neg":14.739
    ,"SD0":16.753
    ,"SD1":19.080
    ,"SD2":21.776
    ,"SD3":24.907
    ,"SD4":28.038
  },
  1536 : {
     "Day":1536
    ,"SD4neg":9.960
    ,"SD3neg":11.478
    ,"SD2neg":12.996
    ,"SD1neg":14.743
    ,"SD0":16.758
    ,"SD1":19.087
    ,"SD2":21.784
    ,"SD3":24.917
    ,"SD4":28.049
  },
  1537 : {
     "Day":1537
    ,"SD4neg":9.962
    ,"SD3neg":11.481
    ,"SD2neg":13.000
    ,"SD1neg":14.748
    ,"SD0":16.764
    ,"SD1":19.093
    ,"SD2":21.792
    ,"SD3":24.927
    ,"SD4":28.061
  },
  1538 : {
     "Day":1538
    ,"SD4neg":9.965
    ,"SD3neg":11.484
    ,"SD2neg":13.004
    ,"SD1neg":14.752
    ,"SD0":16.769
    ,"SD1":19.100
    ,"SD2":21.800
    ,"SD3":24.937
    ,"SD4":28.073
  },
  1539 : {
     "Day":1539
    ,"SD4neg":9.967
    ,"SD3neg":11.488
    ,"SD2neg":13.008
    ,"SD1neg":14.757
    ,"SD0":16.774
    ,"SD1":19.107
    ,"SD2":21.809
    ,"SD3":24.947
    ,"SD4":28.084
  },
  1540 : {
     "Day":1540
    ,"SD4neg":9.970
    ,"SD3neg":11.491
    ,"SD2neg":13.011
    ,"SD1neg":14.762
    ,"SD0":16.780
    ,"SD1":19.113
    ,"SD2":21.817
    ,"SD3":24.956
    ,"SD4":28.096
  },
  1541 : {
     "Day":1541
    ,"SD4neg":9.973
    ,"SD3neg":11.494
    ,"SD2neg":13.015
    ,"SD1neg":14.766
    ,"SD0":16.785
    ,"SD1":19.120
    ,"SD2":21.825
    ,"SD3":24.966
    ,"SD4":28.108
  },
  1542 : {
     "Day":1542
    ,"SD4neg":9.975
    ,"SD3neg":11.497
    ,"SD2neg":13.019
    ,"SD1neg":14.771
    ,"SD0":16.791
    ,"SD1":19.127
    ,"SD2":21.833
    ,"SD3":24.976
    ,"SD4":28.120
  },
  1543 : {
     "Day":1543
    ,"SD4neg":9.978
    ,"SD3neg":11.500
    ,"SD2neg":13.023
    ,"SD1neg":14.775
    ,"SD0":16.796
    ,"SD1":19.133
    ,"SD2":21.841
    ,"SD3":24.986
    ,"SD4":28.131
  },
  1544 : {
     "Day":1544
    ,"SD4neg":9.980
    ,"SD3neg":11.503
    ,"SD2neg":13.026
    ,"SD1neg":14.780
    ,"SD0":16.802
    ,"SD1":19.140
    ,"SD2":21.849
    ,"SD3":24.996
    ,"SD4":28.143
  },
  1545 : {
     "Day":1545
    ,"SD4neg":9.982
    ,"SD3neg":11.506
    ,"SD2neg":13.030
    ,"SD1neg":14.784
    ,"SD0":16.807
    ,"SD1":19.146
    ,"SD2":21.857
    ,"SD3":25.007
    ,"SD4":28.156
  },
  1546 : {
     "Day":1546
    ,"SD4neg":9.985
    ,"SD3neg":11.509
    ,"SD2neg":13.034
    ,"SD1neg":14.788
    ,"SD0":16.813
    ,"SD1":19.153
    ,"SD2":21.866
    ,"SD3":25.017
    ,"SD4":28.168
  },
  1547 : {
     "Day":1547
    ,"SD4neg":9.987
    ,"SD3neg":11.512
    ,"SD2neg":13.037
    ,"SD1neg":14.793
    ,"SD0":16.818
    ,"SD1":19.160
    ,"SD2":21.874
    ,"SD3":25.027
    ,"SD4":28.179
  },
  1548 : {
     "Day":1548
    ,"SD4neg":9.990
    ,"SD3neg":11.516
    ,"SD2neg":13.041
    ,"SD1neg":14.797
    ,"SD0":16.824
    ,"SD1":19.166
    ,"SD2":21.882
    ,"SD3":25.037
    ,"SD4":28.191
  },
  1549 : {
     "Day":1549
    ,"SD4neg":9.993
    ,"SD3neg":11.519
    ,"SD2neg":13.045
    ,"SD1neg":14.802
    ,"SD0":16.829
    ,"SD1":19.173
    ,"SD2":21.890
    ,"SD3":25.046
    ,"SD4":28.203
  },
  1550 : {
     "Day":1550
    ,"SD4neg":9.995
    ,"SD3neg":11.522
    ,"SD2neg":13.049
    ,"SD1neg":14.807
    ,"SD0":16.834
    ,"SD1":19.180
    ,"SD2":21.898
    ,"SD3":25.056
    ,"SD4":28.215
  },
  1551 : {
     "Day":1551
    ,"SD4neg":9.998
    ,"SD3neg":11.525
    ,"SD2neg":13.053
    ,"SD1neg":14.811
    ,"SD0":16.840
    ,"SD1":19.186
    ,"SD2":21.906
    ,"SD3":25.066
    ,"SD4":28.226
  },
  1552 : {
     "Day":1552
    ,"SD4neg":10.000
    ,"SD3neg":11.528
    ,"SD2neg":13.056
    ,"SD1neg":14.816
    ,"SD0":16.845
    ,"SD1":19.193
    ,"SD2":21.914
    ,"SD3":25.076
    ,"SD4":28.238
  },
  1553 : {
     "Day":1553
    ,"SD4neg":10.003
    ,"SD3neg":11.531
    ,"SD2neg":13.060
    ,"SD1neg":14.820
    ,"SD0":16.851
    ,"SD1":19.200
    ,"SD2":21.922
    ,"SD3":25.086
    ,"SD4":28.250
  },
  1554 : {
     "Day":1554
    ,"SD4neg":10.005
    ,"SD3neg":11.535
    ,"SD2neg":13.064
    ,"SD1neg":14.825
    ,"SD0":16.856
    ,"SD1":19.206
    ,"SD2":21.930
    ,"SD3":25.096
    ,"SD4":28.262
  },
  1555 : {
     "Day":1555
    ,"SD4neg":10.008
    ,"SD3neg":11.538
    ,"SD2neg":13.068
    ,"SD1neg":14.829
    ,"SD0":16.862
    ,"SD1":19.213
    ,"SD2":21.938
    ,"SD3":25.106
    ,"SD4":28.273
  },
  1556 : {
     "Day":1556
    ,"SD4neg":10.010
    ,"SD3neg":11.541
    ,"SD2neg":13.071
    ,"SD1neg":14.834
    ,"SD0":16.867
    ,"SD1":19.219
    ,"SD2":21.946
    ,"SD3":25.116
    ,"SD4":28.285
  },
  1557 : {
     "Day":1557
    ,"SD4neg":10.013
    ,"SD3neg":11.544
    ,"SD2neg":13.075
    ,"SD1neg":14.838
    ,"SD0":16.873
    ,"SD1":19.226
    ,"SD2":21.954
    ,"SD3":25.126
    ,"SD4":28.297
  },
  1558 : {
     "Day":1558
    ,"SD4neg":10.015
    ,"SD3neg":11.547
    ,"SD2neg":13.079
    ,"SD1neg":14.843
    ,"SD0":16.878
    ,"SD1":19.233
    ,"SD2":21.962
    ,"SD3":25.135
    ,"SD4":28.308
  },
  1559 : {
     "Day":1559
    ,"SD4neg":10.018
    ,"SD3neg":11.550
    ,"SD2neg":13.083
    ,"SD1neg":14.847
    ,"SD0":16.884
    ,"SD1":19.239
    ,"SD2":21.971
    ,"SD3":25.145
    ,"SD4":28.320
  },
  1560 : {
     "Day":1560
    ,"SD4neg":10.021
    ,"SD3neg":11.554
    ,"SD2neg":13.086
    ,"SD1neg":14.852
    ,"SD0":16.889
    ,"SD1":19.246
    ,"SD2":21.979
    ,"SD3":25.155
    ,"SD4":28.332
  },
  1561 : {
     "Day":1561
    ,"SD4neg":10.023
    ,"SD3neg":11.557
    ,"SD2neg":13.090
    ,"SD1neg":14.856
    ,"SD0":16.894
    ,"SD1":19.252
    ,"SD2":21.987
    ,"SD3":25.165
    ,"SD4":28.344
  },
  1562 : {
     "Day":1562
    ,"SD4neg":10.026
    ,"SD3neg":11.560
    ,"SD2neg":13.094
    ,"SD1neg":14.861
    ,"SD0":16.900
    ,"SD1":19.259
    ,"SD2":21.995
    ,"SD3":25.175
    ,"SD4":28.356
  },
  1563 : {
     "Day":1563
    ,"SD4neg":10.028
    ,"SD3neg":11.563
    ,"SD2neg":13.097
    ,"SD1neg":14.865
    ,"SD0":16.905
    ,"SD1":19.266
    ,"SD2":22.003
    ,"SD3":25.186
    ,"SD4":28.369
  },
  1564 : {
     "Day":1564
    ,"SD4neg":10.031
    ,"SD3neg":11.566
    ,"SD2neg":13.101
    ,"SD1neg":14.870
    ,"SD0":16.911
    ,"SD1":19.273
    ,"SD2":22.012
    ,"SD3":25.196
    ,"SD4":28.381
  },
  1565 : {
     "Day":1565
    ,"SD4neg":10.033
    ,"SD3neg":11.569
    ,"SD2neg":13.105
    ,"SD1neg":14.874
    ,"SD0":16.916
    ,"SD1":19.279
    ,"SD2":22.020
    ,"SD3":25.206
    ,"SD4":28.392
  },
  1566 : {
     "Day":1566
    ,"SD4neg":10.036
    ,"SD3neg":11.572
    ,"SD2neg":13.109
    ,"SD1neg":14.879
    ,"SD0":16.922
    ,"SD1":19.286
    ,"SD2":22.028
    ,"SD3":25.216
    ,"SD4":28.404
  },
  1567 : {
     "Day":1567
    ,"SD4neg":10.038
    ,"SD3neg":11.575
    ,"SD2neg":13.113
    ,"SD1neg":14.883
    ,"SD0":16.927
    ,"SD1":19.292
    ,"SD2":22.036
    ,"SD3":25.226
    ,"SD4":28.416
  },
  1568 : {
     "Day":1568
    ,"SD4neg":10.041
    ,"SD3neg":11.578
    ,"SD2neg":13.116
    ,"SD1neg":14.888
    ,"SD0":16.933
    ,"SD1":19.299
    ,"SD2":22.044
    ,"SD3":25.236
    ,"SD4":28.428
  },
  1569 : {
     "Day":1569
    ,"SD4neg":10.043
    ,"SD3neg":11.582
    ,"SD2neg":13.120
    ,"SD1neg":14.892
    ,"SD0":16.938
    ,"SD1":19.306
    ,"SD2":22.052
    ,"SD3":25.246
    ,"SD4":28.439
  },
  1570 : {
     "Day":1570
    ,"SD4neg":10.046
    ,"SD3neg":11.585
    ,"SD2neg":13.124
    ,"SD1neg":14.897
    ,"SD0":16.944
    ,"SD1":19.312
    ,"SD2":22.060
    ,"SD3":25.256
    ,"SD4":28.451
  },
  1571 : {
     "Day":1571
    ,"SD4neg":10.048
    ,"SD3neg":11.588
    ,"SD2neg":13.128
    ,"SD1neg":14.901
    ,"SD0":16.949
    ,"SD1":19.319
    ,"SD2":22.068
    ,"SD3":25.266
    ,"SD4":28.463
  },
  1572 : {
     "Day":1572
    ,"SD4neg":10.051
    ,"SD3neg":11.591
    ,"SD2neg":13.131
    ,"SD1neg":14.906
    ,"SD0":16.954
    ,"SD1":19.326
    ,"SD2":22.076
    ,"SD3":25.275
    ,"SD4":28.475
  },
  1573 : {
     "Day":1573
    ,"SD4neg":10.053
    ,"SD3neg":11.594
    ,"SD2neg":13.135
    ,"SD1neg":14.910
    ,"SD0":16.960
    ,"SD1":19.332
    ,"SD2":22.084
    ,"SD3":25.285
    ,"SD4":28.486
  },
  1574 : {
     "Day":1574
    ,"SD4neg":10.056
    ,"SD3neg":11.597
    ,"SD2neg":13.139
    ,"SD1neg":14.915
    ,"SD0":16.965
    ,"SD1":19.339
    ,"SD2":22.092
    ,"SD3":25.295
    ,"SD4":28.498
  },
  1575 : {
     "Day":1575
    ,"SD4neg":10.058
    ,"SD3neg":11.601
    ,"SD2neg":13.143
    ,"SD1neg":14.919
    ,"SD0":16.971
    ,"SD1":19.345
    ,"SD2":22.101
    ,"SD3":25.305
    ,"SD4":28.510
  },
  1576 : {
     "Day":1576
    ,"SD4neg":10.061
    ,"SD3neg":11.604
    ,"SD2neg":13.146
    ,"SD1neg":14.924
    ,"SD0":16.976
    ,"SD1":19.352
    ,"SD2":22.109
    ,"SD3":25.315
    ,"SD4":28.522
  },
  1577 : {
     "Day":1577
    ,"SD4neg":10.064
    ,"SD3neg":11.607
    ,"SD2neg":13.150
    ,"SD1neg":14.928
    ,"SD0":16.982
    ,"SD1":19.359
    ,"SD2":22.117
    ,"SD3":25.325
    ,"SD4":28.533
  },
  1578 : {
     "Day":1578
    ,"SD4neg":10.066
    ,"SD3neg":11.610
    ,"SD2neg":13.154
    ,"SD1neg":14.933
    ,"SD0":16.987
    ,"SD1":19.366
    ,"SD2":22.125
    ,"SD3":25.336
    ,"SD4":28.546
  },
  1579 : {
     "Day":1579
    ,"SD4neg":10.068
    ,"SD3neg":11.613
    ,"SD2neg":13.157
    ,"SD1neg":14.937
    ,"SD0":16.993
    ,"SD1":19.372
    ,"SD2":22.133
    ,"SD3":25.346
    ,"SD4":28.558
  },
  1580 : {
     "Day":1580
    ,"SD4neg":10.071
    ,"SD3neg":11.616
    ,"SD2neg":13.161
    ,"SD1neg":14.942
    ,"SD0":16.998
    ,"SD1":19.379
    ,"SD2":22.142
    ,"SD3":25.356
    ,"SD4":28.570
  },
  1581 : {
     "Day":1581
    ,"SD4neg":10.073
    ,"SD3neg":11.619
    ,"SD2neg":13.165
    ,"SD1neg":14.946
    ,"SD0":17.004
    ,"SD1":19.385
    ,"SD2":22.150
    ,"SD3":25.366
    ,"SD4":28.582
  },
  1582 : {
     "Day":1582
    ,"SD4neg":10.076
    ,"SD3neg":11.622
    ,"SD2neg":13.169
    ,"SD1neg":14.951
    ,"SD0":17.009
    ,"SD1":19.392
    ,"SD2":22.158
    ,"SD3":25.376
    ,"SD4":28.594
  },
  1583 : {
     "Day":1583
    ,"SD4neg":10.078
    ,"SD3neg":11.625
    ,"SD2neg":13.172
    ,"SD1neg":14.955
    ,"SD0":17.014
    ,"SD1":19.399
    ,"SD2":22.166
    ,"SD3":25.386
    ,"SD4":28.606
  },
  1584 : {
     "Day":1584
    ,"SD4neg":10.081
    ,"SD3neg":11.629
    ,"SD2neg":13.176
    ,"SD1neg":14.960
    ,"SD0":17.020
    ,"SD1":19.405
    ,"SD2":22.174
    ,"SD3":25.396
    ,"SD4":28.617
  },
  1585 : {
     "Day":1585
    ,"SD4neg":10.084
    ,"SD3neg":11.632
    ,"SD2neg":13.180
    ,"SD1neg":14.964
    ,"SD0":17.026
    ,"SD1":19.412
    ,"SD2":22.182
    ,"SD3":25.406
    ,"SD4":28.629
  },
  1586 : {
     "Day":1586
    ,"SD4neg":10.086
    ,"SD3neg":11.635
    ,"SD2neg":13.184
    ,"SD1neg":14.969
    ,"SD0":17.031
    ,"SD1":19.419
    ,"SD2":22.190
    ,"SD3":25.416
    ,"SD4":28.641
  },
  1587 : {
     "Day":1587
    ,"SD4neg":10.089
    ,"SD3neg":11.638
    ,"SD2neg":13.188
    ,"SD1neg":14.973
    ,"SD0":17.036
    ,"SD1":19.425
    ,"SD2":22.198
    ,"SD3":25.426
    ,"SD4":28.653
  },
  1588 : {
     "Day":1588
    ,"SD4neg":10.091
    ,"SD3neg":11.641
    ,"SD2neg":13.191
    ,"SD1neg":14.978
    ,"SD0":17.042
    ,"SD1":19.432
    ,"SD2":22.206
    ,"SD3":25.436
    ,"SD4":28.665
  },
  1589 : {
     "Day":1589
    ,"SD4neg":10.094
    ,"SD3neg":11.644
    ,"SD2neg":13.195
    ,"SD1neg":14.982
    ,"SD0":17.047
    ,"SD1":19.439
    ,"SD2":22.215
    ,"SD3":25.446
    ,"SD4":28.677
  },
  1590 : {
     "Day":1590
    ,"SD4neg":10.096
    ,"SD3neg":11.647
    ,"SD2neg":13.199
    ,"SD1neg":14.987
    ,"SD0":17.053
    ,"SD1":19.445
    ,"SD2":22.223
    ,"SD3":25.455
    ,"SD4":28.688
  },
  1591 : {
     "Day":1591
    ,"SD4neg":10.098
    ,"SD3neg":11.650
    ,"SD2neg":13.202
    ,"SD1neg":14.991
    ,"SD0":17.058
    ,"SD1":19.452
    ,"SD2":22.231
    ,"SD3":25.466
    ,"SD4":28.701
  },
  1592 : {
     "Day":1592
    ,"SD4neg":10.101
    ,"SD3neg":11.653
    ,"SD2neg":13.206
    ,"SD1neg":14.996
    ,"SD0":17.064
    ,"SD1":19.459
    ,"SD2":22.239
    ,"SD3":25.476
    ,"SD4":28.713
  },
  1593 : {
     "Day":1593
    ,"SD4neg":10.103
    ,"SD3neg":11.657
    ,"SD2neg":13.210
    ,"SD1neg":15.000
    ,"SD0":17.069
    ,"SD1":19.465
    ,"SD2":22.247
    ,"SD3":25.486
    ,"SD4":28.725
  },
  1594 : {
     "Day":1594
    ,"SD4neg":10.106
    ,"SD3neg":11.660
    ,"SD2neg":13.214
    ,"SD1neg":15.005
    ,"SD0":17.075
    ,"SD1":19.472
    ,"SD2":22.256
    ,"SD3":25.496
    ,"SD4":28.737
  },
  1595 : {
     "Day":1595
    ,"SD4neg":10.108
    ,"SD3neg":11.663
    ,"SD2neg":13.217
    ,"SD1neg":15.009
    ,"SD0":17.080
    ,"SD1":19.479
    ,"SD2":22.264
    ,"SD3":25.506
    ,"SD4":28.748
  },
  1596 : {
     "Day":1596
    ,"SD4neg":10.111
    ,"SD3neg":11.666
    ,"SD2neg":13.221
    ,"SD1neg":15.014
    ,"SD0":17.086
    ,"SD1":19.485
    ,"SD2":22.272
    ,"SD3":25.516
    ,"SD4":28.760
  },
  1597 : {
     "Day":1597
    ,"SD4neg":10.113
    ,"SD3neg":11.669
    ,"SD2neg":13.225
    ,"SD1neg":15.018
    ,"SD0":17.091
    ,"SD1":19.492
    ,"SD2":22.280
    ,"SD3":25.526
    ,"SD4":28.772
  },
  1598 : {
     "Day":1598
    ,"SD4neg":10.116
    ,"SD3neg":11.672
    ,"SD2neg":13.229
    ,"SD1neg":15.023
    ,"SD0":17.096
    ,"SD1":19.498
    ,"SD2":22.288
    ,"SD3":25.536
    ,"SD4":28.784
  },
  1599 : {
     "Day":1599
    ,"SD4neg":10.119
    ,"SD3neg":11.675
    ,"SD2neg":13.232
    ,"SD1neg":15.027
    ,"SD0":17.102
    ,"SD1":19.505
    ,"SD2":22.296
    ,"SD3":25.546
    ,"SD4":28.796
  },
  1600 : {
     "Day":1600
    ,"SD4neg":10.121
    ,"SD3neg":11.679
    ,"SD2neg":13.236
    ,"SD1neg":15.032
    ,"SD0":17.107
    ,"SD1":19.512
    ,"SD2":22.304
    ,"SD3":25.556
    ,"SD4":28.808
  },
  1601 : {
     "Day":1601
    ,"SD4neg":10.124
    ,"SD3neg":11.682
    ,"SD2neg":13.240
    ,"SD1neg":15.036
    ,"SD0":17.113
    ,"SD1":19.518
    ,"SD2":22.312
    ,"SD3":25.566
    ,"SD4":28.819
  },
  1602 : {
     "Day":1602
    ,"SD4neg":10.126
    ,"SD3neg":11.685
    ,"SD2neg":13.244
    ,"SD1neg":15.041
    ,"SD0":17.118
    ,"SD1":19.525
    ,"SD2":22.320
    ,"SD3":25.576
    ,"SD4":28.831
  },
  1603 : {
     "Day":1603
    ,"SD4neg":10.129
    ,"SD3neg":11.688
    ,"SD2neg":13.247
    ,"SD1neg":15.045
    ,"SD0":17.124
    ,"SD1":19.532
    ,"SD2":22.329
    ,"SD3":25.586
    ,"SD4":28.843
  },
  1604 : {
     "Day":1604
    ,"SD4neg":10.131
    ,"SD3neg":11.691
    ,"SD2neg":13.251
    ,"SD1neg":15.050
    ,"SD0":17.129
    ,"SD1":19.538
    ,"SD2":22.337
    ,"SD3":25.597
    ,"SD4":28.856
  },
  1605 : {
     "Day":1605
    ,"SD4neg":10.133
    ,"SD3neg":11.694
    ,"SD2neg":13.255
    ,"SD1neg":15.054
    ,"SD0":17.135
    ,"SD1":19.545
    ,"SD2":22.345
    ,"SD3":25.607
    ,"SD4":28.868
  },
  1606 : {
     "Day":1606
    ,"SD4neg":10.136
    ,"SD3neg":11.697
    ,"SD2neg":13.258
    ,"SD1neg":15.059
    ,"SD0":17.140
    ,"SD1":19.552
    ,"SD2":22.353
    ,"SD3":25.617
    ,"SD4":28.880
  },
  1607 : {
     "Day":1607
    ,"SD4neg":10.139
    ,"SD3neg":11.700
    ,"SD2neg":13.262
    ,"SD1neg":15.063
    ,"SD0":17.146
    ,"SD1":19.558
    ,"SD2":22.362
    ,"SD3":25.627
    ,"SD4":28.892
  },
  1608 : {
     "Day":1608
    ,"SD4neg":10.141
    ,"SD3neg":11.703
    ,"SD2neg":13.266
    ,"SD1neg":15.068
    ,"SD0":17.151
    ,"SD1":19.565
    ,"SD2":22.370
    ,"SD3":25.637
    ,"SD4":28.904
  },
  1609 : {
     "Day":1609
    ,"SD4neg":10.144
    ,"SD3neg":11.707
    ,"SD2neg":13.270
    ,"SD1neg":15.072
    ,"SD0":17.156
    ,"SD1":19.572
    ,"SD2":22.378
    ,"SD3":25.647
    ,"SD4":28.916
  },
  1610 : {
     "Day":1610
    ,"SD4neg":10.146
    ,"SD3neg":11.710
    ,"SD2neg":13.273
    ,"SD1neg":15.077
    ,"SD0":17.162
    ,"SD1":19.578
    ,"SD2":22.386
    ,"SD3":25.657
    ,"SD4":28.927
  },
  1611 : {
     "Day":1611
    ,"SD4neg":10.149
    ,"SD3neg":11.713
    ,"SD2neg":13.277
    ,"SD1neg":15.081
    ,"SD0":17.167
    ,"SD1":19.585
    ,"SD2":22.394
    ,"SD3":25.667
    ,"SD4":28.939
  },
  1612 : {
     "Day":1612
    ,"SD4neg":10.151
    ,"SD3neg":11.716
    ,"SD2neg":13.281
    ,"SD1neg":15.086
    ,"SD0":17.173
    ,"SD1":19.592
    ,"SD2":22.402
    ,"SD3":25.677
    ,"SD4":28.951
  },
  1613 : {
     "Day":1613
    ,"SD4neg":10.154
    ,"SD3neg":11.719
    ,"SD2neg":13.285
    ,"SD1neg":15.090
    ,"SD0":17.178
    ,"SD1":19.598
    ,"SD2":22.410
    ,"SD3":25.687
    ,"SD4":28.963
  },
  1614 : {
     "Day":1614
    ,"SD4neg":10.156
    ,"SD3neg":11.722
    ,"SD2neg":13.288
    ,"SD1neg":15.095
    ,"SD0":17.184
    ,"SD1":19.605
    ,"SD2":22.419
    ,"SD3":25.697
    ,"SD4":28.975
  },
  1615 : {
     "Day":1615
    ,"SD4neg":10.158
    ,"SD3neg":11.725
    ,"SD2neg":13.292
    ,"SD1neg":15.099
    ,"SD0":17.189
    ,"SD1":19.612
    ,"SD2":22.427
    ,"SD3":25.708
    ,"SD4":28.988
  },
  1616 : {
     "Day":1616
    ,"SD4neg":10.161
    ,"SD3neg":11.728
    ,"SD2neg":13.296
    ,"SD1neg":15.104
    ,"SD0":17.195
    ,"SD1":19.618
    ,"SD2":22.435
    ,"SD3":25.718
    ,"SD4":29.000
  },
  1617 : {
     "Day":1617
    ,"SD4neg":10.163
    ,"SD3neg":11.731
    ,"SD2neg":13.299
    ,"SD1neg":15.108
    ,"SD0":17.200
    ,"SD1":19.625
    ,"SD2":22.443
    ,"SD3":25.728
    ,"SD4":29.012
  },
  1618 : {
     "Day":1618
    ,"SD4neg":10.166
    ,"SD3neg":11.734
    ,"SD2neg":13.303
    ,"SD1neg":15.113
    ,"SD0":17.206
    ,"SD1":19.632
    ,"SD2":22.451
    ,"SD3":25.738
    ,"SD4":29.024
  },
  1619 : {
     "Day":1619
    ,"SD4neg":10.168
    ,"SD3neg":11.738
    ,"SD2neg":13.307
    ,"SD1neg":15.117
    ,"SD0":17.211
    ,"SD1":19.638
    ,"SD2":22.460
    ,"SD3":25.747
    ,"SD4":29.035
  },
  1620 : {
     "Day":1620
    ,"SD4neg":10.171
    ,"SD3neg":11.741
    ,"SD2neg":13.311
    ,"SD1neg":15.122
    ,"SD0":17.216
    ,"SD1":19.645
    ,"SD2":22.468
    ,"SD3":25.758
    ,"SD4":29.047
  },
  1621 : {
     "Day":1621
    ,"SD4neg":10.173
    ,"SD3neg":11.744
    ,"SD2neg":13.314
    ,"SD1neg":15.126
    ,"SD0":17.222
    ,"SD1":19.651
    ,"SD2":22.476
    ,"SD3":25.767
    ,"SD4":29.059
  },
  1622 : {
     "Day":1622
    ,"SD4neg":10.176
    ,"SD3neg":11.747
    ,"SD2neg":13.318
    ,"SD1neg":15.131
    ,"SD0":17.227
    ,"SD1":19.658
    ,"SD2":22.484
    ,"SD3":25.778
    ,"SD4":29.071
  },
  1623 : {
     "Day":1623
    ,"SD4neg":10.179
    ,"SD3neg":11.750
    ,"SD2neg":13.322
    ,"SD1neg":15.135
    ,"SD0":17.233
    ,"SD1":19.665
    ,"SD2":22.492
    ,"SD3":25.788
    ,"SD4":29.083
  },
  1624 : {
     "Day":1624
    ,"SD4neg":10.181
    ,"SD3neg":11.753
    ,"SD2neg":13.326
    ,"SD1neg":15.140
    ,"SD0":17.238
    ,"SD1":19.671
    ,"SD2":22.500
    ,"SD3":25.798
    ,"SD4":29.095
  },
  1625 : {
     "Day":1625
    ,"SD4neg":10.184
    ,"SD3neg":11.756
    ,"SD2neg":13.329
    ,"SD1neg":15.144
    ,"SD0":17.244
    ,"SD1":19.678
    ,"SD2":22.508
    ,"SD3":25.808
    ,"SD4":29.107
  },
  1626 : {
     "Day":1626
    ,"SD4neg":10.186
    ,"SD3neg":11.759
    ,"SD2neg":13.333
    ,"SD1neg":15.149
    ,"SD0":17.249
    ,"SD1":19.685
    ,"SD2":22.517
    ,"SD3":25.818
    ,"SD4":29.120
  },
  1627 : {
     "Day":1627
    ,"SD4neg":10.188
    ,"SD3neg":11.762
    ,"SD2neg":13.337
    ,"SD1neg":15.153
    ,"SD0":17.255
    ,"SD1":19.692
    ,"SD2":22.525
    ,"SD3":25.828
    ,"SD4":29.132
  },
  1628 : {
     "Day":1628
    ,"SD4neg":10.191
    ,"SD3neg":11.765
    ,"SD2neg":13.340
    ,"SD1neg":15.158
    ,"SD0":17.260
    ,"SD1":19.698
    ,"SD2":22.533
    ,"SD3":25.838
    ,"SD4":29.144
  },
  1629 : {
     "Day":1629
    ,"SD4neg":10.193
    ,"SD3neg":11.769
    ,"SD2neg":13.344
    ,"SD1neg":15.162
    ,"SD0":17.266
    ,"SD1":19.705
    ,"SD2":22.541
    ,"SD3":25.848
    ,"SD4":29.156
  },
  1630 : {
     "Day":1630
    ,"SD4neg":10.196
    ,"SD3neg":11.772
    ,"SD2neg":13.348
    ,"SD1neg":15.167
    ,"SD0":17.271
    ,"SD1":19.711
    ,"SD2":22.549
    ,"SD3":25.858
    ,"SD4":29.167
  },
  1631 : {
     "Day":1631
    ,"SD4neg":10.198
    ,"SD3neg":11.775
    ,"SD2neg":13.351
    ,"SD1neg":15.171
    ,"SD0":17.276
    ,"SD1":19.718
    ,"SD2":22.558
    ,"SD3":25.868
    ,"SD4":29.179
  },
  1632 : {
     "Day":1632
    ,"SD4neg":10.201
    ,"SD3neg":11.778
    ,"SD2neg":13.355
    ,"SD1neg":15.176
    ,"SD0":17.282
    ,"SD1":19.725
    ,"SD2":22.566
    ,"SD3":25.879
    ,"SD4":29.191
  },
  1633 : {
     "Day":1633
    ,"SD4neg":10.203
    ,"SD3neg":11.781
    ,"SD2neg":13.359
    ,"SD1neg":15.180
    ,"SD0":17.287
    ,"SD1":19.731
    ,"SD2":22.574
    ,"SD3":25.889
    ,"SD4":29.203
  },
  1634 : {
     "Day":1634
    ,"SD4neg":10.206
    ,"SD3neg":11.784
    ,"SD2neg":13.363
    ,"SD1neg":15.185
    ,"SD0":17.293
    ,"SD1":19.738
    ,"SD2":22.582
    ,"SD3":25.899
    ,"SD4":29.215
  },
  1635 : {
     "Day":1635
    ,"SD4neg":10.208
    ,"SD3neg":11.787
    ,"SD2neg":13.366
    ,"SD1neg":15.189
    ,"SD0":17.298
    ,"SD1":19.745
    ,"SD2":22.590
    ,"SD3":25.909
    ,"SD4":29.227
  },
  1636 : {
     "Day":1636
    ,"SD4neg":10.211
    ,"SD3neg":11.790
    ,"SD2neg":13.370
    ,"SD1neg":15.194
    ,"SD0":17.304
    ,"SD1":19.752
    ,"SD2":22.599
    ,"SD3":25.920
    ,"SD4":29.240
  },
  1637 : {
     "Day":1637
    ,"SD4neg":10.213
    ,"SD3neg":11.793
    ,"SD2neg":13.374
    ,"SD1neg":15.198
    ,"SD0":17.309
    ,"SD1":19.758
    ,"SD2":22.607
    ,"SD3":25.930
    ,"SD4":29.252
  },
  1638 : {
     "Day":1638
    ,"SD4neg":10.216
    ,"SD3neg":11.797
    ,"SD2neg":13.377
    ,"SD1neg":15.203
    ,"SD0":17.315
    ,"SD1":19.765
    ,"SD2":22.615
    ,"SD3":25.940
    ,"SD4":29.264
  },
  1639 : {
     "Day":1639
    ,"SD4neg":10.218
    ,"SD3neg":11.800
    ,"SD2neg":13.381
    ,"SD1neg":15.207
    ,"SD0":17.320
    ,"SD1":19.772
    ,"SD2":22.623
    ,"SD3":25.950
    ,"SD4":29.276
  },
  1640 : {
     "Day":1640
    ,"SD4neg":10.221
    ,"SD3neg":11.803
    ,"SD2neg":13.385
    ,"SD1neg":15.212
    ,"SD0":17.326
    ,"SD1":19.778
    ,"SD2":22.631
    ,"SD3":25.960
    ,"SD4":29.288
  },
  1641 : {
     "Day":1641
    ,"SD4neg":10.223
    ,"SD3neg":11.806
    ,"SD2neg":13.389
    ,"SD1neg":15.216
    ,"SD0":17.331
    ,"SD1":19.785
    ,"SD2":22.640
    ,"SD3":25.970
    ,"SD4":29.300
  },
  1642 : {
     "Day":1642
    ,"SD4neg":10.226
    ,"SD3neg":11.809
    ,"SD2neg":13.392
    ,"SD1neg":15.221
    ,"SD0":17.336
    ,"SD1":19.792
    ,"SD2":22.648
    ,"SD3":25.980
    ,"SD4":29.312
  },
  1643 : {
     "Day":1643
    ,"SD4neg":10.228
    ,"SD3neg":11.812
    ,"SD2neg":13.396
    ,"SD1neg":15.225
    ,"SD0":17.342
    ,"SD1":19.798
    ,"SD2":22.656
    ,"SD3":25.990
    ,"SD4":29.324
  },
  1644 : {
     "Day":1644
    ,"SD4neg":10.231
    ,"SD3neg":11.815
    ,"SD2neg":13.400
    ,"SD1neg":15.230
    ,"SD0":17.347
    ,"SD1":19.805
    ,"SD2":22.664
    ,"SD3":26.000
    ,"SD4":29.336
  },
  1645 : {
     "Day":1645
    ,"SD4neg":10.233
    ,"SD3neg":11.818
    ,"SD2neg":13.404
    ,"SD1neg":15.234
    ,"SD0":17.353
    ,"SD1":19.811
    ,"SD2":22.672
    ,"SD3":26.010
    ,"SD4":29.348
  },
  1646 : {
     "Day":1646
    ,"SD4neg":10.236
    ,"SD3neg":11.822
    ,"SD2neg":13.407
    ,"SD1neg":15.239
    ,"SD0":17.358
    ,"SD1":19.818
    ,"SD2":22.680
    ,"SD3":26.020
    ,"SD4":29.360
  },
  1647 : {
     "Day":1647
    ,"SD4neg":10.238
    ,"SD3neg":11.824
    ,"SD2neg":13.411
    ,"SD1neg":15.243
    ,"SD0":17.364
    ,"SD1":19.825
    ,"SD2":22.689
    ,"SD3":26.031
    ,"SD4":29.373
  },
  1648 : {
     "Day":1648
    ,"SD4neg":10.240
    ,"SD3neg":11.827
    ,"SD2neg":13.415
    ,"SD1neg":15.247
    ,"SD0":17.369
    ,"SD1":19.832
    ,"SD2":22.697
    ,"SD3":26.041
    ,"SD4":29.385
  },
  1649 : {
     "Day":1649
    ,"SD4neg":10.243
    ,"SD3neg":11.831
    ,"SD2neg":13.418
    ,"SD1neg":15.252
    ,"SD0":17.374
    ,"SD1":19.838
    ,"SD2":22.705
    ,"SD3":26.051
    ,"SD4":29.396
  },
  1650 : {
     "Day":1650
    ,"SD4neg":10.245
    ,"SD3neg":11.834
    ,"SD2neg":13.422
    ,"SD1neg":15.256
    ,"SD0":17.380
    ,"SD1":19.845
    ,"SD2":22.713
    ,"SD3":26.061
    ,"SD4":29.408
  },
  1651 : {
     "Day":1651
    ,"SD4neg":10.248
    ,"SD3neg":11.837
    ,"SD2neg":13.426
    ,"SD1neg":15.261
    ,"SD0":17.385
    ,"SD1":19.851
    ,"SD2":22.721
    ,"SD3":26.071
    ,"SD4":29.420
  },
  1652 : {
     "Day":1652
    ,"SD4neg":10.250
    ,"SD3neg":11.840
    ,"SD2neg":13.430
    ,"SD1neg":15.265
    ,"SD0":17.391
    ,"SD1":19.858
    ,"SD2":22.730
    ,"SD3":26.081
    ,"SD4":29.432
  },
  1653 : {
     "Day":1653
    ,"SD4neg":10.253
    ,"SD3neg":11.843
    ,"SD2neg":13.433
    ,"SD1neg":15.270
    ,"SD0":17.396
    ,"SD1":19.865
    ,"SD2":22.738
    ,"SD3":26.091
    ,"SD4":29.444
  },
  1654 : {
     "Day":1654
    ,"SD4neg":10.255
    ,"SD3neg":11.846
    ,"SD2neg":13.437
    ,"SD1neg":15.274
    ,"SD0":17.402
    ,"SD1":19.871
    ,"SD2":22.746
    ,"SD3":26.101
    ,"SD4":29.456
  },
  1655 : {
     "Day":1655
    ,"SD4neg":10.258
    ,"SD3neg":11.849
    ,"SD2neg":13.441
    ,"SD1neg":15.279
    ,"SD0":17.407
    ,"SD1":19.878
    ,"SD2":22.754
    ,"SD3":26.111
    ,"SD4":29.468
  },
  1656 : {
     "Day":1656
    ,"SD4neg":10.260
    ,"SD3neg":11.852
    ,"SD2neg":13.444
    ,"SD1neg":15.283
    ,"SD0":17.413
    ,"SD1":19.885
    ,"SD2":22.763
    ,"SD3":26.122
    ,"SD4":29.481
  },
  1657 : {
     "Day":1657
    ,"SD4neg":10.262
    ,"SD3neg":11.855
    ,"SD2neg":13.448
    ,"SD1neg":15.288
    ,"SD0":17.418
    ,"SD1":19.892
    ,"SD2":22.771
    ,"SD3":26.132
    ,"SD4":29.493
  },
  1658 : {
     "Day":1658
    ,"SD4neg":10.265
    ,"SD3neg":11.858
    ,"SD2neg":13.452
    ,"SD1neg":15.292
    ,"SD0":17.424
    ,"SD1":19.898
    ,"SD2":22.779
    ,"SD3":26.142
    ,"SD4":29.505
  },
  1659 : {
     "Day":1659
    ,"SD4neg":10.267
    ,"SD3neg":11.861
    ,"SD2neg":13.455
    ,"SD1neg":15.297
    ,"SD0":17.429
    ,"SD1":19.905
    ,"SD2":22.787
    ,"SD3":26.152
    ,"SD4":29.517
  },
  1660 : {
     "Day":1660
    ,"SD4neg":10.270
    ,"SD3neg":11.865
    ,"SD2neg":13.459
    ,"SD1neg":15.301
    ,"SD0":17.434
    ,"SD1":19.912
    ,"SD2":22.795
    ,"SD3":26.162
    ,"SD4":29.529
  },
  1661 : {
     "Day":1661
    ,"SD4neg":10.272
    ,"SD3neg":11.868
    ,"SD2neg":13.463
    ,"SD1neg":15.306
    ,"SD0":17.440
    ,"SD1":19.918
    ,"SD2":22.803
    ,"SD3":26.172
    ,"SD4":29.541
  },
  1662 : {
     "Day":1662
    ,"SD4neg":10.275
    ,"SD3neg":11.871
    ,"SD2neg":13.467
    ,"SD1neg":15.310
    ,"SD0":17.445
    ,"SD1":19.925
    ,"SD2":22.812
    ,"SD3":26.182
    ,"SD4":29.553
  },
  1663 : {
     "Day":1663
    ,"SD4neg":10.277
    ,"SD3neg":11.874
    ,"SD2neg":13.470
    ,"SD1neg":15.315
    ,"SD0":17.451
    ,"SD1":19.931
    ,"SD2":22.820
    ,"SD3":26.192
    ,"SD4":29.565
  },
  1664 : {
     "Day":1664
    ,"SD4neg":10.280
    ,"SD3neg":11.877
    ,"SD2neg":13.474
    ,"SD1neg":15.319
    ,"SD0":17.456
    ,"SD1":19.938
    ,"SD2":22.828
    ,"SD3":26.202
    ,"SD4":29.577
  },
  1665 : {
     "Day":1665
    ,"SD4neg":10.282
    ,"SD3neg":11.880
    ,"SD2neg":13.478
    ,"SD1neg":15.324
    ,"SD0":17.462
    ,"SD1":19.945
    ,"SD2":22.836
    ,"SD3":26.212
    ,"SD4":29.589
  },
  1666 : {
     "Day":1666
    ,"SD4neg":10.285
    ,"SD3neg":11.883
    ,"SD2neg":13.481
    ,"SD1neg":15.328
    ,"SD0":17.467
    ,"SD1":19.952
    ,"SD2":22.845
    ,"SD3":26.223
    ,"SD4":29.602
  },
  1667 : {
     "Day":1667
    ,"SD4neg":10.287
    ,"SD3neg":11.886
    ,"SD2neg":13.485
    ,"SD1neg":15.332
    ,"SD0":17.473
    ,"SD1":19.958
    ,"SD2":22.853
    ,"SD3":26.233
    ,"SD4":29.614
  },
  1668 : {
     "Day":1668
    ,"SD4neg":10.290
    ,"SD3neg":11.889
    ,"SD2neg":13.489
    ,"SD1neg":15.337
    ,"SD0":17.478
    ,"SD1":19.965
    ,"SD2":22.861
    ,"SD3":26.244
    ,"SD4":29.626
  },
  1669 : {
     "Day":1669
    ,"SD4neg":10.292
    ,"SD3neg":11.892
    ,"SD2neg":13.492
    ,"SD1neg":15.341
    ,"SD0":17.484
    ,"SD1":19.971
    ,"SD2":22.869
    ,"SD3":26.254
    ,"SD4":29.638
  },
  1670 : {
     "Day":1670
    ,"SD4neg":10.295
    ,"SD3neg":11.895
    ,"SD2neg":13.496
    ,"SD1neg":15.346
    ,"SD0":17.489
    ,"SD1":19.978
    ,"SD2":22.877
    ,"SD3":26.264
    ,"SD4":29.650
  },
  1671 : {
     "Day":1671
    ,"SD4neg":10.297
    ,"SD3neg":11.898
    ,"SD2neg":13.500
    ,"SD1neg":15.350
    ,"SD0":17.494
    ,"SD1":19.985
    ,"SD2":22.886
    ,"SD3":26.274
    ,"SD4":29.662
  },
  1672 : {
     "Day":1672
    ,"SD4neg":10.300
    ,"SD3neg":11.902
    ,"SD2neg":13.504
    ,"SD1neg":15.355
    ,"SD0":17.500
    ,"SD1":19.992
    ,"SD2":22.894
    ,"SD3":26.284
    ,"SD4":29.674
  },
  1673 : {
     "Day":1673
    ,"SD4neg":10.302
    ,"SD3neg":11.905
    ,"SD2neg":13.507
    ,"SD1neg":15.359
    ,"SD0":17.505
    ,"SD1":19.998
    ,"SD2":22.902
    ,"SD3":26.294
    ,"SD4":29.686
  },
  1674 : {
     "Day":1674
    ,"SD4neg":10.305
    ,"SD3neg":11.908
    ,"SD2neg":13.511
    ,"SD1neg":15.364
    ,"SD0":17.511
    ,"SD1":20.005
    ,"SD2":22.910
    ,"SD3":26.304
    ,"SD4":29.698
  },
  1675 : {
     "Day":1675
    ,"SD4neg":10.307
    ,"SD3neg":11.911
    ,"SD2neg":13.515
    ,"SD1neg":15.368
    ,"SD0":17.516
    ,"SD1":20.012
    ,"SD2":22.919
    ,"SD3":26.315
    ,"SD4":29.711
  },
  1676 : {
     "Day":1676
    ,"SD4neg":10.309
    ,"SD3neg":11.914
    ,"SD2neg":13.518
    ,"SD1neg":15.373
    ,"SD0":17.522
    ,"SD1":20.018
    ,"SD2":22.927
    ,"SD3":26.325
    ,"SD4":29.723
  },
  1677 : {
     "Day":1677
    ,"SD4neg":10.312
    ,"SD3neg":11.917
    ,"SD2neg":13.522
    ,"SD1neg":15.377
    ,"SD0":17.527
    ,"SD1":20.025
    ,"SD2":22.935
    ,"SD3":26.335
    ,"SD4":29.735
  },
  1678 : {
     "Day":1678
    ,"SD4neg":10.314
    ,"SD3neg":11.920
    ,"SD2neg":13.526
    ,"SD1neg":15.382
    ,"SD0":17.532
    ,"SD1":20.032
    ,"SD2":22.943
    ,"SD3":26.345
    ,"SD4":29.747
  },
  1679 : {
     "Day":1679
    ,"SD4neg":10.317
    ,"SD3neg":11.923
    ,"SD2neg":13.529
    ,"SD1neg":15.386
    ,"SD0":17.538
    ,"SD1":20.038
    ,"SD2":22.951
    ,"SD3":26.355
    ,"SD4":29.759
  },
  1680 : {
     "Day":1680
    ,"SD4neg":10.319
    ,"SD3neg":11.926
    ,"SD2neg":13.533
    ,"SD1neg":15.391
    ,"SD0":17.543
    ,"SD1":20.045
    ,"SD2":22.959
    ,"SD3":26.365
    ,"SD4":29.771
  },
  1681 : {
     "Day":1681
    ,"SD4neg":10.322
    ,"SD3neg":11.929
    ,"SD2neg":13.537
    ,"SD1neg":15.395
    ,"SD0":17.549
    ,"SD1":20.052
    ,"SD2":22.968
    ,"SD3":26.375
    ,"SD4":29.783
  },
  1682 : {
     "Day":1682
    ,"SD4neg":10.324
    ,"SD3neg":11.932
    ,"SD2neg":13.541
    ,"SD1neg":15.400
    ,"SD0":17.554
    ,"SD1":20.058
    ,"SD2":22.976
    ,"SD3":26.385
    ,"SD4":29.795
  },
  1683 : {
     "Day":1683
    ,"SD4neg":10.327
    ,"SD3neg":11.936
    ,"SD2neg":13.544
    ,"SD1neg":15.404
    ,"SD0":17.560
    ,"SD1":20.065
    ,"SD2":22.984
    ,"SD3":26.395
    ,"SD4":29.807
  },
  1684 : {
     "Day":1684
    ,"SD4neg":10.329
    ,"SD3neg":11.938
    ,"SD2neg":13.548
    ,"SD1neg":15.408
    ,"SD0":17.565
    ,"SD1":20.072
    ,"SD2":22.993
    ,"SD3":26.406
    ,"SD4":29.820
  },
  1685 : {
     "Day":1685
    ,"SD4neg":10.331
    ,"SD3neg":11.941
    ,"SD2neg":13.551
    ,"SD1neg":15.413
    ,"SD0":17.571
    ,"SD1":20.078
    ,"SD2":23.001
    ,"SD3":26.416
    ,"SD4":29.832
  },
  1686 : {
     "Day":1686
    ,"SD4neg":10.334
    ,"SD3neg":11.944
    ,"SD2neg":13.555
    ,"SD1neg":15.417
    ,"SD0":17.576
    ,"SD1":20.085
    ,"SD2":23.009
    ,"SD3":26.427
    ,"SD4":29.844
  },
  1687 : {
     "Day":1687
    ,"SD4neg":10.336
    ,"SD3neg":11.948
    ,"SD2neg":13.559
    ,"SD1neg":15.422
    ,"SD0":17.582
    ,"SD1":20.092
    ,"SD2":23.017
    ,"SD3":26.437
    ,"SD4":29.856
  },
  1688 : {
     "Day":1688
    ,"SD4neg":10.339
    ,"SD3neg":11.951
    ,"SD2neg":13.563
    ,"SD1neg":15.426
    ,"SD0":17.587
    ,"SD1":20.098
    ,"SD2":23.025
    ,"SD3":26.447
    ,"SD4":29.868
  },
  1689 : {
     "Day":1689
    ,"SD4neg":10.341
    ,"SD3neg":11.954
    ,"SD2neg":13.566
    ,"SD1neg":15.431
    ,"SD0":17.592
    ,"SD1":20.105
    ,"SD2":23.033
    ,"SD3":26.457
    ,"SD4":29.880
  },
  1690 : {
     "Day":1690
    ,"SD4neg":10.344
    ,"SD3neg":11.957
    ,"SD2neg":13.570
    ,"SD1neg":15.435
    ,"SD0":17.598
    ,"SD1":20.112
    ,"SD2":23.042
    ,"SD3":26.467
    ,"SD4":29.893
  },
  1691 : {
     "Day":1691
    ,"SD4neg":10.346
    ,"SD3neg":11.960
    ,"SD2neg":13.574
    ,"SD1neg":15.440
    ,"SD0":17.603
    ,"SD1":20.118
    ,"SD2":23.050
    ,"SD3":26.477
    ,"SD4":29.905
  },
  1692 : {
     "Day":1692
    ,"SD4neg":10.349
    ,"SD3neg":11.963
    ,"SD2neg":13.578
    ,"SD1neg":15.444
    ,"SD0":17.609
    ,"SD1":20.125
    ,"SD2":23.058
    ,"SD3":26.487
    ,"SD4":29.916
  },
  1693 : {
     "Day":1693
    ,"SD4neg":10.351
    ,"SD3neg":11.966
    ,"SD2neg":13.581
    ,"SD1neg":15.449
    ,"SD0":17.614
    ,"SD1":20.132
    ,"SD2":23.067
    ,"SD3":26.498
    ,"SD4":29.930
  },
  1694 : {
     "Day":1694
    ,"SD4neg":10.353
    ,"SD3neg":11.969
    ,"SD2neg":13.585
    ,"SD1neg":15.453
    ,"SD0":17.620
    ,"SD1":20.138
    ,"SD2":23.075
    ,"SD3":26.508
    ,"SD4":29.942
  },
  1695 : {
     "Day":1695
    ,"SD4neg":10.356
    ,"SD3neg":11.972
    ,"SD2neg":13.588
    ,"SD1neg":15.458
    ,"SD0":17.625
    ,"SD1":20.145
    ,"SD2":23.083
    ,"SD3":26.518
    ,"SD4":29.954
  },
  1696 : {
     "Day":1696
    ,"SD4neg":10.358
    ,"SD3neg":11.975
    ,"SD2neg":13.592
    ,"SD1neg":15.462
    ,"SD0":17.630
    ,"SD1":20.152
    ,"SD2":23.091
    ,"SD3":26.528
    ,"SD4":29.966
  },
  1697 : {
     "Day":1697
    ,"SD4neg":10.361
    ,"SD3neg":11.978
    ,"SD2neg":13.596
    ,"SD1neg":15.467
    ,"SD0":17.636
    ,"SD1":20.158
    ,"SD2":23.099
    ,"SD3":26.539
    ,"SD4":29.978
  },
  1698 : {
     "Day":1698
    ,"SD4neg":10.363
    ,"SD3neg":11.981
    ,"SD2neg":13.600
    ,"SD1neg":15.471
    ,"SD0":17.641
    ,"SD1":20.165
    ,"SD2":23.107
    ,"SD3":26.549
    ,"SD4":29.990
  },
  1699 : {
     "Day":1699
    ,"SD4neg":10.366
    ,"SD3neg":11.985
    ,"SD2neg":13.603
    ,"SD1neg":15.476
    ,"SD0":17.647
    ,"SD1":20.172
    ,"SD2":23.116
    ,"SD3":26.559
    ,"SD4":30.002
  },
  1700 : {
     "Day":1700
    ,"SD4neg":10.368
    ,"SD3neg":11.988
    ,"SD2neg":13.607
    ,"SD1neg":15.480
    ,"SD0":17.652
    ,"SD1":20.178
    ,"SD2":23.124
    ,"SD3":26.569
    ,"SD4":30.014
  },
  1701 : {
     "Day":1701
    ,"SD4neg":10.371
    ,"SD3neg":11.991
    ,"SD2neg":13.611
    ,"SD1neg":15.485
    ,"SD0":17.658
    ,"SD1":20.185
    ,"SD2":23.132
    ,"SD3":26.579
    ,"SD4":30.026
  },
  1702 : {
     "Day":1702
    ,"SD4neg":10.373
    ,"SD3neg":11.994
    ,"SD2neg":13.614
    ,"SD1neg":15.489
    ,"SD0":17.663
    ,"SD1":20.192
    ,"SD2":23.141
    ,"SD3":26.590
    ,"SD4":30.039
  },
  1703 : {
     "Day":1703
    ,"SD4neg":10.375
    ,"SD3neg":11.997
    ,"SD2neg":13.618
    ,"SD1neg":15.493
    ,"SD0":17.669
    ,"SD1":20.198
    ,"SD2":23.149
    ,"SD3":26.600
    ,"SD4":30.051
  },
  1704 : {
     "Day":1704
    ,"SD4neg":10.378
    ,"SD3neg":12.000
    ,"SD2neg":13.622
    ,"SD1neg":15.498
    ,"SD0":17.674
    ,"SD1":20.205
    ,"SD2":23.157
    ,"SD3":26.610
    ,"SD4":30.063
  },
  1705 : {
     "Day":1705
    ,"SD4neg":10.380
    ,"SD3neg":12.003
    ,"SD2neg":13.625
    ,"SD1neg":15.502
    ,"SD0":17.680
    ,"SD1":20.212
    ,"SD2":23.165
    ,"SD3":26.620
    ,"SD4":30.075
  },
  1706 : {
     "Day":1706
    ,"SD4neg":10.383
    ,"SD3neg":12.006
    ,"SD2neg":13.629
    ,"SD1neg":15.507
    ,"SD0":17.685
    ,"SD1":20.218
    ,"SD2":23.173
    ,"SD3":26.630
    ,"SD4":30.087
  },
  1707 : {
     "Day":1707
    ,"SD4neg":10.385
    ,"SD3neg":12.009
    ,"SD2neg":13.633
    ,"SD1neg":15.511
    ,"SD0":17.690
    ,"SD1":20.225
    ,"SD2":23.182
    ,"SD3":26.641
    ,"SD4":30.099
  },
  1708 : {
     "Day":1708
    ,"SD4neg":10.388
    ,"SD3neg":12.012
    ,"SD2neg":13.636
    ,"SD1neg":15.516
    ,"SD0":17.696
    ,"SD1":20.232
    ,"SD2":23.190
    ,"SD3":26.651
    ,"SD4":30.111
  },
  1709 : {
     "Day":1709
    ,"SD4neg":10.390
    ,"SD3neg":12.015
    ,"SD2neg":13.640
    ,"SD1neg":15.520
    ,"SD0":17.701
    ,"SD1":20.238
    ,"SD2":23.198
    ,"SD3":26.661
    ,"SD4":30.123
  },
  1710 : {
     "Day":1710
    ,"SD4neg":10.393
    ,"SD3neg":12.018
    ,"SD2neg":13.644
    ,"SD1neg":15.525
    ,"SD0":17.707
    ,"SD1":20.245
    ,"SD2":23.206
    ,"SD3":26.671
    ,"SD4":30.136
  },
  1711 : {
     "Day":1711
    ,"SD4neg":10.395
    ,"SD3neg":12.021
    ,"SD2neg":13.647
    ,"SD1neg":15.529
    ,"SD0":17.712
    ,"SD1":20.252
    ,"SD2":23.215
    ,"SD3":26.682
    ,"SD4":30.149
  },
  1712 : {
     "Day":1712
    ,"SD4neg":10.397
    ,"SD3neg":12.024
    ,"SD2neg":13.651
    ,"SD1neg":15.533
    ,"SD0":17.718
    ,"SD1":20.258
    ,"SD2":23.223
    ,"SD3":26.692
    ,"SD4":30.161
  },
  1713 : {
     "Day":1713
    ,"SD4neg":10.400
    ,"SD3neg":12.027
    ,"SD2neg":13.655
    ,"SD1neg":15.538
    ,"SD0":17.723
    ,"SD1":20.265
    ,"SD2":23.231
    ,"SD3":26.702
    ,"SD4":30.173
  },
  1714 : {
     "Day":1714
    ,"SD4neg":10.402
    ,"SD3neg":12.030
    ,"SD2neg":13.658
    ,"SD1neg":15.542
    ,"SD0":17.728
    ,"SD1":20.272
    ,"SD2":23.239
    ,"SD3":26.712
    ,"SD4":30.185
  },
  1715 : {
     "Day":1715
    ,"SD4neg":10.405
    ,"SD3neg":12.033
    ,"SD2neg":13.662
    ,"SD1neg":15.547
    ,"SD0":17.734
    ,"SD1":20.278
    ,"SD2":23.247
    ,"SD3":26.722
    ,"SD4":30.197
  },
  1716 : {
     "Day":1716
    ,"SD4neg":10.407
    ,"SD3neg":12.037
    ,"SD2neg":13.666
    ,"SD1neg":15.551
    ,"SD0":17.739
    ,"SD1":20.285
    ,"SD2":23.256
    ,"SD3":26.732
    ,"SD4":30.209
  },
  1717 : {
     "Day":1717
    ,"SD4neg":10.410
    ,"SD3neg":12.040
    ,"SD2neg":13.670
    ,"SD1neg":15.556
    ,"SD0":17.745
    ,"SD1":20.292
    ,"SD2":23.264
    ,"SD3":26.742
    ,"SD4":30.221
  },
  1718 : {
     "Day":1718
    ,"SD4neg":10.412
    ,"SD3neg":12.043
    ,"SD2neg":13.673
    ,"SD1neg":15.560
    ,"SD0":17.750
    ,"SD1":20.298
    ,"SD2":23.272
    ,"SD3":26.753
    ,"SD4":30.233
  },
  1719 : {
     "Day":1719
    ,"SD4neg":10.415
    ,"SD3neg":12.046
    ,"SD2neg":13.677
    ,"SD1neg":15.565
    ,"SD0":17.756
    ,"SD1":20.305
    ,"SD2":23.280
    ,"SD3":26.763
    ,"SD4":30.245
  },
  1720 : {
     "Day":1720
    ,"SD4neg":10.417
    ,"SD3neg":12.049
    ,"SD2neg":13.680
    ,"SD1neg":15.569
    ,"SD0":17.761
    ,"SD1":20.312
    ,"SD2":23.289
    ,"SD3":26.774
    ,"SD4":30.258
  },
  1721 : {
     "Day":1721
    ,"SD4neg":10.419
    ,"SD3neg":12.052
    ,"SD2neg":13.684
    ,"SD1neg":15.574
    ,"SD0":17.766
    ,"SD1":20.318
    ,"SD2":23.297
    ,"SD3":26.784
    ,"SD4":30.271
  },
  1722 : {
     "Day":1722
    ,"SD4neg":10.422
    ,"SD3neg":12.055
    ,"SD2neg":13.688
    ,"SD1neg":15.578
    ,"SD0":17.772
    ,"SD1":20.325
    ,"SD2":23.305
    ,"SD3":26.794
    ,"SD4":30.282
  },
  1723 : {
     "Day":1723
    ,"SD4neg":10.424
    ,"SD3neg":12.058
    ,"SD2neg":13.691
    ,"SD1neg":15.583
    ,"SD0":17.777
    ,"SD1":20.332
    ,"SD2":23.313
    ,"SD3":26.804
    ,"SD4":30.294
  },
  1724 : {
     "Day":1724
    ,"SD4neg":10.426
    ,"SD3neg":12.061
    ,"SD2neg":13.695
    ,"SD1neg":15.587
    ,"SD0":17.783
    ,"SD1":20.338
    ,"SD2":23.321
    ,"SD3":26.814
    ,"SD4":30.307
  },
  1725 : {
     "Day":1725
    ,"SD4neg":10.429
    ,"SD3neg":12.064
    ,"SD2neg":13.699
    ,"SD1neg":15.591
    ,"SD0":17.788
    ,"SD1":20.345
    ,"SD2":23.330
    ,"SD3":26.824
    ,"SD4":30.319
  },
  1726 : {
     "Day":1726
    ,"SD4neg":10.431
    ,"SD3neg":12.067
    ,"SD2neg":13.703
    ,"SD1neg":15.596
    ,"SD0":17.794
    ,"SD1":20.352
    ,"SD2":23.338
    ,"SD3":26.834
    ,"SD4":30.331
  },
  1727 : {
     "Day":1727
    ,"SD4neg":10.434
    ,"SD3neg":12.070
    ,"SD2neg":13.706
    ,"SD1neg":15.600
    ,"SD0":17.799
    ,"SD1":20.358
    ,"SD2":23.346
    ,"SD3":26.844
    ,"SD4":30.343
  },
  1728 : {
     "Day":1728
    ,"SD4neg":10.436
    ,"SD3neg":12.073
    ,"SD2neg":13.710
    ,"SD1neg":15.605
    ,"SD0":17.804
    ,"SD1":20.365
    ,"SD2":23.354
    ,"SD3":26.854
    ,"SD4":30.355
  },
  1729 : {
     "Day":1729
    ,"SD4neg":10.438
    ,"SD3neg":12.076
    ,"SD2neg":13.713
    ,"SD1neg":15.609
    ,"SD0":17.810
    ,"SD1":20.372
    ,"SD2":23.363
    ,"SD3":26.865
    ,"SD4":30.368
  },
  1730 : {
     "Day":1730
    ,"SD4neg":10.441
    ,"SD3neg":12.079
    ,"SD2neg":13.717
    ,"SD1neg":15.614
    ,"SD0":17.815
    ,"SD1":20.379
    ,"SD2":23.371
    ,"SD3":26.876
    ,"SD4":30.380
  },
  1731 : {
     "Day":1731
    ,"SD4neg":10.443
    ,"SD3neg":12.082
    ,"SD2neg":13.721
    ,"SD1neg":15.618
    ,"SD0":17.821
    ,"SD1":20.385
    ,"SD2":23.379
    ,"SD3":26.886
    ,"SD4":30.392
  },
  1732 : {
     "Day":1732
    ,"SD4neg":10.446
    ,"SD3neg":12.085
    ,"SD2neg":13.725
    ,"SD1neg":15.623
    ,"SD0":17.826
    ,"SD1":20.392
    ,"SD2":23.387
    ,"SD3":26.896
    ,"SD4":30.404
  },
  1733 : {
     "Day":1733
    ,"SD4neg":10.448
    ,"SD3neg":12.088
    ,"SD2neg":13.728
    ,"SD1neg":15.627
    ,"SD0":17.832
    ,"SD1":20.398
    ,"SD2":23.396
    ,"SD3":26.906
    ,"SD4":30.416
  },
  1734 : {
     "Day":1734
    ,"SD4neg":10.451
    ,"SD3neg":12.091
    ,"SD2neg":13.732
    ,"SD1neg":15.632
    ,"SD0":17.837
    ,"SD1":20.405
    ,"SD2":23.404
    ,"SD3":26.916
    ,"SD4":30.429
  },
  1735 : {
     "Day":1735
    ,"SD4neg":10.453
    ,"SD3neg":12.094
    ,"SD2neg":13.736
    ,"SD1neg":15.636
    ,"SD0":17.842
    ,"SD1":20.412
    ,"SD2":23.412
    ,"SD3":26.926
    ,"SD4":30.441
  },
  1736 : {
     "Day":1736
    ,"SD4neg":10.456
    ,"SD3neg":12.098
    ,"SD2neg":13.739
    ,"SD1neg":15.641
    ,"SD0":17.848
    ,"SD1":20.418
    ,"SD2":23.420
    ,"SD3":26.936
    ,"SD4":30.453
  },
  1737 : {
     "Day":1737
    ,"SD4neg":10.458
    ,"SD3neg":12.101
    ,"SD2neg":13.743
    ,"SD1neg":15.645
    ,"SD0":17.853
    ,"SD1":20.425
    ,"SD2":23.428
    ,"SD3":26.947
    ,"SD4":30.465
  },
  1738 : {
     "Day":1738
    ,"SD4neg":10.460
    ,"SD3neg":12.103
    ,"SD2neg":13.746
    ,"SD1neg":15.649
    ,"SD0":17.859
    ,"SD1":20.432
    ,"SD2":23.437
    ,"SD3":26.958
    ,"SD4":30.478
  },
  1739 : {
     "Day":1739
    ,"SD4neg":10.463
    ,"SD3neg":12.106
    ,"SD2neg":13.750
    ,"SD1neg":15.654
    ,"SD0":17.864
    ,"SD1":20.438
    ,"SD2":23.445
    ,"SD3":26.968
    ,"SD4":30.490
  },
  1740 : {
     "Day":1740
    ,"SD4neg":10.465
    ,"SD3neg":12.110
    ,"SD2neg":13.754
    ,"SD1neg":15.658
    ,"SD0":17.870
    ,"SD1":20.445
    ,"SD2":23.453
    ,"SD3":26.978
    ,"SD4":30.502
  },
  1741 : {
     "Day":1741
    ,"SD4neg":10.468
    ,"SD3neg":12.113
    ,"SD2neg":13.758
    ,"SD1neg":15.663
    ,"SD0":17.875
    ,"SD1":20.452
    ,"SD2":23.462
    ,"SD3":26.988
    ,"SD4":30.514
  },
  1742 : {
     "Day":1742
    ,"SD4neg":10.470
    ,"SD3neg":12.116
    ,"SD2neg":13.761
    ,"SD1neg":15.667
    ,"SD0":17.880
    ,"SD1":20.458
    ,"SD2":23.470
    ,"SD3":26.998
    ,"SD4":30.526
  },
  1743 : {
     "Day":1743
    ,"SD4neg":10.473
    ,"SD3neg":12.119
    ,"SD2neg":13.765
    ,"SD1neg":15.672
    ,"SD0":17.886
    ,"SD1":20.465
    ,"SD2":23.478
    ,"SD3":27.008
    ,"SD4":30.539
  },
  1744 : {
     "Day":1744
    ,"SD4neg":10.475
    ,"SD3neg":12.122
    ,"SD2neg":13.769
    ,"SD1neg":15.676
    ,"SD0":17.891
    ,"SD1":20.472
    ,"SD2":23.486
    ,"SD3":27.018
    ,"SD4":30.551
  },
  1745 : {
     "Day":1745
    ,"SD4neg":10.478
    ,"SD3neg":12.125
    ,"SD2neg":13.772
    ,"SD1neg":15.680
    ,"SD0":17.897
    ,"SD1":20.478
    ,"SD2":23.494
    ,"SD3":27.029
    ,"SD4":30.563
  },
  1746 : {
     "Day":1746
    ,"SD4neg":10.480
    ,"SD3neg":12.128
    ,"SD2neg":13.776
    ,"SD1neg":15.685
    ,"SD0":17.902
    ,"SD1":20.485
    ,"SD2":23.502
    ,"SD3":27.039
    ,"SD4":30.575
  },
  1747 : {
     "Day":1747
    ,"SD4neg":10.482
    ,"SD3neg":12.131
    ,"SD2neg":13.779
    ,"SD1neg":15.689
    ,"SD0":17.908
    ,"SD1":20.492
    ,"SD2":23.511
    ,"SD3":27.050
    ,"SD4":30.588
  },
  1748 : {
     "Day":1748
    ,"SD4neg":10.484
    ,"SD3neg":12.134
    ,"SD2neg":13.783
    ,"SD1neg":15.694
    ,"SD0":17.913
    ,"SD1":20.499
    ,"SD2":23.519
    ,"SD3":27.060
    ,"SD4":30.600
  },
  1749 : {
     "Day":1749
    ,"SD4neg":10.487
    ,"SD3neg":12.137
    ,"SD2neg":13.787
    ,"SD1neg":15.698
    ,"SD0":17.918
    ,"SD1":20.505
    ,"SD2":23.528
    ,"SD3":27.070
    ,"SD4":30.613
  },
  1750 : {
     "Day":1750
    ,"SD4neg":10.489
    ,"SD3neg":12.140
    ,"SD2neg":13.791
    ,"SD1neg":15.703
    ,"SD0":17.924
    ,"SD1":20.512
    ,"SD2":23.536
    ,"SD3":27.080
    ,"SD4":30.625
  },
  1751 : {
     "Day":1751
    ,"SD4neg":10.492
    ,"SD3neg":12.143
    ,"SD2neg":13.794
    ,"SD1neg":15.707
    ,"SD0":17.929
    ,"SD1":20.519
    ,"SD2":23.544
    ,"SD3":27.090
    ,"SD4":30.637
  },
  1752 : {
     "Day":1752
    ,"SD4neg":10.494
    ,"SD3neg":12.146
    ,"SD2neg":13.798
    ,"SD1neg":15.712
    ,"SD0":17.935
    ,"SD1":20.525
    ,"SD2":23.552
    ,"SD3":27.101
    ,"SD4":30.649
  },
  1753 : {
     "Day":1753
    ,"SD4neg":10.497
    ,"SD3neg":12.149
    ,"SD2neg":13.802
    ,"SD1neg":15.716
    ,"SD0":17.940
    ,"SD1":20.532
    ,"SD2":23.560
    ,"SD3":27.111
    ,"SD4":30.661
  },
  1754 : {
     "Day":1754
    ,"SD4neg":10.499
    ,"SD3neg":12.152
    ,"SD2neg":13.805
    ,"SD1neg":15.721
    ,"SD0":17.946
    ,"SD1":20.538
    ,"SD2":23.569
    ,"SD3":27.121
    ,"SD4":30.673
  },
  1755 : {
     "Day":1755
    ,"SD4neg":10.502
    ,"SD3neg":12.155
    ,"SD2neg":13.809
    ,"SD1neg":15.725
    ,"SD0":17.951
    ,"SD1":20.545
    ,"SD2":23.577
    ,"SD3":27.131
    ,"SD4":30.685
  },
  1756 : {
     "Day":1756
    ,"SD4neg":10.504
    ,"SD3neg":12.158
    ,"SD2neg":13.812
    ,"SD1neg":15.729
    ,"SD0":17.956
    ,"SD1":20.552
    ,"SD2":23.585
    ,"SD3":27.142
    ,"SD4":30.699
  },
  1757 : {
     "Day":1757
    ,"SD4neg":10.506
    ,"SD3neg":12.161
    ,"SD2neg":13.816
    ,"SD1neg":15.734
    ,"SD0":17.962
    ,"SD1":20.559
    ,"SD2":23.594
    ,"SD3":27.152
    ,"SD4":30.711
  },
  1758 : {
     "Day":1758
    ,"SD4neg":10.509
    ,"SD3neg":12.164
    ,"SD2neg":13.820
    ,"SD1neg":15.738
    ,"SD0":17.967
    ,"SD1":20.565
    ,"SD2":23.602
    ,"SD3":27.162
    ,"SD4":30.723
  },
  1759 : {
     "Day":1759
    ,"SD4neg":10.511
    ,"SD3neg":12.167
    ,"SD2neg":13.823
    ,"SD1neg":15.743
    ,"SD0":17.973
    ,"SD1":20.572
    ,"SD2":23.610
    ,"SD3":27.173
    ,"SD4":30.735
  },
  1760 : {
     "Day":1760
    ,"SD4neg":10.514
    ,"SD3neg":12.170
    ,"SD2neg":13.827
    ,"SD1neg":15.747
    ,"SD0":17.978
    ,"SD1":20.579
    ,"SD2":23.618
    ,"SD3":27.183
    ,"SD4":30.747
  },
  1761 : {
     "Day":1761
    ,"SD4neg":10.516
    ,"SD3neg":12.173
    ,"SD2neg":13.831
    ,"SD1neg":15.751
    ,"SD0":17.984
    ,"SD1":20.585
    ,"SD2":23.626
    ,"SD3":27.193
    ,"SD4":30.759
  },
  1762 : {
     "Day":1762
    ,"SD4neg":10.518
    ,"SD3neg":12.176
    ,"SD2neg":13.834
    ,"SD1neg":15.756
    ,"SD0":17.989
    ,"SD1":20.592
    ,"SD2":23.635
    ,"SD3":27.203
    ,"SD4":30.771
  },
  1763 : {
     "Day":1763
    ,"SD4neg":10.521
    ,"SD3neg":12.180
    ,"SD2neg":13.838
    ,"SD1neg":15.760
    ,"SD0":17.994
    ,"SD1":20.598
    ,"SD2":23.643
    ,"SD3":27.213
    ,"SD4":30.784
  },
  1764 : {
     "Day":1764
    ,"SD4neg":10.523
    ,"SD3neg":12.183
    ,"SD2neg":13.842
    ,"SD1neg":15.765
    ,"SD0":18.000
    ,"SD1":20.605
    ,"SD2":23.651
    ,"SD3":27.223
    ,"SD4":30.796
  },
  1765 : {
     "Day":1765
    ,"SD4neg":10.525
    ,"SD3neg":12.185
    ,"SD2neg":13.845
    ,"SD1neg":15.769
    ,"SD0":18.005
    ,"SD1":20.612
    ,"SD2":23.660
    ,"SD3":27.234
    ,"SD4":30.809
  },
  1766 : {
     "Day":1766
    ,"SD4neg":10.528
    ,"SD3neg":12.188
    ,"SD2neg":13.849
    ,"SD1neg":15.774
    ,"SD0":18.011
    ,"SD1":20.619
    ,"SD2":23.668
    ,"SD3":27.245
    ,"SD4":30.821
  },
  1767 : {
     "Day":1767
    ,"SD4neg":10.530
    ,"SD3neg":12.192
    ,"SD2neg":13.853
    ,"SD1neg":15.778
    ,"SD0":18.016
    ,"SD1":20.625
    ,"SD2":23.676
    ,"SD3":27.255
    ,"SD4":30.834
  },
  1768 : {
     "Day":1768
    ,"SD4neg":10.533
    ,"SD3neg":12.195
    ,"SD2neg":13.856
    ,"SD1neg":15.783
    ,"SD0":18.022
    ,"SD1":20.632
    ,"SD2":23.684
    ,"SD3":27.265
    ,"SD4":30.846
  },
  1769 : {
     "Day":1769
    ,"SD4neg":10.535
    ,"SD3neg":12.198
    ,"SD2neg":13.860
    ,"SD1neg":15.787
    ,"SD0":18.027
    ,"SD1":20.639
    ,"SD2":23.692
    ,"SD3":27.275
    ,"SD4":30.858
  },
  1770 : {
     "Day":1770
    ,"SD4neg":10.538
    ,"SD3neg":12.201
    ,"SD2neg":13.864
    ,"SD1neg":15.791
    ,"SD0":18.032
    ,"SD1":20.645
    ,"SD2":23.701
    ,"SD3":27.285
    ,"SD4":30.870
  },
  1771 : {
     "Day":1771
    ,"SD4neg":10.540
    ,"SD3neg":12.204
    ,"SD2neg":13.867
    ,"SD1neg":15.796
    ,"SD0":18.038
    ,"SD1":20.652
    ,"SD2":23.709
    ,"SD3":27.295
    ,"SD4":30.882
  },
  1772 : {
     "Day":1772
    ,"SD4neg":10.543
    ,"SD3neg":12.207
    ,"SD2neg":13.871
    ,"SD1neg":15.800
    ,"SD0":18.043
    ,"SD1":20.658
    ,"SD2":23.717
    ,"SD3":27.306
    ,"SD4":30.894
  },
  1773 : {
     "Day":1773
    ,"SD4neg":10.545
    ,"SD3neg":12.210
    ,"SD2neg":13.875
    ,"SD1neg":15.805
    ,"SD0":18.049
    ,"SD1":20.665
    ,"SD2":23.725
    ,"SD3":27.316
    ,"SD4":30.906
  },
  1774 : {
     "Day":1774
    ,"SD4neg":10.547
    ,"SD3neg":12.213
    ,"SD2neg":13.878
    ,"SD1neg":15.809
    ,"SD0":18.054
    ,"SD1":20.672
    ,"SD2":23.734
    ,"SD3":27.327
    ,"SD4":30.920
  },
  1775 : {
     "Day":1775
    ,"SD4neg":10.550
    ,"SD3neg":12.216
    ,"SD2neg":13.882
    ,"SD1neg":15.814
    ,"SD0":18.060
    ,"SD1":20.679
    ,"SD2":23.742
    ,"SD3":27.337
    ,"SD4":30.932
  },
  1776 : {
     "Day":1776
    ,"SD4neg":10.552
    ,"SD3neg":12.219
    ,"SD2neg":13.885
    ,"SD1neg":15.818
    ,"SD0":18.065
    ,"SD1":20.685
    ,"SD2":23.750
    ,"SD3":27.347
    ,"SD4":30.944
  },
  1777 : {
     "Day":1777
    ,"SD4neg":10.554
    ,"SD3neg":12.222
    ,"SD2neg":13.889
    ,"SD1neg":15.822
    ,"SD0":18.070
    ,"SD1":20.692
    ,"SD2":23.759
    ,"SD3":27.357
    ,"SD4":30.956
  },
  1778 : {
     "Day":1778
    ,"SD4neg":10.557
    ,"SD3neg":12.225
    ,"SD2neg":13.893
    ,"SD1neg":15.827
    ,"SD0":18.076
    ,"SD1":20.699
    ,"SD2":23.767
    ,"SD3":27.368
    ,"SD4":30.969
  },
  1779 : {
     "Day":1779
    ,"SD4neg":10.559
    ,"SD3neg":12.228
    ,"SD2neg":13.897
    ,"SD1neg":15.831
    ,"SD0":18.081
    ,"SD1":20.705
    ,"SD2":23.775
    ,"SD3":27.378
    ,"SD4":30.981
  },
  1780 : {
     "Day":1780
    ,"SD4neg":10.562
    ,"SD3neg":12.231
    ,"SD2neg":13.900
    ,"SD1neg":15.836
    ,"SD0":18.087
    ,"SD1":20.712
    ,"SD2":23.783
    ,"SD3":27.388
    ,"SD4":30.993
  },
  1781 : {
     "Day":1781
    ,"SD4neg":10.564
    ,"SD3neg":12.234
    ,"SD2neg":13.904
    ,"SD1neg":15.840
    ,"SD0":18.092
    ,"SD1":20.718
    ,"SD2":23.791
    ,"SD3":27.398
    ,"SD4":31.005
  },
  1782 : {
     "Day":1782
    ,"SD4neg":10.567
    ,"SD3neg":12.237
    ,"SD2neg":13.907
    ,"SD1neg":15.845
    ,"SD0":18.097
    ,"SD1":20.725
    ,"SD2":23.799
    ,"SD3":27.408
    ,"SD4":31.017
  },
  1783 : {
     "Day":1783
    ,"SD4neg":10.569
    ,"SD3neg":12.240
    ,"SD2neg":13.911
    ,"SD1neg":15.849
    ,"SD0":18.103
    ,"SD1":20.732
    ,"SD2":23.808
    ,"SD3":27.418
    ,"SD4":31.029
  },
  1784 : {
     "Day":1784
    ,"SD4neg":10.571
    ,"SD3neg":12.243
    ,"SD2neg":13.915
    ,"SD1neg":15.853
    ,"SD0":18.108
    ,"SD1":20.739
    ,"SD2":23.816
    ,"SD3":27.429
    ,"SD4":31.042
  },
  1785 : {
     "Day":1785
    ,"SD4neg":10.574
    ,"SD3neg":12.246
    ,"SD2neg":13.918
    ,"SD1neg":15.858
    ,"SD0":18.114
    ,"SD1":20.745
    ,"SD2":23.825
    ,"SD3":27.440
    ,"SD4":31.055
  },
  1786 : {
     "Day":1786
    ,"SD4neg":10.576
    ,"SD3neg":12.249
    ,"SD2neg":13.922
    ,"SD1neg":15.862
    ,"SD0":18.119
    ,"SD1":20.752
    ,"SD2":23.833
    ,"SD3":27.450
    ,"SD4":31.067
  },
  1787 : {
     "Day":1787
    ,"SD4neg":10.578
    ,"SD3neg":12.252
    ,"SD2neg":13.926
    ,"SD1neg":15.867
    ,"SD0":18.124
    ,"SD1":20.759
    ,"SD2":23.841
    ,"SD3":27.460
    ,"SD4":31.079
  },
  1788 : {
     "Day":1788
    ,"SD4neg":10.581
    ,"SD3neg":12.255
    ,"SD2neg":13.929
    ,"SD1neg":15.871
    ,"SD0":18.130
    ,"SD1":20.765
    ,"SD2":23.849
    ,"SD3":27.470
    ,"SD4":31.091
  },
  1789 : {
     "Day":1789
    ,"SD4neg":10.583
    ,"SD3neg":12.258
    ,"SD2neg":13.933
    ,"SD1neg":15.876
    ,"SD0":18.135
    ,"SD1":20.772
    ,"SD2":23.857
    ,"SD3":27.480
    ,"SD4":31.103
  },
  1790 : {
     "Day":1790
    ,"SD4neg":10.586
    ,"SD3neg":12.261
    ,"SD2neg":13.937
    ,"SD1neg":15.880
    ,"SD0":18.141
    ,"SD1":20.778
    ,"SD2":23.866
    ,"SD3":27.491
    ,"SD4":31.115
  },
  1791 : {
     "Day":1791
    ,"SD4neg":10.588
    ,"SD3neg":12.264
    ,"SD2neg":13.940
    ,"SD1neg":15.884
    ,"SD0":18.146
    ,"SD1":20.785
    ,"SD2":23.874
    ,"SD3":27.501
    ,"SD4":31.128
  },
  1792 : {
     "Day":1792
    ,"SD4neg":10.591
    ,"SD3neg":12.267
    ,"SD2neg":13.944
    ,"SD1neg":15.889
    ,"SD0":18.152
    ,"SD1":20.792
    ,"SD2":23.882
    ,"SD3":27.511
    ,"SD4":31.140
  },
  1793 : {
     "Day":1793
    ,"SD4neg":10.593
    ,"SD3neg":12.270
    ,"SD2neg":13.947
    ,"SD1neg":15.893
    ,"SD0":18.157
    ,"SD1":20.799
    ,"SD2":23.891
    ,"SD3":27.522
    ,"SD4":31.153
  },
  1794 : {
     "Day":1794
    ,"SD4neg":10.595
    ,"SD3neg":12.273
    ,"SD2neg":13.951
    ,"SD1neg":15.898
    ,"SD0":18.162
    ,"SD1":20.805
    ,"SD2":23.899
    ,"SD3":27.532
    ,"SD4":31.166
  },
  1795 : {
     "Day":1795
    ,"SD4neg":10.597
    ,"SD3neg":12.276
    ,"SD2neg":13.955
    ,"SD1neg":15.902
    ,"SD0":18.168
    ,"SD1":20.812
    ,"SD2":23.907
    ,"SD3":27.542
    ,"SD4":31.178
  },
  1796 : {
     "Day":1796
    ,"SD4neg":10.600
    ,"SD3neg":12.279
    ,"SD2neg":13.958
    ,"SD1neg":15.906
    ,"SD0":18.173
    ,"SD1":20.819
    ,"SD2":23.915
    ,"SD3":27.553
    ,"SD4":31.190
  },
  1797 : {
     "Day":1797
    ,"SD4neg":10.602
    ,"SD3neg":12.282
    ,"SD2neg":13.962
    ,"SD1neg":15.911
    ,"SD0":18.179
    ,"SD1":20.825
    ,"SD2":23.924
    ,"SD3":27.563
    ,"SD4":31.202
  },
  1798 : {
     "Day":1798
    ,"SD4neg":10.605
    ,"SD3neg":12.285
    ,"SD2neg":13.966
    ,"SD1neg":15.915
    ,"SD0":18.184
    ,"SD1":20.832
    ,"SD2":23.932
    ,"SD3":27.573
    ,"SD4":31.214
  },
  1799 : {
     "Day":1799
    ,"SD4neg":10.607
    ,"SD3neg":12.288
    ,"SD2neg":13.969
    ,"SD1neg":15.920
    ,"SD0":18.189
    ,"SD1":20.838
    ,"SD2":23.940
    ,"SD3":27.583
    ,"SD4":31.227
  },
  1800 : {
     "Day":1800
    ,"SD4neg":10.610
    ,"SD3neg":12.291
    ,"SD2neg":13.973
    ,"SD1neg":15.924
    ,"SD0":18.195
    ,"SD1":20.845
    ,"SD2":23.948
    ,"SD3":27.593
    ,"SD4":31.239
  },
  1801 : {
     "Day":1801
    ,"SD4neg":10.612
    ,"SD3neg":12.294
    ,"SD2neg":13.977
    ,"SD1neg":15.929
    ,"SD0":18.200
    ,"SD1":20.852
    ,"SD2":23.956
    ,"SD3":27.604
    ,"SD4":31.251
  },
  1802 : {
     "Day":1802
    ,"SD4neg":10.615
    ,"SD3neg":12.297
    ,"SD2neg":13.980
    ,"SD1neg":15.933
    ,"SD0":18.206
    ,"SD1":20.858
    ,"SD2":23.965
    ,"SD3":27.614
    ,"SD4":31.263
  },
  1803 : {
     "Day":1803
    ,"SD4neg":10.617
    ,"SD3neg":12.300
    ,"SD2neg":13.984
    ,"SD1neg":15.937
    ,"SD0":18.211
    ,"SD1":20.865
    ,"SD2":23.973
    ,"SD3":27.625
    ,"SD4":31.277
  },
  1804 : {
     "Day":1804
    ,"SD4neg":10.619
    ,"SD3neg":12.303
    ,"SD2neg":13.987
    ,"SD1neg":15.942
    ,"SD0":18.216
    ,"SD1":20.872
    ,"SD2":23.981
    ,"SD3":27.635
    ,"SD4":31.289
  },
  1805 : {
     "Day":1805
    ,"SD4neg":10.621
    ,"SD3neg":12.306
    ,"SD2neg":13.991
    ,"SD1neg":15.946
    ,"SD0":18.222
    ,"SD1":20.878
    ,"SD2":23.990
    ,"SD3":27.645
    ,"SD4":31.301
  },
  1806 : {
     "Day":1806
    ,"SD4neg":10.624
    ,"SD3neg":12.309
    ,"SD2neg":13.995
    ,"SD1neg":15.951
    ,"SD0":18.227
    ,"SD1":20.885
    ,"SD2":23.998
    ,"SD3":27.656
    ,"SD4":31.313
  },
  1807 : {
     "Day":1807
    ,"SD4neg":10.626
    ,"SD3neg":12.312
    ,"SD2neg":13.998
    ,"SD1neg":15.955
    ,"SD0":18.233
    ,"SD1":20.892
    ,"SD2":24.006
    ,"SD3":27.666
    ,"SD4":31.326
  },
  1808 : {
     "Day":1808
    ,"SD4neg":10.629
    ,"SD3neg":12.315
    ,"SD2neg":14.002
    ,"SD1neg":15.960
    ,"SD0":18.238
    ,"SD1":20.898
    ,"SD2":24.014
    ,"SD3":27.676
    ,"SD4":31.338
  },
  1809 : {
     "Day":1809
    ,"SD4neg":10.631
    ,"SD3neg":12.318
    ,"SD2neg":14.006
    ,"SD1neg":15.964
    ,"SD0":18.244
    ,"SD1":20.905
    ,"SD2":24.023
    ,"SD3":27.686
    ,"SD4":31.350
  },
  1810 : {
     "Day":1810
    ,"SD4neg":10.634
    ,"SD3neg":12.321
    ,"SD2neg":14.009
    ,"SD1neg":15.968
    ,"SD0":18.249
    ,"SD1":20.912
    ,"SD2":24.031
    ,"SD3":27.696
    ,"SD4":31.362
  },
  1811 : {
     "Day":1811
    ,"SD4neg":10.636
    ,"SD3neg":12.324
    ,"SD2neg":14.013
    ,"SD1neg":15.973
    ,"SD0":18.254
    ,"SD1":20.918
    ,"SD2":24.039
    ,"SD3":27.706
    ,"SD4":31.374
  },
  1812 : {
     "Day":1812
    ,"SD4neg":10.638
    ,"SD3neg":12.327
    ,"SD2neg":14.017
    ,"SD1neg":15.977
    ,"SD0":18.260
    ,"SD1":20.925
    ,"SD2":24.047
    ,"SD3":27.717
    ,"SD4":31.386
  },
  1813 : {
     "Day":1813
    ,"SD4neg":10.640
    ,"SD3neg":12.330
    ,"SD2neg":14.020
    ,"SD1neg":15.982
    ,"SD0":18.265
    ,"SD1":20.932
    ,"SD2":24.056
    ,"SD3":27.728
    ,"SD4":31.400
  },
  1814 : {
     "Day":1814
    ,"SD4neg":10.643
    ,"SD3neg":12.333
    ,"SD2neg":14.024
    ,"SD1neg":15.986
    ,"SD0":18.270
    ,"SD1":20.938
    ,"SD2":24.064
    ,"SD3":27.738
    ,"SD4":31.412
  },
  1815 : {
     "Day":1815
    ,"SD4neg":10.645
    ,"SD3neg":12.336
    ,"SD2neg":14.027
    ,"SD1neg":15.990
    ,"SD0":18.276
    ,"SD1":20.945
    ,"SD2":24.072
    ,"SD3":27.748
    ,"SD4":31.424
  },
  1816 : {
     "Day":1816
    ,"SD4neg":10.648
    ,"SD3neg":12.339
    ,"SD2neg":14.031
    ,"SD1neg":15.995
    ,"SD0":18.281
    ,"SD1":20.952
    ,"SD2":24.080
    ,"SD3":27.758
    ,"SD4":31.436
  },
  1817 : {
     "Day":1817
    ,"SD4neg":10.650
    ,"SD3neg":12.342
    ,"SD2neg":14.035
    ,"SD1neg":15.999
    ,"SD0":18.287
    ,"SD1":20.958
    ,"SD2":24.089
    ,"SD3":27.769
    ,"SD4":31.449
  },
  1818 : {
     "Day":1818
    ,"SD4neg":10.652
    ,"SD3neg":12.345
    ,"SD2neg":14.038
    ,"SD1neg":16.004
    ,"SD0":18.292
    ,"SD1":20.965
    ,"SD2":24.097
    ,"SD3":27.779
    ,"SD4":31.461
  },
  1819 : {
     "Day":1819
    ,"SD4neg":10.655
    ,"SD3neg":12.348
    ,"SD2neg":14.042
    ,"SD1neg":16.008
    ,"SD0":18.298
    ,"SD1":20.972
    ,"SD2":24.105
    ,"SD3":27.789
    ,"SD4":31.473
  },
  1820 : {
     "Day":1820
    ,"SD4neg":10.657
    ,"SD3neg":12.351
    ,"SD2neg":14.046
    ,"SD1neg":16.012
    ,"SD0":18.303
    ,"SD1":20.978
    ,"SD2":24.113
    ,"SD3":27.799
    ,"SD4":31.485
  },
  1821 : {
     "Day":1821
    ,"SD4neg":10.660
    ,"SD3neg":12.354
    ,"SD2neg":14.049
    ,"SD1neg":16.017
    ,"SD0":18.308
    ,"SD1":20.985
    ,"SD2":24.121
    ,"SD3":27.810
    ,"SD4":31.498
  },
  1822 : {
     "Day":1822
    ,"SD4neg":10.662
    ,"SD3neg":12.358
    ,"SD2neg":14.053
    ,"SD1neg":16.021
    ,"SD0":18.314
    ,"SD1":20.992
    ,"SD2":24.130
    ,"SD3":27.820
    ,"SD4":31.510
  },
  1823 : {
     "Day":1823
    ,"SD4neg":10.664
    ,"SD3neg":12.360
    ,"SD2neg":14.056
    ,"SD1neg":16.026
    ,"SD0":18.319
    ,"SD1":20.998
    ,"SD2":24.138
    ,"SD3":27.831
    ,"SD4":31.523
  },
  1824 : {
     "Day":1824
    ,"SD4neg":10.667
    ,"SD3neg":12.363
    ,"SD2neg":14.060
    ,"SD1neg":16.030
    ,"SD0":18.324
    ,"SD1":21.005
    ,"SD2":24.147
    ,"SD3":27.841
    ,"SD4":31.535
  },
  1825 : {
     "Day":1825
    ,"SD4neg":10.669
    ,"SD3neg":12.366
    ,"SD2neg":14.063
    ,"SD1neg":16.034
    ,"SD0":18.330
    ,"SD1":21.012
    ,"SD2":24.155
    ,"SD3":27.851
    ,"SD4":31.548
  },
  1826 : {
     "Day":1826
    ,"SD4neg":10.671
    ,"SD3neg":12.369
    ,"SD2neg":14.067
    ,"SD1neg":16.039
    ,"SD0":18.335
    ,"SD1":21.018
    ,"SD2":24.163
    ,"SD3":27.861
    ,"SD4":31.560
  },
  1827 : {
     "Day":1827
    ,"SD4neg":10.674
    ,"SD3neg":12.372
    ,"SD2neg":14.071
    ,"SD1neg":16.043
    ,"SD0":18.341
    ,"SD1":21.025
    ,"SD2":24.171
    ,"SD3":27.872
    ,"SD4":31.572
  },
  1828 : {
     "Day":1828
    ,"SD4neg":10.676
    ,"SD3neg":12.375
    ,"SD2neg":14.074
    ,"SD1neg":16.048
    ,"SD0":18.346
    ,"SD1":21.031
    ,"SD2":24.179
    ,"SD3":27.882
    ,"SD4":31.584
  },
  1829 : {
     "Day":1829
    ,"SD4neg":10.679
    ,"SD3neg":12.378
    ,"SD2neg":14.078
    ,"SD1neg":16.052
    ,"SD0":18.351
    ,"SD1":21.038
    ,"SD2":24.188
    ,"SD3":27.892
    ,"SD4":31.597
  },
  1830 : {
     "Day":1830
    ,"SD4neg":10.681
    ,"SD3neg":12.381
    ,"SD2neg":14.082
    ,"SD1neg":16.056
    ,"SD0":18.357
    ,"SD1":21.045
    ,"SD2":24.196
    ,"SD3":27.902
    ,"SD4":31.609
  },
  1831 : {
     "Day":1831
    ,"SD4neg":10.683
    ,"SD3neg":12.384
    ,"SD2neg":14.085
    ,"SD1neg":16.061
    ,"SD0":18.362
    ,"SD1":21.051
    ,"SD2":24.204
    ,"SD3":27.913
    ,"SD4":31.621
  },
  1832 : {
     "Day":1832
    ,"SD4neg":10.686
    ,"SD3neg":12.387
    ,"SD2neg":14.089
    ,"SD1neg":16.065
    ,"SD0":18.368
    ,"SD1":21.058
    ,"SD2":24.212
    ,"SD3":27.923
    ,"SD4":31.633
  },
  1833 : {
     "Day":1833
    ,"SD4neg":10.688
    ,"SD3neg":12.390
    ,"SD2neg":14.093
    ,"SD1neg":16.070
    ,"SD0":18.373
    ,"SD1":21.065
    ,"SD2":24.220
    ,"SD3":27.933
    ,"SD4":31.646
  },
  1834 : {
     "Day":1834
    ,"SD4neg":10.690
    ,"SD3neg":12.393
    ,"SD2neg":14.096
    ,"SD1neg":16.074
    ,"SD0":18.378
    ,"SD1":21.072
    ,"SD2":24.229
    ,"SD3":27.944
    ,"SD4":31.659
  },
  1835 : {
     "Day":1835
    ,"SD4neg":10.693
    ,"SD3neg":12.396
    ,"SD2neg":14.100
    ,"SD1neg":16.078
    ,"SD0":18.384
    ,"SD1":21.078
    ,"SD2":24.237
    ,"SD3":27.954
    ,"SD4":31.671
  },
  1836 : {
     "Day":1836
    ,"SD4neg":10.695
    ,"SD3neg":12.399
    ,"SD2neg":14.103
    ,"SD1neg":16.083
    ,"SD0":18.389
    ,"SD1":21.085
    ,"SD2":24.245
    ,"SD3":27.964
    ,"SD4":31.683
  },
  1837 : {
     "Day":1837
    ,"SD4neg":10.697
    ,"SD3neg":12.402
    ,"SD2neg":14.107
    ,"SD1neg":16.087
    ,"SD0":18.394
    ,"SD1":21.091
    ,"SD2":24.254
    ,"SD3":27.975
    ,"SD4":31.696
  },
  1838 : {
     "Day":1838
    ,"SD4neg":10.700
    ,"SD3neg":12.405
    ,"SD2neg":14.111
    ,"SD1neg":16.092
    ,"SD0":18.400
    ,"SD1":21.098
    ,"SD2":24.262
    ,"SD3":27.985
    ,"SD4":31.708
  },
  1839 : {
     "Day":1839
    ,"SD4neg":10.702
    ,"SD3neg":12.408
    ,"SD2neg":14.114
    ,"SD1neg":16.096
    ,"SD0":18.405
    ,"SD1":21.105
    ,"SD2":24.270
    ,"SD3":27.995
    ,"SD4":31.720
  },
  1840 : {
     "Day":1840
    ,"SD4neg":10.705
    ,"SD3neg":12.411
    ,"SD2neg":14.118
    ,"SD1neg":16.100
    ,"SD0":18.411
    ,"SD1":21.111
    ,"SD2":24.278
    ,"SD3":28.005
    ,"SD4":31.732
  },
  1841 : {
     "Day":1841
    ,"SD4neg":10.707
    ,"SD3neg":12.414
    ,"SD2neg":14.121
    ,"SD1neg":16.105
    ,"SD0":18.416
    ,"SD1":21.118
    ,"SD2":24.287
    ,"SD3":28.016
    ,"SD4":31.745
  },
  1842 : {
     "Day":1842
    ,"SD4neg":10.709
    ,"SD3neg":12.417
    ,"SD2neg":14.125
    ,"SD1neg":16.109
    ,"SD0":18.422
    ,"SD1":21.125
    ,"SD2":24.295
    ,"SD3":28.026
    ,"SD4":31.757
  },
  1843 : {
     "Day":1843
    ,"SD4neg":10.712
    ,"SD3neg":12.420
    ,"SD2neg":14.129
    ,"SD1neg":16.114
    ,"SD0":18.427
    ,"SD1":21.131
    ,"SD2":24.303
    ,"SD3":28.036
    ,"SD4":31.769
  },
  1844 : {
     "Day":1844
    ,"SD4neg":10.714
    ,"SD3neg":12.423
    ,"SD2neg":14.132
    ,"SD1neg":16.118
    ,"SD0":18.432
    ,"SD1":21.138
    ,"SD2":24.311
    ,"SD3":28.046
    ,"SD4":31.781
  },
  1845 : {
     "Day":1845
    ,"SD4neg":10.716
    ,"SD3neg":12.426
    ,"SD2neg":14.136
    ,"SD1neg":16.122
    ,"SD0":18.438
    ,"SD1":21.145
    ,"SD2":24.320
    ,"SD3":28.057
    ,"SD4":31.795
  },
  1846 : {
     "Day":1846
    ,"SD4neg":10.719
    ,"SD3neg":12.429
    ,"SD2neg":14.139
    ,"SD1neg":16.127
    ,"SD0":18.443
    ,"SD1":21.151
    ,"SD2":24.328
    ,"SD3":28.068
    ,"SD4":31.807
  },
  1847 : {
     "Day":1847
    ,"SD4neg":10.721
    ,"SD3neg":12.432
    ,"SD2neg":14.143
    ,"SD1neg":16.131
    ,"SD0":18.448
    ,"SD1":21.158
    ,"SD2":24.336
    ,"SD3":28.078
    ,"SD4":31.820
  },
  1848 : {
     "Day":1848
    ,"SD4neg":10.723
    ,"SD3neg":12.435
    ,"SD2neg":14.147
    ,"SD1neg":16.136
    ,"SD0":18.454
    ,"SD1":21.164
    ,"SD2":24.345
    ,"SD3":28.088
    ,"SD4":31.832
  },
  1849 : {
     "Day":1849
    ,"SD4neg":10.726
    ,"SD3neg":12.438
    ,"SD2neg":14.150
    ,"SD1neg":16.140
    ,"SD0":18.459
    ,"SD1":21.171
    ,"SD2":24.353
    ,"SD3":28.098
    ,"SD4":31.844
  },
  1850 : {
     "Day":1850
    ,"SD4neg":10.728
    ,"SD3neg":12.441
    ,"SD2neg":14.154
    ,"SD1neg":16.144
    ,"SD0":18.464
    ,"SD1":21.178
    ,"SD2":24.361
    ,"SD3":28.109
    ,"SD4":31.856
  },
  1851 : {
     "Day":1851
    ,"SD4neg":10.731
    ,"SD3neg":12.444
    ,"SD2neg":14.158
    ,"SD1neg":16.149
    ,"SD0":18.470
    ,"SD1":21.184
    ,"SD2":24.369
    ,"SD3":28.119
    ,"SD4":31.869
  },
  1852 : {
     "Day":1852
    ,"SD4neg":10.733
    ,"SD3neg":12.447
    ,"SD2neg":14.161
    ,"SD1neg":16.153
    ,"SD0":18.475
    ,"SD1":21.191
    ,"SD2":24.377
    ,"SD3":28.129
    ,"SD4":31.881
  },
  1853 : {
     "Day":1853
    ,"SD4neg":10.736
    ,"SD3neg":12.450
    ,"SD2neg":14.165
    ,"SD1neg":16.158
    ,"SD0":18.481
    ,"SD1":21.198
    ,"SD2":24.386
    ,"SD3":28.139
    ,"SD4":31.893
  },
  1854 : {
     "Day":1854
    ,"SD4neg":10.738
    ,"SD3neg":12.453
    ,"SD2neg":14.168
    ,"SD1neg":16.162
    ,"SD0":18.486
    ,"SD1":21.204
    ,"SD2":24.394
    ,"SD3":28.150
    ,"SD4":31.905
  },
  1855 : {
     "Day":1855
    ,"SD4neg":10.740
    ,"SD3neg":12.456
    ,"SD2neg":14.172
    ,"SD1neg":16.166
    ,"SD0":18.491
    ,"SD1":21.211
    ,"SD2":24.402
    ,"SD3":28.160
    ,"SD4":31.917
  },
  1856 : {
     "Day":1856
    ,"SD4neg":10.742
    ,"SD3neg":12.459
    ,"SD2neg":14.175
    ,"SD1neg":16.171
    ,"SD0":18.497
    ,"SD1":21.218
    ,"SD2":24.411
    ,"SD3":28.171
    ,"SD4":31.931
  }]'

z_score = Questions::PhysicalExam.create!(
  algorithm_id: 3,
  reference: '100',
  label_en: 'weight for age',
  stage: Question.stages[:registration],
  priority: Question.priorities[:mandatory],
  answer_type_id: 3,
  reference_table_x: 23,
  reference_table_y: 0,
  reference_table_male: ,
  reference_table_female:
)
z_score.answers.create!(reference: '1', label_en: 'less than -3 z-score', operator: Answer.operators[:less], value: '-3')
z_score.answers.create!(reference: '2', label_en: 'between -3 and -2 z-score', operator: Answer.operators[:between], value: '-2, -3')
z_score.answers.create!(reference: '3', label_en: 'more than -2 z-score', operator: Answer.operators[:more], value: '-2')
