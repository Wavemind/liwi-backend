require 'rails_helper'

RSpec.describe Answer, type: :model do

  before(:each) do
    answer_type = AnswerType.new(value: 'boolean', display: 'radio')
    category = Category.new(name: 'Symptom', reference_prefix: 'S')
    @question = Question.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], category: category, answer_type: answer_type)
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
