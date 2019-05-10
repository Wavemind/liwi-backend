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

epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)
ft_1_0 = Version.create!(name: '1.0', algorithm: fever_travel, user: mickael)
ft_1_2 = Version.create!(name: '1.2', algorithm: fever_travel, user: vincent)

# Answer types
boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
checkbox = AnswerType.create!(value: 'Array', display: 'Checkbox')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')

# Categories
exposure = Category.create!(name_en: 'Exposure', reference_prefix: 'E', parent: 'Question')
symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S', parent: 'Question')
assessment_test = Category.create!(name_en: 'Assessment/Test', reference_prefix: 'A', parent: 'Question')
physical_exam = Category.create!(name_en: 'Physical exam', reference_prefix: 'P', parent: 'Question')

predefined_syndrome = Category.create!(name_en: 'Predefined syndrome', reference_prefix: 'PS', parent: 'PredefinedSyndrome')
comorbidity = Category.create!(name_en: 'Comorbidity', reference_prefix: 'DC', parent: 'PredefinedSyndrome')
predefined_condition = Category.create!(name_en: 'Predefined condition', reference_prefix: 'C', parent: 'PredefinedSyndrome')


# Questions
e1 = Question.create!(algorithm: epoct, answer_type: input_integer, label_en: 'Age', reference: '1', category: exposure, priority: Question.priorities[:triage])
s3 = Question.create!(algorithm: epoct, answer_type: input_integer, label_en: 'Convulsions in current illness', reference: '3', category: symptom, priority: Question.priorities[:mandatory])
s45 = Question.create!(algorithm: epoct, answer_type: boolean, label_en: 'Is the patient able to tolerate PO liquid ?', reference: '45', category: symptom, priority: Question.priorities[:mandatory])
p6 = Question.create!(algorithm: epoct, answer_type: input_float, label_en: 'What is MUAC size ?', reference: '6', category: physical_exam, priority: Question.priorities[:triage])
p21 = Question.create!(algorithm: epoct, answer_type: input_float, label_en: 'What is the size of the skin lesion ?', reference: '21', category: physical_exam, priority: Question.priorities[:basic])

# Answers
e1_1 = Answer.create!(node: e1, reference: '1', label_en: 'less than 2 months', value: '2', operator: Answer.operators[:less])
e1_2 = Answer.create!(node: e1, reference: '2', label_en: 'between 2 and 6 months', value: '2, 6', operator: Answer.operators[:between])
e1_3 = Answer.create!(node: e1, reference: '3', label_en: 'between 6 and 12 months', value: '6, 12', operator: Answer.operators[:between])
e1_4 = Answer.create!(node: e1, reference: '4', label_en: 'more than 12 months', value: '12', operator: Answer.operators[:more_or_equal])
s3_1 = Answer.create!(node: s3, reference: '1', label_en: '2 or more', value: '2', operator: Answer.operators[:more_or_equal])
s3_2 = Answer.create!(node: s3, reference: '2', label_en: 'less than 2', value: '2', operator: Answer.operators[:less])
p6_1 = Answer.create!(node: p6, reference: '1', label_en: 'less than 11.5', value: '11.5', operator: Answer.operators[:less])
p6_2 = Answer.create!(node: p6, reference: '2', label_en: 'between 11.5 and 12.5', value: '11.5, 12.5', operator: Answer.operators[:between])
p6_3 = Answer.create!(node: p6, reference: '3', label_en: '12.5 or more', value: '12.5', operator: Answer.operators[:more_or_equal])
p21_1 = Answer.create!(node: p21, reference: '1', label_en: '5 or more cm', value: '5', operator: Answer.operators[:more_or_equal])
p21_2 = Answer.create!(node: p21, reference: '2', label_en: 'between 2.5 and 5 cm', value: '2.5, 5', operator: Answer.operators[:between])
p21_3 = Answer.create!(node: p21, reference: '3', label_en: 'less than 2.5 cm', value: '2.5', operator: Answer.operators[:less])

