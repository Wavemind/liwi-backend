require 'rails_helper'

RSpec.describe Question, type: :model do
  create_algorithm

  before(:each) do
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
