# Role
administrator = Role.create!(name: 'Administrator')
student = Role.create!(name: 'Student')
teacher = Role.create!(name: 'Teacher')

# User
User.create!(first_name: 'Quentin', provider: 'email', uid: 'admin.wavemind.ch', last_name: 'Girard', email: 'admin@wavemind.ch', password: '123456', password_confirmation: '123456', role: administrator)
