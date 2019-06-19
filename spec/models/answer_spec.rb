require 'rails_helper'

RSpec.describe Answer, type: :model do
  create_algorithm

  before(:each) do
    answer_type = AnswerType.new(value: 'Array', display: 'Radiobutton')
    @question = Questions::Symptom.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], answer_type: answer_type, algorithm: @algorithm)
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
    answer = Answer.new(reference: '4', label: '< 6 %', operator: Answer.operators[:less], value: 'true', node: @question)

    expect(answer).to_not be_valid
  end

  it 'creates an answer for unavailable assessment test' do
    Answer.create_unavailable(@question.id)

    expect(@question.answers.first.label).to eq(I18n.t('answers.unavailable'))
  end

  it 'accept correct input values' do
    answer_type = AnswerType.create!(value: 'Integer', display: 'Input')
    question = Questions::Symptom.create!(reference: '1', label: 'skin issue', priority: Question.priorities[:basic], answer_type: answer_type, algorithm: @algorithm)

    answer = question.answers.new(reference: '1', label_en: 'Between 2 and 3', value: '2,3', operator: Answer.operators[:between])
    expect(answer).to be_valid
  end

  it 'fails for wrong input values' do
    answer_type = AnswerType.create!(value: 'Float', display: 'Input')
    question = Questions::Symptom.create!(reference: '1', label: 'skin issue', priority: Question.priorities[:basic], answer_type: answer_type, algorithm: @algorithm)

    answer = question.answers.new(reference: '1', label_en: 'Between 2 and 3', value: '23', operator: Answer.operators[:between])
    expect(answer).to_not be_valid

    answer = question.answers.new(reference: '2', label_en: 'Between 2 and 3', value: '2,3 et demi', operator: Answer.operators[:between])
    expect(answer).to_not be_valid
  end
end
