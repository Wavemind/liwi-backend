# Languages (english is basic)
Language.create!(name: 'French', code: 'fr')
Language.create!(name: 'Swahili', code: 'sw')

# Group
group_wavemind = Group.create!(name: 'Wavemind')
group_pmu = Group.create!(name: 'PMU')

# Role
role_administrator = Role.create!(name: 'Administrator')
role_student = Role.create!(name: 'Student')
role_teacher = Role.create!(name: 'Teacher')

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

# Answer types
boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
input_float = AnswerType.create!(value: 'Float', display: 'Input')
formula = AnswerType.create!(value: 'Float', display: 'Formula')
date = AnswerType.create!(value: 'Date', display: 'Input')
string = AnswerType.create!(value: 'String', display: 'Input')
