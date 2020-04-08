require 'rails_helper'

RSpec.describe QuestionsSequence, type: :model do
  create_answer_type
  create_algorithm

  it 'is valid with valid attributes' do
    predefined_syndrome = QuestionsSequences::PredefinedSyndrome.new(label_en: 'skin issue', algorithm: @algorithm)
    expect(predefined_syndrome).to be_valid
  end

  it 'is invalid with invalid attributes' do
    predefined_syndrome = QuestionsSequences::PredefinedSyndrome.new(label_en: nil, algorithm: @algorithm)
    expect(predefined_syndrome).to_not be_valid
  end

  it 'generates answers automatically' do
    predefined_syndrome = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
    expect(predefined_syndrome.answers.count).to eq(2)
  end

  it 'generates questions properly' do
    ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
    ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'diarrhea', algorithm: @algorithm)
    ps9_ps5 = Instance.create!(instanceable: ps9, node: ps5)
    ps9_ps9 = Instance.create!(instanceable: ps9, node: ps9)
    Condition.create!(referenceable: ps9_ps9, first_conditionable: ps5.answers.first, operator: nil, second_conditionable: nil)

      expect(ps9.questions_json[1][0]['conditions'][0]['first_conditionable_id']).to eq(ps5.answers.first.id)
  end

  it 'returns correct list of available nodes' do
    ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'diarrhea', algorithm: @algorithm)
    ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)

    expect(ps9.available_nodes_json[5]['id']).to eq(ps9.id)
    expect(ps9.available_nodes_json[6]['id']).to eq(ps5.id)
  end

  context 'manual validation' do
    before(:each) do
      @ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'diarrhea', algorithm: @algorithm)
      ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)
      @ps5_ps5 = Instance.create!(instanceable: @ps5, node: @ps5)
      Instance.create!(instanceable: @ps5, node: ps9)
      Condition.create!(referenceable: @ps5_ps5, first_conditionable: ps9.answers.first, operator: nil, second_conditionable: nil)
    end

    it 'manual validation validates a valid diagnostic' do
      @ps5.manual_validate
      expect(@ps5.errors.messages.any?).to be(false)
    end

    it 'manual validation returns errors for an invalid diagnostic' do
      Instance.create!(instanceable: @ps5, node: QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm))
      @ps5.manual_validate

      expect(@ps5.errors.messages.any?).to be(true)
    end
  end


  context 'manual validation pss' do
    before(:each) do
      @pss1 = QuestionsSequences::Scored.create!(label_en: 'PSS', algorithm: @algorithm, min_score: 5)
      ps5 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'diarrhea', algorithm: @algorithm)
      @ps9 = QuestionsSequences::PredefinedSyndrome.create!(label_en: 'skin issue', algorithm: @algorithm)

      @pss1_pss1 = Instance.create!(instanceable: @pss1, node: @pss1)
      Instance.create!(instanceable: @pss1, node: ps5)
      Instance.create!(instanceable: @pss1, node: @ps9)

      Condition.create!(referenceable: @pss1_pss1, first_conditionable: ps5.answers.first, operator: nil, second_conditionable: nil, score: 2)
    end

    it 'validates with a possible combination' do
      Condition.create!(referenceable: @pss1_pss1, first_conditionable: @ps9.answers.first, operator: nil, second_conditionable: nil, score: 3)
      @pss1.manual_validate
      expect(@pss1.errors.messages.any?).to be(false)
    end

    it 'does not validate with no possible combination' do
      Condition.create!(referenceable: @pss1_pss1, first_conditionable: @ps9.answers.first, operator: nil, second_conditionable: nil, score: 2)
      @pss1.manual_validate
      expect(@pss1.errors.messages.any?).to be(true)
    end
  end

end
