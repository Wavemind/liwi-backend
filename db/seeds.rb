# Languages (english is basic)
Language.create!(name: 'French', code: 'fr')
Language.create!(name: 'Swahili', code: 'sw')

# Group
group_wavemind = Group.create!(name: 'Wavemind', architecture: Group.architectures[:client_server], pin_code: '1234')
standalone = Group.create!(name: 'Standalone test', architecture: Group.architectures[:standalone], pin_code: '1234')
client_server = Group.create!(name: 'Client server test', architecture: Group.architectures[:client_server], pin_code: '1234')

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
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Otic')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Nasally')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Inhalation')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Cutaneous')
AdministrationRoute.create!(category: 'Mucocutaneous', name: 'Transdermally')

# User
quentin = User.create!(first_name: 'Quentin', last_name: 'Girard', email: 'quentin.girard@wavemind.ch', password: '123456', password_confirmation: '123456')
alain = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456')
mickael = User.create!(first_name: 'Mickael', last_name: 'Lacombe', email: 'mickael.lacombe@wavemind.ch', password: '123456', password_confirmation: '123456')
emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456')
julien = User.create!(first_name: 'Julien', last_name: 'Thabard', email: 'julien.thabard@hospvd.ch', password: '123456', password_confirmation: '123456')
vincent = User.create!(first_name: 'Vincent', last_name: 'Faivre', email: 'vincent.faivre@hospvd.ch', password: '123456', password_confirmation: '123456')
valerie = User.create!(first_name: 'Valérie', last_name: 'D\'Acremont', email: 'valerie.dacremont@hospvd.ch', password: '123456', password_confirmation: '123456')
ludovico = User.create!(first_name: 'Ludovico', last_name: 'Cabuccio', email: 'ludovico.cobuccio@chuv.ch', password: '123456', password_confirmation: '123456')
olga = User.create!(first_name: 'Olga', last_name: 'De Santis', email: 'olga.desantis80@gmail.com', password: '123456', password_confirmation: '123456')

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
