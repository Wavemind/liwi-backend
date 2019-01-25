require 'rails_helper'

RSpec.describe Question, type: :model do

  before(:each) do
    @answer_type = AnswerType.new(value: 'boolean', display: 'radio')
  end

  it 'is valid with valid attributes' do
    question = Question.new(reference: 's_9', label: 'skin issue', priority: Question.priorities[:basic], category: Question.categories[:symptom], answer_type: @answer_type)
    expect(question).to be_valid
  end

  it 'is invalid with invalid attributes' do
    question = Question.new(reference: 's_4', label: 'skin issue', priority: nil, category: nil, answer_type: @answer_type)
    expect(question).to_not be_valid
  end

  it 'is invalid same reference' do
    question_1 = Question.create!(reference: 's_9', label: 'skin issue', priority: Question.priorities[:basic], category: Question.categories[:symptom], answer_type: @answer_type)

    question = Question.new(reference: 's_9', label: 'skin issue', priority: Question.priorities[:basic], category: Question.categories[:symptom], answer_type: @answer_type)
    expect(question).to_not be_valid
  end
end
