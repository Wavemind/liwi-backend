require 'rails_helper'

RSpec.describe Condition, type: :model do
  create_algorithm
  create_answer_type
  create_category

  before(:each) do
    # Version
    epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)

    # Questions
    s2 = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)
    p13 = Question.create!(algorithm: @algorithm, label_en: 'Lower chest indrawing', reference: '13', category: @physical_exam, priority: Question.priorities[:basic], answer_type: @boolean)
    p3 = Question.create!(algorithm: @algorithm, label_en: 'Respiratory rate', reference: '3', category: @physical_exam, priority: Question.priorities[:triage], answer_type: @input_integer)
    p1 = Question.create!(algorithm: @algorithm, label_en: 'SAO2', reference: '1', category: @physical_exam, priority: Question.priorities[:triage], answer_type: @input_integer)

    # Answers
    @s2_1 = s2.answers.first
    @p3_2 = Answer.create!(node: p3, reference: '2', label_en: '>/= 97th%ile', value: '97', operator: '>=')
    @p13_1 = p13.answers.first

    # Diagnostics
    dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
    df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', reference: '7', diagnostic: dd7)

    # Instances
    @dd7_p1 = Instance.create!(instanceable: dd7, node: p1)
    @dd7_df7 = Instance.create!(instanceable: dd7, node: df7)

    # PS
    ps6 = PredefinedSyndrome.create!(algorithm: @algorithm, reference: '6', label_en: 'Able to drink')

    # Children
    Child.create!(instance: @dd7_p1, node: df7)
    Child.create!(instance: @dd7_df7, node: ps6)
  end

  it 'is valid with valid attributes' do
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: @s2_1, operator: nil, second_conditionable: nil)
    expect(condition).to be_valid
  end

  it 'is valid with valid attributes for AND condition (P3_2 AND P13_1)' do
    condition = Condition.new(referenceable: @dd7_df7, first_conditionable: @p3_2, operator: 'AND', second_conditionable: @p13_1)
    expect(condition).to be_valid
  end

  it 'is valid with valid attributes mapping for AND AND condition (P3_2 AND P13_1 AND S2_1)' do
    conditionAND = Condition.new(referenceable: @dd7_df7, first_conditionable: @p3_2, operator: 'AND', second_conditionable: @p13_1)
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: @s2_1, operator: 'AND', second_conditionable: conditionAND)
    expect(condition).to be_valid
  end

  it 'is invalid with invalid attributes' do
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: nil, operator: nil, second_conditionable: nil)
    expect(condition).to_not be_valid
  end

end
