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
  {label_translations: {"en"=>"First Look: appearence"}, reference: "26", priority: "basic", stage: "consultation", type: "Questions::PhysicalExam", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: 2},
  {label_translations: {"en"=>"refer for malaria testing"}, reference: "6", priority: nil, stage: nil, type: "HealthCares::Management", diagnostic_id: nil, description_translations: {"en"=>""}, min_score: 0, algorithm_id: 3, final_diagnostic_id: nil, answer_type_id: nil},
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