# Diagnostics
Diagnostic.create!(version: ft_1_0, label_en: 'Malaria', reference: '4')
Diagnostic.create!(version: ft_1_0, label_en: 'IMPETIGO', reference: '6')
Diagnostic.create!(version: ft_1_2, label_en: 'Chicken pox', reference: '8')

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

# Assign version to group
group_wavemind.versions << epoc_first
group_wavemind.save

#################################################################################################
########################################## DD7 ##################################################
#################################################################################################

dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', reference: '7', diagnostic: dd7)

s2 = Question.create!(algorithm: epoct, label_en: 'Cough', reference: '2', category: symptom, priority: Question.priorities[:mandatory], answer_type: boolean)
s2_1 = s2.answers.first

s4 = Question.create!(algorithm: epoct, label_en: 'Drink as usual', reference: '4', category: symptom, priority: Question.priorities[:mandatory], answer_type: boolean)
s4_1 = s4.answers.first
s4_2 = s4.answers.second

p1 = Question.create!(algorithm: epoct, label_en: 'SAO2', reference: '1', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
p1_1 = Answer.create!(node: p1, reference: '1', label_en: '>/= 90%', value: '90', operator: Answer.operators[:more_or_equal])
p1_2 = Answer.create!(node: p1, reference: '2', label_en: '< 90%', value: '90', operator: Answer.operators[:less])

p3 = Question.create!(algorithm: epoct, label_en: 'Respiratory rate', reference: '3', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
p3_1 = Answer.create!(node: p3, reference: '1', label_en: '< 97th%ile', value: '97', operator: Answer.operators[:less])
p3_2 = Answer.create!(node: p3, reference: '2', label_en: '>/= 97th%ile', value: '97', operator: Answer.operators[:more_or_equal])

p13 = Question.create!(algorithm: epoct, label_en: 'Lower chest indrawing', reference: '13', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
p13_1 = p13.answers.first

p14 = Question.create!(algorithm: epoct, label_en: 'Sever respiratory distress', reference: '14', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
p14_1 = p14.answers.first

p25 = Question.create!(algorithm: epoct, label_en: 'Tolerates PO liquid', reference: '25', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
p25_1 = p25.answers.first

t1 = Treatment.create!(algorithm: epoct, label_en: 'Amoxicillin', reference: '1')
t2 = Treatment.create!(algorithm: epoct, label_en: 'IM ceftriaxone', reference: '2')
t9 = Treatment.create!(algorithm: epoct, label_en: 'Oral rehydration', reference: '9')

m2 = Management.create!(algorithm: epoct, label_en: 'Refer', reference: '2')

df7.nodes << [t1, t2, t9, m2]

ps6 = PredefinedSyndrome.create!(algorithm: epoct, reference: '6', label_en: 'Able to drink', category: predefined_syndrome)
ps6_1 = ps6.answers.first
ps6_2 = ps6.answers.second

# PS6
ps6_s4 = Instance.create!(instanceable: ps6, node: s4)
ps6_p25 = Instance.create!(instanceable: ps6, node: p25)
ps6_ps6 = Instance.create!(instanceable: ps6, node: ps6)

# DF7
dd7_s2 = Instance.create!(instanceable: dd7, node: s2)
dd7_p3 = Instance.create!(instanceable: dd7, node: p3)
dd7_p13 = Instance.create!(instanceable: dd7, node: p13)
dd7_p14 = Instance.create!(instanceable: dd7, node: p14)
dd7_p1 = Instance.create!(instanceable: dd7, node: p1)
dd7_df7 = Instance.create!(instanceable: dd7, node: df7)
dd7_ps6 = Instance.create!(instanceable: dd7, node: ps6, final_diagnostic: df7)
dd7_t9 = Instance.create!(instanceable: dd7, node: t9, final_diagnostic: df7)
dd7_t1 = Instance.create!(instanceable: dd7, node: t1, final_diagnostic: df7)
dd7_t2 = Instance.create!(instanceable: dd7, node: t2, final_diagnostic: df7)
dd7_m2 = Instance.create!(instanceable: dd7, node: m2, final_diagnostic: df7)

Condition.create!(referenceable: ps6_p25, first_conditionable: s4_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: s4_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps6_ps6, first_conditionable: p25_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_p1, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p3, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p13, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_p14, first_conditionable: s2_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_df7, first_conditionable: p14_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_df7, first_conditionable: p3_2, operator: Condition.operators[:and_operator], second_conditionable: p13_1)
Condition.create!(referenceable: dd7_df7, first_conditionable: p1_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd7_t9, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_t1, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd7_t2, first_conditionable: ps6_2, operator: nil, second_conditionable: nil)

#################################################################################################
########################################## DD5 ##################################################
#################################################################################################

dd5 = Diagnostic.create!(version: epoc_first, label_en: 'Musculo-skeletal infection', reference: '5')
df14 = FinalDiagnostic.create!(label_en: 'Osteomyelitis / septic arthritis', reference: '14', diagnostic: dd5)

p7 = Question.create!(algorithm: epoct, label_en: 'Convulsing now', reference: '7', category: physical_exam, priority: Question.priorities[:triage], answer_type: boolean)
p7_1 = p7.answers.first
p7_2 = p7.answers.second

p8 = Question.create!(algorithm: epoct, label_en: 'Lethargic or unconscious', reference: '8', category: physical_exam, priority: Question.priorities[:triage], answer_type: boolean)
p8_1 = p8.answers.first
p8_2 = p8.answers.second

p2 = Question.create!(algorithm: epoct, label_en: 'Severe tachycardia (th %ile)', reference: '2', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
p2_1 = p2.answers.create!(reference: '1', label_en: 'More than 90', value: '90', operator: Answer.operators[:more_or_equal])
p2_2 = p2.answers.create!(reference: '2', label_en: 'Less than 90', value: '90', operator: Answer.operators[:less])

p9 = Question.create!(algorithm: epoct, label_en: 'Stiff neck', reference: '9', category: physical_exam, priority: Question.priorities[:mandatory], answer_type: boolean)
p9_1 = p9.answers.first
p9_2 = p9.answers.second

s1 = Question.create!(algorithm: epoct, label_en: 'History of fever', reference: '1', category: symptom, priority: Question.priorities[:triage], answer_type: boolean)
s1_1 = s1.answers.first
s1_2 = s1.answers.second

p4 = Question.create!(algorithm: epoct, label_en: 'Axillary temperature', reference: '4', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_float)
p4_1 = p4.answers.create!(reference: '1', label_en: 'More than 37.5', value: '37.5', operator: Answer.operators[:more_or_equal])
p4_2 = p4.answers.create!(reference: '2', label_en: 'Less than 37.5', value: '37.5', operator: Answer.operators[:less])

p5 = Question.create!(algorithm: epoct, label_en: 'Weight for age (z-score)', reference: '5', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_float)
p5_1 = p5.answers.create!(reference: '1', label_en: 'less than -3', value: '-3', operator: Answer.operators[:less])
p5_2 = p5.answers.create!(reference: '2', label_en: 'Between -3 and -2', value: '-3,-2', operator: Answer.operators[:between])
p5_3 = p5.answers.create!(reference: '3', label_en: 'More than -2', value: '-2', operator: Answer.operators[:more_or_equal])

a1 = Question.create!(algorithm: epoct, label_en: 'mRDT', reference: '1', category: assessment_test, priority: Question.priorities[:mandatory], answer_type: dropdown_list)
a1_1 = a1.answers.create!(reference: '1', label_en: 'positive', value: nil, operator: nil)
a1_2 = a1.answers.create!(reference: '2', label_en: 'negative', value: nil, operator: nil)

a2 = Question.create!(algorithm: epoct, label_en: 'SaO2 (%)', reference: '2', category: assessment_test, priority: Question.priorities[:mandatory], answer_type: input_integer)
a2_1 = a2.answers.create!(reference: '1', label_en: 'Less than 6', value: '6', operator: Answer.operators[:less])
a2_2 = a2.answers.create!(reference: '2', label_en: 'More than 6', value: '6', operator: Answer.operators[:more_or_equal])

a3 = Question.create!(algorithm: epoct, label_en: 'CRP (mg/L)', reference: '3', category: assessment_test, priority: Question.priorities[:basic], answer_type: input_float)
a3_1 = a3.answers.create!(reference: '1', label_en: 'Less than 20', value: '20', operator: Answer.operators[:less])
a3_2 = a3.answers.create!(reference: '2', label_en: 'Between 20 and 40', value: '20,40', operator: Answer.operators[:between])
a3_3 = a3.answers.create!(reference: '3', label_en: 'More than 40', value: '40', operator: Answer.operators[:more_or_equal])

a4 = Question.create!(algorithm: epoct, label_en: 'SaO2 (%)', reference: '4', category: assessment_test, priority: Question.priorities[:basic], answer_type: input_float)
a4_1 = a4.answers.create!(reference: '1', label_en: 'Less than 3.3', value: '3.3', operator: Answer.operators[:less])
a4_2 = a4.answers.create!(reference: '2', label_en: 'More than 3.3', value: '3.3', operator: Answer.operators[:more_or_equal])

s8 = Question.create!(algorithm: epoct, label_en: 'Extremity pain', reference: '8', category: symptom, priority: Question.priorities[:mandatory], answer_type: boolean)
s8_1 = s8.answers.first
s8_2 = s8.answers.second

p24 = Question.create!(algorithm: epoct, label_en: 'Joint swelling', reference: '24', category: physical_exam, priority: Question.priorities[:mandatory], answer_type: boolean)
p24_1 = p24.answers.first
p24_2 = p24.answers.second

t4 = Treatment.create!(algorithm: epoct, label_en: 'Cephalexin', reference: '4')

df14.nodes << [t2, t4, m2]

ps1 = PredefinedSyndrome.create!(algorithm: epoct, reference: '1', label_en: 'Fever', category: predefined_syndrome)
ps1_1 = ps1.answers.first

ps2 = PredefinedSyndrome.create!(algorithm: epoct, reference: '2', label_en: 'Danger signs', category: predefined_syndrome)
ps2_1 = ps2.answers.first

dc1 = PredefinedSyndrome.create!(algorithm: epoct, reference: '1', label_en: 'Severe malnutrition', category: comorbidity)
dc1_1 = dc1.answers.first

dc2 = PredefinedSyndrome.create!(algorithm: epoct, reference: '2', label_en: 'Moderate malnutrition', category: comorbidity)
dc2_1 = dc2.answers.first

dc3 = PredefinedSyndrome.create!(algorithm: epoct, reference: '3', label_en: 'Severe anemia', category: comorbidity)
dc3_1 = dc3.answers.first

dc4 = PredefinedSyndrome.create!(algorithm: epoct, reference: '4', label_en: 'Hypoglycemia', category: comorbidity)
dc4_1 = dc4.answers.first

c1 = PredefinedSyndrome.create!(algorithm: epoct, reference: '1', label_en: 'Severe malnutrition', category: predefined_condition)
c1_1 = c1.answers.first


# PS1
ps1_s1 = Instance.create!(instanceable: ps1, node: s1)
ps1_p4 = Instance.create!(instanceable: ps1, node: p4)
ps1_ps1 = Instance.create!(instanceable: ps1, node: ps1)

Condition.create!(referenceable: ps1_ps1, first_conditionable: s1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps1_ps1, first_conditionable: p4_1, operator: nil, second_conditionable: nil)

# PS2
ps2_s3 = Instance.create!(instanceable: ps2, node: s3)
ps2_p7 = Instance.create!(instanceable: ps2, node: p7)
ps2_p8 = Instance.create!(instanceable: ps2, node: p8)
ps2_p9 = Instance.create!(instanceable: ps2, node: p9)
ps2_p1 = Instance.create!(instanceable: ps2, node: p1)
ps2_p2 = Instance.create!(instanceable: ps2, node: p2)
ps2_ps2 = Instance.create!(instanceable: ps2, node: ps2)

Condition.create!(referenceable: ps2_ps2, first_conditionable: s3_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: p7_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: p8_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: p1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: p2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: ps2_ps2, first_conditionable: p9_1, operator: nil, second_conditionable: nil)

# DC1
dc1_e1 = Instance.create!(instanceable: dc1, node: e1)
dc1_p5 = Instance.create!(instanceable: dc1, node: p5)
dc1_p6 = Instance.create!(instanceable: dc1, node: p6)
dc1_dc1 = Instance.create!(instanceable: dc1, node: dc1)

Condition.create!(referenceable: dc1_p6, first_conditionable: e1_3, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc1_dc1, first_conditionable: p5_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc1_dc1, first_conditionable: p6_1, operator: nil, second_conditionable: nil)

# DC2
dc2_e1 = Instance.create!(instanceable: dc2, node: e1)
dc2_p5 = Instance.create!(instanceable: dc2, node: p5)
dc2_p6 = Instance.create!(instanceable: dc2, node: p6)
dc2_dc2 = Instance.create!(instanceable: dc2, node: dc2)

Condition.create!(referenceable: dc2_p6, first_conditionable: e1_3, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc2_dc2, first_conditionable: p5_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dc2_dc2, first_conditionable: p6_2, operator: nil, second_conditionable: nil)

# DC3
dc3_a2 = Instance.create!(instanceable: dc3, node: a2)
dc3_dc3 = Instance.create!(instanceable: dc3, node: dc3)

Condition.create!(referenceable: dc3_dc3, first_conditionable: a2_1, operator: nil, second_conditionable: nil)

# DC4
dc4_a4 = Instance.create!(instanceable: dc4, node: a4)
dc4_dc4 = Instance.create!(instanceable: dc4, node: dc4)

Condition.create!(referenceable: dc4_dc4, first_conditionable: a4_1, operator: nil, second_conditionable: nil)

# C1
c1_ps2 = Instance.create!(instanceable: c1, node: ps2)
c1_ps6 = Instance.create!(instanceable: c1, node: ps6)
c1_dc1 = Instance.create!(instanceable: c1, node: dc1)
c1_dc2 = Instance.create!(instanceable: c1, node: dc2)
c1_dc3 = Instance.create!(instanceable: c1, node: dc3)
c1_dc4 = Instance.create!(instanceable: c1, node: dc4)
c1_c1 = Instance.create!(instanceable: c1, node: c1)

Condition.create!(referenceable: c1_c1, first_conditionable: ps2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: c1_c1, first_conditionable: ps6_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: c1_c1, first_conditionable: dc1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: c1_c1, first_conditionable: dc2_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: c1_c1, first_conditionable: dc3_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: c1_c1, first_conditionable: dc4_1, operator: nil, second_conditionable: nil)

# DF7
dd5_e1 = Instance.create!(instanceable: dd5, node: e1)
dd5_ps1 = Instance.create!(instanceable: dd5, node: ps1)
dd5_s8 = Instance.create!(instanceable: dd5, node: s8)
dd5_p24 = Instance.create!(instanceable: dd5, node: p24)
dd5_a1 = Instance.create!(instanceable: dd5, node: a1)
dd5_a3 = Instance.create!(instanceable: dd5, node: a3)
dd5_df14 = Instance.create!(instanceable: dd5, node: df14)
dd5_c1 = Instance.create!(instanceable: dd5, node: c1, final_diagnostic: df14)
dd5_t2 = Instance.create!(instanceable: dd5, node: t2, final_diagnostic: df14)
dd5_t4 = Instance.create!(instanceable: dd5, node: t4, final_diagnostic: df14)
dd5_m2 = Instance.create!(instanceable: dd5, node: m2, final_diagnostic: df14)

Condition.create!(referenceable: dd5_ps1, first_conditionable: e1_4, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_s8, first_conditionable: ps1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_p24, first_conditionable: ps1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_a1, first_conditionable: s8_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_a1, first_conditionable: p24_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_a3, first_conditionable: a1_2, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_df14, first_conditionable: a3_3, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd5_t2, first_conditionable: c1_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5_m2, first_conditionable: c1_1, operator: nil, second_conditionable: nil)

Condition.create!(referenceable: dd5, first_conditionable: s8_1, operator: nil, second_conditionable: nil)
Condition.create!(referenceable: dd5, first_conditionable: p24_1, operator: nil, second_conditionable: nil)
