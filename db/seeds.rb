# Group
group_wavemind = Group.create!(name: 'Wavemind')
group_unicorne = Group.create!(name: 'Unicorne')
group_pmu = Group.create!(name: 'PMU')

# Role
role_administrator = Role.create!(name: 'Administrator')
role_student = Role.create!(name: 'Student')
role_teacher = Role.create!(name: 'Teacher')

# Device
device_blackberry = Device.create!(reference_number: 'GHHJK2234FG566H', model: 'Q10', brand: 'BlackBerry', status: :active, os: 'Android', os_version: '8.0', name: 'MedicalCenter 1')
device_sony_ericsson = Device.create!(reference_number: 'XXDG22345G55HJ', model: '3310', brand: 'Sony Ericsson', status: :active, os: 'Android', os_version: '8.0', name: 'MedicalCenter 2')
device_apple = Device.create!(reference_number: 'JECOUTETROPCHER1400', model: 'Iphone XYZ', brand: 'Apple', status: :active, os: 'Android', os_version: '8.0', name: 'MedicalCenter 3')
device_sagem = Device.create!(reference_number: '1235KSSFF2244FAA', model: 'J302', brand: 'Sagem', status: :active, os: 'Android', os_version: '8.0', name: 'MedicalCenter 4')

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

# Associate group
group_wavemind.users << [quentin, alain, mickael, emmanuel]
group_wavemind.save

group_pmu.users << [julien, vincent, valerie, ludovico, olga]
group_pmu.save

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
Activity.create!(user: olga, device: device_blackberry, latitude: -33.918861, longitude: 18.423300, created_at: Time.zone.now + 6.hour, updated_at: Time.zone.now + 6.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: valerie, device: device_blackberry, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 6.hour, updated_at: Time.zone.now + 6.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: vincent, device: device_blackberry, latitude: -26.958405, longitude: 27.901464, created_at: Time.zone.now + 7.hour, updated_at: Time.zone.now + 7.hour, timezone: 'Berne', version: '1.0.0')
Activity.create!(user: quentin, device: device_blackberry, latitude: -33.918861, longitude: 28.015680, created_at: Time.zone.now + 8.hour, updated_at: Time.zone.now + 8.hour, timezone: 'Berne', version: '1.0.0')

# Algorithms
epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: emmanuel)
fever_travel = Algorithm.create!(name: 'FeverTravel', description: 'loremp ipsum', user: quentin)

epoc_first = AlgorithmVersion.create!(version: 'first_trial', json: '{}', algorithm: epoct, user: alain)
ft_1_0 = AlgorithmVersion.create!(version: '1.0', json: '{}', algorithm: fever_travel, user: mickael)
ft_1_2 = AlgorithmVersion.create!(version: '1.2', json: '{}', algorithm: fever_travel, user: vincent)

# Answer types
radio = AnswerType.create!(value: 'Array', display: 'Radiobutton')
checkbox = AnswerType.create!(value: 'Array', display: 'Checkbox')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')

# Questions
age = Question.create!(answer_type: input_integer, label: 'Quel est l''âge du patient ?', reference: 'E1', category: Question.categories[:exposure], priority: Question.priorities[:triage])
convulsion = Question.create!(answer_type: input_integer, label: 'How many time did you convulse', reference: 'S3', category: Question.categories[:symptom], priority: Question.priorities[:priority])
drinking_status = Question.create!(answer_type: radio, label: 'Is the patient able to tolerate PO liquid ?', reference: 'S4', category: Question.categories[:symptom], priority: Question.priorities[:priority])
emesis = Question.create!(answer_type: input_integer, label: 'How many time did you loose stool or emesis last 24 hours ?', reference: 'S5', category: Question.categories[:symptom], priority: Question.priorities[:priority])
muac = Question.create!(answer_type: input_float, label: 'What is MUAC size ?', reference: 'P6', category: Question.categories[:physical_exam], priority: Question.priorities[:triage])
skin_lesion_size = Question.create!(answer_type: input_float, label: 'What is the size of the skin lesion ?', reference: 'P21', category: Question.categories[:physical_exam], priority: Question.priorities[:basic])

# Answers
Answer.create!(question: age, reference: 'E_1_1', label: nil, value: '12', operator: '>=')
Answer.create!(question: age, reference: 'E_1_2', label: nil, value: '6, 12', operator: '>=, <')
Answer.create!(question: age, reference: 'E_1_3', label: nil, value: '2, 6', operator: '>=, <')
Answer.create!(question: age, reference: 'E_1_4', label: nil, value: '2', operator: '<')
Answer.create!(question: convulsion, reference: 'S_3_1', label: nil, value: '2', operator: '>=')
Answer.create!(question: convulsion, reference: 'S_3_2', label: nil, value: '2', operator: '<')
Answer.create!(question: drinking_status, reference: 'S_4_1', label: 'yes', value: nil, operator: nil)
Answer.create!(question: drinking_status, reference: 'S_4_2', label: 'no', value: nil, operator: nil)
Answer.create!(question: emesis, reference: 'S_5_1', label: nil, value: '3', operator: '>=')
Answer.create!(question: emesis, reference: 'S_5_2', label: nil, value: '3', operator: '<')
Answer.create!(question: muac, reference: 'P_6_1', label: nil, value: '12.5', operator: '>=')
Answer.create!(question: muac, reference: 'P_6_2', label: nil, value: '11.5, 12.5', operator: '>=, <')
Answer.create!(question: muac, reference: 'P_6_3', label: nil, value: '11.5', operator: '<')
Answer.create!(question: skin_lesion_size, reference: 'P_2_1_1', label: nil, value: '5', operator: '>=')
Answer.create!(question: skin_lesion_size, reference: 'P_2_1_2', label: nil, value: '2.5, 5', operator: '>=, <')
Answer.create!(question: skin_lesion_size, reference: 'P_2_1_3', label: nil, value: '2.5', operator: '<')

# Available questions per algorithm
AvailableQuestion.create!(algorithm: epoct, question: age)
AvailableQuestion.create!(algorithm: epoct, question: muac)
AvailableQuestion.create!(algorithm: epoct, question: skin_lesion_size)
AvailableQuestion.create!(algorithm: fever_travel, question: age)
AvailableQuestion.create!(algorithm: fever_travel, question: convulsion)
AvailableQuestion.create!(algorithm: fever_travel, question: drinking_status)
AvailableQuestion.create!(algorithm: fever_travel, question: emesis)

# Diagnostics
malaria = Diagnostic.new(label: 'Malaria', reference: 'DD_4')
impetigo = Diagnostic.new(label: 'IMPETIGO', reference: 'DD_7')
chicken_pox = Diagnostic.new(label: 'Chicken pox', reference: 'DD_8')

malaria.algorithm_versions << epoc_first
impetigo.algorithm_versions << ft_1_0
chicken_pox.algorithm_versions << ft_1_2

malaria.save
impetigo.save
chicken_pox.save
