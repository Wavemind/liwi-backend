require 'rails_helper'

RSpec.describe Instance, type: :model do
  create_answer_type
  create_algorithm
  create_diagnostic
  create_question

  it 'is valid with valid attributes' do
    instance = Instance.new(instanceable: @dd7, node: @question)
    expect(instance).to be_valid
  end

  it 'is invalid with invalid attributes' do
    instance = Instance.new(instanceable: @dd7, node: nil)
    expect(instance).to_not be_valid
  end

  it 'removes condition from children' do
    @q2 = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @boolean)
    instance = Instance.create!(instanceable: @dd7, node: @question)
    instance2 = Instance.create!(instanceable: @dd7, node: @q2)
    instance2.conditions.create!(first_conditionable: @question.answers.first)

    instance.remove_condition_from_children
    expect(instance.conditions.count).to eq(0)
  end
end
