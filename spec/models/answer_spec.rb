require 'rails_helper'

RSpec.describe Answer, type: :model do

  before(:each) do
    answer_type = AnswerType.new(value: 'boolean', display: 'radio')
    @question = Question.create!(reference: 's_9', label: 'skin issue', priority: Question.priorities[:basic], category: Question.categories[:symptom], answer_type: answer_type)
  end

  it 'is valid with valid attributes' do
    answer = Answer.new(reference: 's_9_1', label: 'True', operator: nil, value: 'true', question: @question)
    expect(answer).to be_valid
  end

  it 'is invalid with invalid attributes' do
    answer = Answer.new(reference: 's_9_1', label: nil, operator: nil, value: 'true', question: @question)
    expect(answer).to_not be_valid
  end

  it 'is invalid same reference' do
    answer_1 = Answer.create!(reference: 's_9_1', label: 'True', operator: nil, value: 'true', question: @question)
    answer = Answer.new(reference: 's_9_1', label: '< 6 %', operator: '<', value: 'true', question: @question)
    expect(answer).to_not be_valid
  end
end
