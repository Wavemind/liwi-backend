require 'rails_helper'

RSpec.describe Answer, type: :model do

  before(:each) do
    role_administrator = Role.create!(name: 'Administrator')
    alain = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
    algorithm = Algorithm.create!(name: 'ePoct', user: alain)
    answer_type = AnswerType.new(value: 'Array', display: 'Radiobutton')
    category = Category.new(name: 'Symptom', reference_prefix: 'S')
    @question = Question.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], category: category, answer_type: answer_type, algorithm: algorithm)
  end

  it 'is valid with valid attributes' do
    answer = Answer.new(reference: '1', label: 'True', operator: nil, value: 'true', node: @question)
    expect(answer).to be_valid
  end

  it 'is invalid with invalid attributes' do
    answer = Answer.new(reference: nil, label: nil, operator: nil, value: 'true', node: @question)
    expect(answer).to_not be_valid
  end

  it 'is invalid same reference' do
    Answer.create!(reference: '4', label: 'True', operator: nil, value: 'true', node: @question)
    answer = Answer.new(reference: '4', label: '< 6 %', operator: '<', value: 'true', node: @question)

    expect(answer).to_not be_valid
  end
end
