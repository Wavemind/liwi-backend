require 'rails_helper'

RSpec.describe PredefinedSyndrome, type: :model do
  create_algorithm
  create_predefined_syndrome_category

  it 'is valid with valid attributes' do
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)
    expect(predefined_syndrome).to be_valid
  end

  it 'is invalid with invalid attributes' do
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: nil, algorithm: @algorithm, category: @ps_category)
    expect(predefined_syndrome).to_not be_valid
  end

  it 'generates answers automatically' do
    predefined_syndrome = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)
    expect(predefined_syndrome.answers.count).to eq(2)
  end

  it 'is invalid same reference' do
    PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)

    expect(predefined_syndrome).to_not be_valid
  end

  it 'generates questions properly' do
    ps9 = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)
    ps5 = PredefinedSyndrome.create!(reference: '5', label_en: 'diarrhea', algorithm: @algorithm, category: @ps_category)
    Instance.create!(instanceable: ps9, node: ps5)
    ps9_ps9 = Instance.create!(instanceable: ps9, node: ps9)
    Condition.create!(referenceable: ps9_ps9, first_conditionable: ps5.answers.first, operator: nil, second_conditionable: nil)

    expect(ps9.generate_questions_order[0][0].node).to eq(ps5)
    expect(ps9.generate_questions_order[1][0].node).to eq(ps9)
  end

  it 'returns correct list of available nodes' do
    ps9 = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm, category: @ps_category)
    ps5 = PredefinedSyndrome.create!(reference: '5', label_en: 'diarrhea', algorithm: @algorithm, category: @ps_category)

    expect(ps9.available_nodes_json[0]['id']).to eq(ps9.id)
    expect(ps9.available_nodes_json[1]['id']).to eq(ps5.id)
  end
end
