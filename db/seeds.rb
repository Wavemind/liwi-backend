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

epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)
ft_1_0 = Version.create!(name: '1.0', algorithm: fever_travel, user: mickael)
ft_1_2 = Version.create!(name: '1.2', algorithm: fever_travel, user: vincent)

# Answer types
radio = AnswerType.create!(value: 'Array', display: 'Radiobutton')
checkbox = AnswerType.create!(value: 'Array', display: 'Checkbox')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')

# Categories
exposure = Category.create!(name: 'Exposure', reference_prefix: 'E')
symptom = Category.create!(name: 'Symptom', reference_prefix: 'S')
assessement_text = Category.create!(name: 'Assessment/Test', reference_prefix: 'A')
physical_exam = Category.create!(name: 'Physical exam', reference_prefix: 'P')
comorbidity = Category.create!(name: 'Comorbidity', reference_prefix: 'DC')


# Questions
age = Question.create!(algorithm: epoct, answer_type: input_integer, label: 'Quel est l' 'âge du patient ?', reference: '1', category: exposure, priority: Question.priorities[:triage])
convulsion = Question.create!(algorithm: epoct, answer_type: input_integer, label: 'How many time did you convulse', reference: '3', category: symptom, priority: Question.priorities[:priority])
drinking_status = Question.create!(algorithm: epoct, answer_type: radio, label: 'Is the patient able to tolerate PO liquid ?', reference: '45', category: symptom, priority: Question.priorities[:priority])
emesis = Question.create!(algorithm: epoct, answer_type: input_integer, label: 'How many time did you loose stool or emesis last 24 hours ?', reference: '5', category: symptom, priority: Question.priorities[:priority])
muac = Question.create!(algorithm: epoct, answer_type: input_float, label: 'What is MUAC size ?', reference: '6', category: physical_exam, priority: Question.priorities[:triage])
skin_lesion_size = Question.create!(algorithm: epoct, answer_type: input_float, label: 'What is the size of the skin lesion ?', reference: '21', category: physical_exam, priority: Question.priorities[:basic])

# Answers
Answer.create!(node: age, reference: '1', label: 'more than 12 months', value: '12', operator: '>=')
Answer.create!(node: age, reference: '2', label: 'between 6 and 12 months', value: '6, 12', operator: '>=, <')
Answer.create!(node: age, reference: '3', label: 'between 2 and 6 months', value: '2, 6', operator: '>=, <')
Answer.create!(node: age, reference: '4', label: 'less than 2 months', value: '2', operator: '<')
Answer.create!(node: convulsion, reference: '1', label: '2 or more', value: '2', operator: '>=')
Answer.create!(node: convulsion, reference: '2', label: 'less than 2', value: '2', operator: '<')
Answer.create!(node: drinking_status, reference: '1', label: 'yes', value: nil, operator: nil)
Answer.create!(node: drinking_status, reference: '2', label: 'no', value: nil, operator: nil)
Answer.create!(node: emesis, reference: '1', label: '3 or more', value: '3', operator: '>=')
Answer.create!(node: emesis, reference: '2', label: 'less than 3', value: '3', operator: '<')
Answer.create!(node: muac, reference: '1', label: '12.5 or more', value: '12.5', operator: '>=')
Answer.create!(node: muac, reference: '2', label: 'between 11.5 and 12.5', value: '11.5, 12.5', operator: '>=, <')
Answer.create!(node: muac, reference: '3', label: 'less than 11.5', value: '11.5', operator: '<')
Answer.create!(node: skin_lesion_size, reference: '1', label: '5 or more cm', value: '5', operator: '>=')
Answer.create!(node: skin_lesion_size, reference: '2', label: 'between 2.5 and 5 cm', value: '2.5, 5', operator: '>=, <')
Answer.create!(node: skin_lesion_size, reference: '3', label: 'less than 2.5 cm', value: '2.5', operator: '<')

# Diagnostics
Diagnostic.create!(version: ft_1_0, label: 'Malaria', reference: '4')
Diagnostic.create!(version: ft_1_0, label: 'IMPETIGO', reference: '6')
Diagnostic.create!(version: ft_1_2, label: 'Chicken pox', reference: '8')

# Treatments
Treatment.create!(algorithm: epoct, reference: '4', label: 'Take 400mg of paracetamol')
Treatment.create!(algorithm: epoct, reference: '5', label: 'Take 100mg of cephalexin')
Treatment.create!(algorithm: epoct, reference: '6', label: 'Take 40mg of vitamin A')

# Managements
Management.create!(algorithm: epoct, reference: '5', label: 'Use a wheelchair for 2 months.')
Management.create!(algorithm: epoct, reference: '6', label: 'Use crutch for 2 months.')

# Patients
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

#################################################################################################

dd7 = Diagnostic.create!(version: epoc_first, label: 'Severe LRTI', reference: '7')
df7 = FinalDiagnostic.create!(label: 'Severe lower respiratory tract infection', reference: '7', diagnostic: dd7)

# Assign version to group
group_wavemind.versions << epoc_first
group_wavemind.save

s2 = Question.create!(algorithm: epoct, label: 'Cough', reference: '2', category: symptom, priority: Question.priorities[:priority], answer_type: radio)
s2_1 = Answer.create!(node: s2, reference: '1', label: 'yes', value: nil, operator: nil)
s2_2 = Answer.create!(node: s2, reference: '2', label: 'no', value: nil, operator: nil)

