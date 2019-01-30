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

algo_1 = "{ algoId: 1, version: 1, name: 'Tropical Diseases', description: 'The best algo of the world', author: 'PMU', questions: { e_1: { id: 'e_1', priority: 'triage', label: 'Age', category: 'exposure', question_type: 'numeric', answers: [ { id: 'e_1_1', label: ' < 6 month', operator: '<', value: 6, }, { id: 'e_1_2', label: ' < 6 month', operator: '<', value: 6, }, { id: 'e_1_3', label: ' < 6 month', operator: '<', value: 6, }, { id: 'e_1_4', label: ' < 6 month', operator: '<', value: 6, }, { id: 'e_1_5', label: ' < 6 month', operator: '<', value: 6, }, ], }, e_2: { id: 'e_2', priority: 'normal', label: 'No Vit A in the past month', category: 'exposure', question_type: 'boolean', answers: [ { e_2_1: { id: 'e_2_1', label: 'Yes', value: true, }, }, { e_2_2: { id: 'e_2_2', label: 'No', value: false, }, }, ], }, p_3: { id: 'p_3', priority: 'triage', label: 'respiratory rate (RR)', category: 'physicalExam', question_type: 'numeric', answers: [ { id: 'p_3_1', label: ' >= 70th%ile', operator: ['>=', '<'], value: [70, 97], }, { id: 'p_3_2', label: '>= 97th%ile', operator: '>=', value: 97, }, { id: 'p_3_3', label: '< 70th%ile', operator: '70', value: 70, }, ], }, p_4: { id: 'p_3', priority: 'triage', label: 'Axillary temperature', category: 'physicalExam', question_type: 'numeric', answers: [ { id: 'p_4_1', label: ' > 37.5°C', operator: ['>'], value: [37.5], }, ], }, p_10: { id: 'p_10', priority: 'normal', label: 'Blotchy rash', category: 'physicalExam', question_type: 'boolean', answers: [ { id: 'p_10_1', label: 'True', value: true, }, { id: 'p_10_2', label: 'False', value: false, }, ], }, p_11: { id: 'p_10', priority: 'normal', label: 'Red, watery eyes', category: 'physicalExam', question_type: 'boolean', answers: [ { id: 'p_11_1', label: 'True', value: true, }, { id: 'p_11_2', label: 'False', value: false, }, ], }, p_12: { id: 'p_10', priority: 'normal', label: 'Koplik spots', category: 'physicalExam', question_type: 'boolean', answers: [ { id: 'p_12_1', label: 'True', value: true, }, { id: 'p_12_2', label: 'False', value: false, }, ], }, s_1: { id: 's_1', priority: 'priority', label: 'History of fever', category: 'symptoms', question_type: 'boolean', answers: [ { id: 's_1_1', label: 'True', value: true, }, { id: 's_1_2', label: 'False', value: false, }, ], }, s_2: { id: 's_2', priority: 'priority', label: 'Caugh', category: 'symptoms', question_type: 'boolean', answers: [ { id: 's_2_1', label: 'True', value: true, }, { id: 's_2_2', label: 'False', value: false, }, ], }, }, predifinedSyndroms: { ps_1: { id: 'ps_1', label: 'Fever', nodes: { s_1: { id: 's_1', conditions: null, children: ['ps_1'], }, p_4: { id: 'p_3', conditions: null, children: ['ps_1'], }, }, result: { conditions: { ids: ['s_1_1', 'p_4_1'], operator: ['OR'], }, }, }, c_1: { id: 'c_1', label: 'Severe condition', nodes: { dc_1: { id: 's_1', conditions: null, children: ['c_1'], }, dc_3: { id: 's_1', conditions: null, children: ['c_1'], }, dc_4: { id: 's_1', conditions: null, children: ['c_1'], }, dc_5: { id: 's_1', conditions: null, children: ['c_1'], }, dc_6: { id: 's_1', conditions: null, children: ['c_1'], }, dc_7: { id: 's_1', conditions: null, children: ['c_1'], }, ps_6_2: { id: 's_1', conditions: null, children: ['c_1'], }, ps_2: { id: 's_1', conditions: null, children: ['c_1'], }, }, result: { conditions: { ids: ['dc_1', 'dc_3', 'dc_4', 'dc_5', 'dc_6', 'dc_7', 'ps_6', 'ps_2'], operator: ['OR', 'OR', 'OR', 'OR', 'OR', 'OR', 'OR'], }, }, }, ps_3: { id: 'ps_3', label: 'Signs of maesles', nodes: { p_10: { id: 'p_10', conditions: null, children: ['ps_1'], }, p_12: { id: 'p_12', conditions: null, children: ['ps_3'], }, p_11: { id: 'p_11', conditions: null, children: ['ps_3'], }, }, result: { conditions: { ids: ['p_10_1', 'p_11_1', 'p_12_1'], operator: ['OR', 'OR'], }, }, }, ps_4: { id: 'ps_4', label: 'Signs of severe measles', nodes: { s_2: { id: 's_2', conditions: null, children: ['p_3', 'p_16'], }, p_3: { id: 'p_3', conditions: { nodes: [ { id: 's_2', expected: 's_2_1', }, ], operator: null, }, children: ['ps_4'], }, p_15: { id: 'p_15', conditions: null, children: ['ps_4'], }, p_16: { id: 'p_16', conditions: { nodes: [ { id: 's_2', expected: 's_2_1', }, ], operator: null, }, children: ['ps_4'], }, p_17: { id: 'p_15', conditions: null, children: ['ps_4'], }, }, result: { conditions: { ids: ['p_3_1', 'p_15_1', 'p_16_1', 'p_17_1'], operator: ['OR', 'OR', 'OR'], }, }, }, }, diseases: { df_1: { id: 'df_1', name: 'Measles', differential: null, nodes: { e_1: { id: 'e_1', conditions: null, children: ['ps_1'] }, ps_1: { id: 'ps_1', conditions: { nodes: [ { id: 'e_1', expected: 'e_1_4', }, ], operator: null, }, children: ['ps_3'], }, ps_3: { id: 'ps_3', conditions: { nodes: [ { id: 'ps_1', expected: true, }, ], operator: null, }, children: ['ps_4', 'df_1', 'c_1'], }, ps_4: { id: 'ps_4', conditions: { nodes: [ { id: 'ps_3', expected: true, }, ], operator: null, }, children: ['df_2'], }, c_1: { id: 'c_1', conditions: { nodes: [ { id: 'ps_3', expected: true, }, ], operator: null, }, children: ['df_2'], }, diagnosis: { df_1: { name: 'Non-severe measles', treatments: [ { t_8: { id: 't_8', conditions: null, operator: null, }, t_11: { id: 't_11', conditions: null, operator: null, }, t_12: { id: 't_12', conditions: ['e_1_3', 'e_2'], operator: ['AND'], }, }, ], managements: [ { t_8: { id: 't_8', conditions: null, operator: null, }, }, ], conditions: { id: [ { id: 'ps_3', expected: true, }, ], operator: null, }, excluding_diagnosis: ['df_2'], }, df_2: { name: 'Severe measles', treatments: [ { t_1_2: { id: 't_1_2', conditions: ['ps_6_1'], operator: null, }, t_1_3: { id: 't_1_3', conditions: ['ps_6_2'], operator: null, }, t_5: { id: 't_5', conditions: null, operator: null, }, t_12: { id: 't_12', conditions: ['e_1_3', 'e_2'], operator: ['AND'], }, }, ], managements: null, conditions: { id: [ { id: 'ps_4', expected: true, }, { id: 'c_1', expected: true, }, ], operator: ['OR'], }, }, }, }, }, }, }"

