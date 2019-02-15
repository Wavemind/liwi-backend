require 'rails_helper'

RSpec.describe Question, type: :model do

  before(:each) do
    role_administrator = Role.create!(name: 'Administrator')
    alain = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
    @algorithm = Algorithm.create!(name: 'ePoct', user: alain)
    @answer_type = AnswerType.new(value: 'Array', display: 'Radiobutton')
    @category = Category.new(name: 'Symptom', reference_prefix: 'S')
  end

  it 'is valid with valid attributes' do
    question = Question.new(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], category: @category, answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to be_valid
  end

  it 'is invalid with invalid attributes' do
    question = Question.new(reference: '4', label: 'skin issue', priority: nil, category: @category, answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to_not be_valid
  end

  it 'is invalid same reference' do
    Question.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], category: @category, answer_type: @answer_type, algorithm: @algorithm)
    question = Question.new(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], category: @category, answer_type: @answer_type, algorithm: @algorithm)

    expect(question).to_not be_valid
  end
end
