# Languages (english is basic)
Language.create!(name: 'French', code: 'fr')
Language.create!(name: 'Swahili', code: 'sw')

std = Study.create!(label: 'study label', description_en: 'desc')

# Facilities
group_wavemind = HealthFacility.create!(name: 'Wavemind', architecture: HealthFacility.architectures[:client_server], pin_code: '1234', country: 'Switzerland', area: 'Vaud', main_data_ip: 'http://9f3aac086a16.ngrok.io', local_data_ip: 'http://127.0.0.1', study: std)
standalone = HealthFacility.create!(name: 'Standalone test', architecture: HealthFacility.architectures[:standalone], pin_code: '1234', country: 'Switzerland', area: 'Vaud', main_data_ip: 'http://9f3aac086a16.ngrok.io', study: std)
client_server = HealthFacility.create!(name: 'Client server test', architecture: HealthFacility.architectures[:client_server], pin_code: '1234', country: 'Switzerland', area: 'Vaud', main_data_ip: 'http://9f3aac086a16.ngrok.io', local_data_ip: 'http://127.0.0.1', study: std)

# Role
registration = Role.create!(name: 'Registration', stage: Role.stages[:registration])
triage = Role.create!(name: 'Triage', stage: Role.stages[:triage])
test = Role.create!(name: 'Test', stage: Role.stages[:test])
consultation = Role.create!(name: 'Consultation', stage: Role.stages[:consultation])

# Administration routes
AdministrationRoute.create!(category: 'Enteral', name: 'Orally')
AdministrationRoute.create!(category: 'Enteral', name: 'Sublingually')
AdministrationRoute.create!(category: 'Enteral', name: 'Rectally')
AdministrationRoute.create!(category: 'Parenteral injectable', name: 'IV')
AdministrationRoute.create!(category: 'Parenteral injectable', name: 'IM')
AdministrationRoute.create!(category: 'Parenteral injectable', name: 'SC')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Ocular')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Otic')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Nasally')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Inhalation')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Cutaneous')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Transdermally')

# User
quentin = User.create!(first_name: 'Quentin', last_name: 'Girard', email: 'quentin.girard@wavemind.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:admin])
alain = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:admin])
emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:admin])
julien = User.create!(first_name: 'Julien', last_name: 'Thabard', email: 'julien.thabard@hospvd.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd',  role: User.roles[:admin])
vincent = User.create!(first_name: 'Vincent', last_name: 'Faivre', email: 'vincent.faivre@hospvd.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd',  role: User.roles[:admin])
valerie = User.create!(first_name: 'Valérie', last_name: 'D\'Acremont', email: 'valerie.dacremont@hospvd.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:clinician])
ludovico = User.create!(first_name: 'Ludovico', last_name: 'Cabuccio', email: 'ludovico.cobuccio@chuv.ch', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:clinician])
olga = User.create!(first_name: 'Olga', last_name: 'De Santis', email: 'olga.desantis80@gmail.com', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd', role: User.roles[:clinician])

# Answer types
boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton', answer_required: false)
dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')
formula = AnswerType.create!(value: 'Float', display: 'Formula')
date = AnswerType.create!(value: 'Date', display: 'Input', answer_required: false)
present_absent = AnswerType.create!(value: 'Present', display: 'DropDownList', answer_required: false)
positive_negative = AnswerType.create!(value: 'Positive', display: 'DropDownList', answer_required: false)
string = AnswerType.create!(value: 'String', display: 'Input', answer_required: false)
