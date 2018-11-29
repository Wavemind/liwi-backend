require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@ilovetestunit.com', password: '123456', password_confirmation: '123456', role: role)
    expect(user).to be_valid
  end

  it 'is invalid with invalid attributes' do
    user = User.new(first_name: nil, last_name: 'Bar')
    expect(user).to_not be_valid
  end

  it 'is invalid with invalid email' do
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo@ilovetestuni,coooommmm', password: '123456', password_confirmation: '123456')
    expect(user).to_not be_valid
  end
end