epoc_first = AlgorithmVersion.create!(version: 'first_trial', json: algo_1, algorithm: epoct, user: alain)
ft_1_0 = AlgorithmVersion.create!(version: '1.0', json: algo_1, algorithm: fever_travel, user: mickael)
ft_1_2 = AlgorithmVersion.create!(version: '1.2', json: algo_1, algorithm: fever_travel, user: vincent)

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
age = Question.create!(answer_type: input_integer, label: 'Quel est l' 'âge du patient ?', reference: '1', category: exposure, priority: Question.priorities[:triage])
convulsion = Question.create!(answer_type: input_integer, label: 'How many time did you convulse', reference: '3', category: symptom, priority: Question.priorities[:priority])
drinking_status = Question.create!(answer_type: radio, label: 'Is the patient able to tolerate PO liquid ?', reference: '4', category: symptom, priority: Question.priorities[:priority])
emesis = Question.create!(answer_type: input_integer, label: 'How many time did you loose stool or emesis last 24 hours ?', reference: '5', category: symptom, priority: Question.priorities[:priority])
muac = Question.create!(answer_type: input_float, label: 'What is MUAC size ?', reference: '6', category: physical_exam, priority: Question.priorities[:triage])
skin_lesion_size = Question.create!(answer_type: input_float, label: 'What is the size of the skin lesion ?', reference: '21', category: physical_exam, priority: Question.priorities[:basic])