s4 = Question.create!(algorithm: epoct, label: 'Drink as usual', reference: '4', category: symptom, priority: Question.priorities[:priority], answer_type: radio)
s4_1 = Answer.create!(node: s4, reference: '1', label: 'yes', value: nil, operator: nil)
s4_2 = Answer.create!(node: s4, reference: '2', label: 'no', value: nil, operator: nil)

p1 = Question.create!(algorithm: epoct, label: 'SAO2', reference: '1', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
p1_1 = Answer.create!(node: p1, reference: '1', label: '>/= 90%', value: '90', operator: '>=')
p1_1 = Answer.create!(node: p1, reference: '2', label: '< 90%', value: '90', operator: '<')

p3 = Question.create!(algorithm: epoct, label: 'Respiratory rate', reference: '3', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
p3_1 = Answer.create!(node: p3, reference: '1', label: '< 97th%ile', value: '97', operator: '<')
p3_2 = Answer.create!(node: p3, reference: '2', label: '>/= 97th%ile', value: '97', operator: '>=')

p13 = Question.create!(algorithm: epoct, label: 'Lower chest indrawing', reference: '13', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
p13_1 = Answer.create!(node: p13, reference: '1', label: 'yes', value: nil, operator: nil)
p13_2 = Answer.create!(node: p13, reference: '2', label: 'no', value: nil, operator: nil)


p14 = Question.create!(algorithm: epoct, label: 'Sever respiratory distress', reference: '14', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
p14_1 = Answer.create!(node: p14, reference: '1', label: 'yes', value: nil, operator: nil)
p14_1 = Answer.create!(node: p14, reference: '2', label: 'no', value: nil, operator: nil)

p25 = Question.create!(algorithm: epoct, label: 'Tolerates PO liquid', reference: '25', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
p25_1 = Answer.create!(node: p25, reference: '1', label: 'yes', value: nil, operator: nil)
p25_2 = Answer.create!(node: p25, reference: '2', label: 'no', value: nil, operator: nil)

t1 = Treatment.create!(algorithm: epoct, label: 'Amoxicillin', reference: '1')
t2 = Treatment.create!(algorithm: epoct, label: 'IM ceftriaxone', reference: '2')
t9 = Treatment.create!(algorithm: epoct, label: 'Oral rehydration', reference: '9')

m2 = Management.create!(algorithm: epoct, label: 'Refer', reference: '2')

df7.nodes << [t1,t2,t9, m2]

ps6 = PredefinedSyndrome.create!(algorithm: epoct, reference: '6', label: 'Able to drink')
ps6_1 = ps6.answers.first
ps6_2 = ps6.answers.second

# DF7
dd7_s2 = Instance.create!(instanceable: dd7, node: s2)
dd7_p3 = Instance.create!(instanceable: dd7, node: p3)
dd7_p13 = Instance.create!(instanceable: dd7, node: p13)
dd7_p14 = Instance.create!(instanceable: dd7, node: p14)
dd7_p1 = Instance.create!(instanceable: dd7, node: p1)
dd7_df7 = Instance.create!(instanceable: dd7, node: df7)
dd7_ps6 = Instance.create!(instanceable: dd7, node: ps6)
dd7_t9 = Instance.create!(instanceable: dd7, node: t9)
dd7_t1 = Instance.create!(instanceable: dd7, node: t1)
dd7_t2 = Instance.create!(instanceable: dd7, node: t2)
dd7_m2 = Instance.create!(instanceable: dd7, node: m2)

# PS6
ps6_s4 = Instance.create!(instanceable: ps6, node: s4)
ps6_p25 = Instance.create!(instanceable: ps6, node: p25)
ps6_ps6 = Instance.create!(instanceable: ps6, node: ps6)


Child.create!(instance: ps6_s4, node: ps6)
Child.create!(instance: ps6_s4, node: p25)
Child.create!(instance: ps6_p25, node: ps6)

Child.create!(instance: dd7_s2, node: p14)
Child.create!(instance: dd7_s2, node: p13)
Child.create!(instance: dd7_s2, node: p1)
Child.create!(instance: dd7_s2, node: p3)

Child.create!(instance: dd7_p14, node: df7)
Child.create!(instance: dd7_p1, node: df7)
Child.create!(instance: dd7_p3, node: df7)
Child.create!(instance: dd7_p13, node: df7)

Child.create!(instance: dd7_df7, node: ps6)

Child.create!(instance: dd7_ps6, node: t9)
Child.create!(instance: dd7_ps6, node: t1)
Child.create!(instance: dd7_ps6, node: t2)


Condition.create!(referenceable: ps6_p25, first_conditionable: s4_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: s4_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: p25_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_p1, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p3, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p13, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p14, first_conditionable: s2_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_df7, first_conditionable: p14_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_df7, first_conditionable: p3_2, operator: 'AND', second_conditionable: p13_1)
Condition.create!(referenceable: dd7_df7, first_conditionable: p1_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_ps6, first_conditionable: df7, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_t9, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_t1, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_t2, first_conditionable: ps6_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_m2, first_conditionable: ps6_2, operator: nil, second_conditionable: ps6_1)
