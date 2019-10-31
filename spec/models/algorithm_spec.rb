require 'rails_helper'

RSpec.describe Algorithm, type: :model do
  create_answer_type

  before(:each) do
    role = Role.new(name: 'administrator')
    @user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
  end

  it 'is valid with valid attributes' do
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: @user)
    expect(algorithm).to be_valid
  end

  it 'is invalid with invalid attributes' do
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1')
    expect(algorithm).to_not be_valid
  end
end
