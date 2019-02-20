require 'rails_helper'

RSpec.describe Condition, type: :model do

  before(:each) do
    physical_exam = Category.create!(name_en: 'Physical exam', reference_prefix: 'P')
    role_administrator = Role.create!(name: 'Administrator')
    input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
    symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S')
    boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')

    emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
    epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: emmanuel)
    epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)

    s2 = Question.create!(algorithm: epoct, label_en: 'Cough', reference: '2', category: symptom, priority: Question.priorities[:priority], answer_type: boolean)
    @s2_1 = s2.answers.first

    p3 = Question.create!(algorithm: epoct, label_en: 'Respiratory rate', reference: '3', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
    @p3_2 = Answer.create!(node: p3, reference: '2', label_en: '>/= 97th%ile', value: '97', operator: '>=')

    p13 = Question.create!(algorithm: epoct, label_en: 'Lower chest indrawing', reference: '13', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
    @p13_1 = p13.answers.first

    dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
    df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', reference: '7', diagnostic: dd7)
    p1 = Question.create!(algorithm: epoct, label_en: 'SAO2', reference: '1', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
    @dd7_p1 = Instance.create!(instanceable: dd7, node: p1)
    @dd7_df7 = Instance.create!(instanceable: dd7, node: df7)
    ps6 = PredefinedSyndrome.create!(algorithm: epoct, reference: '6', label_en: 'Able to drink')
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
