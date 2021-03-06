require 'rails_helper'

RSpec.describe Diagnostic, type: :model do
  create_answer_type

  before(:each) do
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
    @algorithm = Algorithm.create!(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    @cc = @algorithm.questions.create!(answer_type: boolean, label_en: 'CC11', stage: Question.stages[:triage], type: 'Questions::ComplaintCategory')

    @version = Version.create!(name: '1.3.2', description: 'Small description', user: user, algorithm: @algorithm)
  end

  it 'is valid with valid attributes' do
    diagnostic = Diagnostic.new(version: @version, label: 'lower respiratory tract infection (LRTI)', node: @cc)

    expect(diagnostic).to be_valid
  end

  it 'is invalid with invalid attributes' do
    diagnostic = Diagnostic.new(version: @version, label: nil, node: @cc)

    expect(diagnostic).to_not be_valid
  end

  it 'generates diagram properly' do
    dd1 = Diagnostic.create!(version: @version, label: 'lower respiratory tract infection (LRTI)', node: @cc)
    dd1.final_diagnostics.create!(label_en: 'Df')
    t1 = HealthCares::Drug.create!(label_en: 'Treat', algorithm: @algorithm)
    m1 = HealthCares::Management.create!(label_en: 'Manage', algorithm: @algorithm)
    ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'dia', algorithm: @algorithm)
    ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
    dd1_df1 = Instance.create!(instanceable: dd1, node: dd1.final_diagnostics.first)
    dd1_ps5 = Instance.create!(instanceable: dd1, node: ps5)
    dd1_ps9 = Instance.create!(instanceable: dd1, node: ps9)
    dd1_t1 = Instance.create!(instanceable: dd1, node: t1)
    dd1_m1 = Instance.create!(instanceable: dd1, node: m1)

    Condition.create!(referenceable: dd1_ps9, first_conditionable: ps5.answers.first, operator: nil, second_conditionable: nil)
    Condition.create!(referenceable: dd1_df1, first_conditionable: ps9.answers.first, operator: nil, second_conditionable: nil)

    expect(dd1.final_diagnostics_json[0]['id']).to eq(dd1_df1.id)
    expect(dd1.health_cares_json[0]['id']).to eq(dd1_t1.id)
    expect(dd1.health_cares_json[1]['id']).to eq(dd1_m1.id)
    expect(dd1.questions_json[0]['conditions'][0]['first_conditionable_id']).to eq(ps5.answers.first.id)
  end

  it 'returns correct list of available nodes' do
    dd1 = Diagnostic.create!(version: @version, label: 'lower respiratory tract infection (LRTI)', node: @cc)

    ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
    ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'diarrhea', algorithm: @algorithm)

    expect(dd1.available_nodes_json[5]['id']).to eq(ps5.id)
    expect(dd1.available_nodes_json[6]['id']).to eq(ps9.id)
  end

  context 'destroys correctly a complet diagnostic' do
    before(:each) do
      @dd1 = Diagnostic.create!(version: @version, label: 'lower respiratory tract infection (LRTI)', node: @cc)
      @dd1.final_diagnostics.create!(label_en: 'Df')
      t1 = HealthCares::Drug.create!(label_en: 'Treat', algorithm: @algorithm)
      m1 = HealthCares::Management.create!(label_en: 'Manage', algorithm: @algorithm)
      ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'dia', algorithm: @algorithm)
      ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
      dd1_df1 = Instance.create!(instanceable: @dd1, node: @dd1.final_diagnostics.first)
      dd1_ps5 = Instance.create!(instanceable: @dd1, node: ps5)
      dd1_ps9 = Instance.create!(instanceable: @dd1, node: ps9)
      dd1_t1 = Instance.create!(instanceable: @dd1, node: t1)
      dd1_m1 = Instance.create!(instanceable: @dd1, node: m1)

      Condition.create!(referenceable: dd1_ps9, first_conditionable: ps5.answers.first, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd1_df1, first_conditionable: ps9.answers.first, operator: nil, second_conditionable: nil)
    end

    it 'removes the diagnostic' do
      expect {@dd1.controlled_destroy}.to change(Diagnostic.all, :count).by(-1)
    end

    it 'removes instances' do
      expect {@dd1.controlled_destroy}.to change(Instance.all, :count).by(-5)
    end

    it 'removes conditions' do
      expect {@dd1.controlled_destroy}.to change(Condition.all, :count).by(-2)
    end

    it 'removes children' do
      expect {@dd1.controlled_destroy}.to change(Child.all, :count).by(-2)
    end

    it 'removes final diagnostics' do
      expect {@dd1.controlled_destroy}.to change(Node.all, :count).by(-1)
    end
  end

  context 'manual validation' do
    before(:each) do
      @dd1 = Diagnostic.create!(version: @version, label: 'lower respiratory tract infection (LRTI)', node: @cc)
      @dd1.final_diagnostics.create!(label_en: 'Df')
      dd1_df1 = Instance.create!(instanceable: @dd1, node: @dd1.final_diagnostics.first)
      ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
      Instance.create!(instanceable: @dd1, node: ps9)
      Condition.create!(referenceable: dd1_df1, first_conditionable: ps9.answers.first, operator: nil, second_conditionable: nil)
    end

    it 'manual validation validates a valid diagnostic' do
      @dd1.manual_validate
      expect(@dd1.errors.messages.any?).to be(false)
    end

    it 'manual validation returns errors for an invalid diagnostic' do
      Instance.create!(instanceable: @dd1, node: QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm))
      @dd1.manual_validate

      expect(@dd1.errors.messages.any?).to be(true)
    end
  end
end