# Answers
Answer.create!(question: age, reference: '1', label: 'more than 12 months', value: '12', operator: '>=')
Answer.create!(question: age, reference: '2', label: 'between 6 and 12 months', value: '6, 12', operator: '>=, <')
Answer.create!(question: age, reference: '3', label: 'between 2 and 6 months', value: '2, 6', operator: '>=, <')
Answer.create!(question: age, reference: '4', label: 'less than 2 months', value: '2', operator: '<')
Answer.create!(question: convulsion, reference: '1', label: '2 or more', value: '2', operator: '>=')
Answer.create!(question: convulsion, reference: '2', label: 'less than 2', value: '2', operator: '<')
Answer.create!(question: drinking_status, reference: '1', label: 'yes', value: nil, operator: nil)
Answer.create!(question: drinking_status, reference: '2', label: 'no', value: nil, operator: nil)
Answer.create!(question: emesis, reference: '1', label: '3 or more', value: '3', operator: '>=')
Answer.create!(question: emesis, reference: '2', label: 'less than 3', value: '3', operator: '<')
Answer.create!(question: muac, reference: '1', label: '12.5 or more', value: '12.5', operator: '>=')
Answer.create!(question: muac, reference: '2', label: 'between 11.5 and 12.5', value: '11.5, 12.5', operator: '>=, <')
Answer.create!(question: muac, reference: '3', label: 'less than 11.5', value: '11.5', operator: '<')
Answer.create!(question: skin_lesion_size, reference: '1', label: '5 or more cm', value: '5', operator: '>=')
Answer.create!(question: skin_lesion_size, reference: '2', label: 'between 2.5 and 5 cm', value: '2.5, 5', operator: '>=, <')
Answer.create!(question: skin_lesion_size, reference: '3', label: 'less than 2.5 cm', value: '2.5', operator: '<')

# Diagnostics
malaria = Diagnostic.new(label: 'Malaria', reference: '4')
impetigo = Diagnostic.new(label: 'IMPETIGO', reference: '7')
chicken_pox = Diagnostic.new(label: 'Chicken pox', reference: '8')

# Treatments
paracetamol = Treatment.create!(reference: '4', label: 'Take 400mg of paracetamol')
cephalexin = Treatment.create!(reference: '5', label: 'Take 100mg of cephalexin')
vit_a = Treatment.create!(reference: '6', label: 'Take 40mg of vitamin A')

# Managements
wheelchair = Management.create!(reference: '5', label: 'Use a wheelchair for 2 months.')
crutch = Management.create!(reference: '6', label: 'Use crutch for 2 months.')

malaria.algorithm_versions << epoc_first
impetigo.algorithm_versions << ft_1_0
chicken_pox.algorithm_versions << ft_1_2

# Available questions
epoct.nodes << age
epoct.nodes << muac
epoct.nodes << skin_lesion_size
fever_travel.nodes << age
fever_travel.nodes << convulsion
fever_travel.nodes << drinking_status
fever_travel.nodes << emesis

# Available health cares
epoct.nodes << paracetamol
epoct.nodes << vit_a
epoct.nodes << crutch
epoct.nodes << cephalexin
fever_travel.nodes << crutch
fever_travel.nodes << cephalexin
fever_travel.nodes << wheelchair

malaria.save
impetigo.save
chicken_pox.save
