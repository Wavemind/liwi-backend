require 'rails_helper'

RSpec.describe FinalDiagnostic, type: :model do
  create_algorithm
  create_diagnostic

  before(:each) do
    @version = Version.create!(name: '1.3.2', user: @user, algorithm: @algorithm)
  end

  it 'is valid with valid attributes' do
    final_diagnostic = FinalDiagnostic.new(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)
    expect(final_diagnostic).to be_valid
  end

  it 'is invalid with invalid attributes' do
    final_diagnostic = FinalDiagnostic.new(label_en: nil, description_en: 'A shot description',reference: '7', diagnostic: @dd7)
    expect(final_diagnostic).to_not be_valid
  end

  it 'is invalid same reference' do
    FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)
    final_diagnostic = FinalDiagnostic.new(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)

    expect(final_diagnostic).to_not be_valid
  end

  it 'can include health cares' do
    treatment = Treatment.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    management = Management.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    final_diagnostic = FinalDiagnostic.new(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)
    final_diagnostic.nodes << [management, treatment]

    expect(final_diagnostic).to be_valid
  end

  it 'cannot include a node which is not a health care (Management/Treatment)' do
    predefined_syndrome = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    final_diagnostic = FinalDiagnostic.new(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)
    final_diagnostic.nodes << predefined_syndrome

    expect(final_diagnostic).to_not be_valid
  end


  it 'returns correct list of available nodes' do
    df = FinalDiagnostic.new(label_en: 'Severe lower respiratory tract infection', description_en: 'A shot description',reference: '7', diagnostic: @dd7)

    ps9 = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    ps5 = PredefinedSyndrome.create!(reference: '5', label_en: 'diarrhea', algorithm: @algorithm)
    ps6 = PredefinedSyndrome.create!(reference: '7', label_en: 'coucou', algorithm: @algorithm)

    Instance.create!(node: ps6, instanceable: @dd7, final_diagnostic: df)

    expect(df.available_nodes_health_cares_json[0]['id']).to eq(ps9.id)
    expect(df.available_nodes_health_cares_json[1]['id']).to eq(ps5.id)
    expect(df.available_nodes_health_cares_json.count).to eq(2)
  end

  it 'generates diagram properly' do
    dd1 = Diagnostic.create!(version: @version, reference: '1', label: 'lower respiratory tract infection (LRTI)')
    dd1.final_diagnostics.create!(reference: '1', label_en: 'Df')
    t1 = Treatment.create!(reference: '1', label_en: 'Treat', algorithm: @algorithm)
    m1 = Management.create!(reference: '1', label_en: 'Manage', algorithm: @algorithm)
    ps5 = PredefinedSyndrome.create!(reference: '5', label_en: 'dia', algorithm: @algorithm)
    ps9 = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    dd1_df1 = Instance.create!(instanceable: dd1, node: dd1.final_diagnostics.first)
    dd1_ps9 = Instance.create!(instanceable: dd1, node: ps9, final_diagnostic: dd1_df1.node)
    dd1_m1 = Instance.create!(instanceable: dd1, node: m1, final_diagnostic: dd1_df1.node)
    dd1_t1 = Instance.create!(instanceable: dd1, node: t1, final_diagnostic: dd1_df1.node)

    dd1_df1.node.nodes << [m1, t1]
    dd1_df1.node.save

    Condition.create!(referenceable: dd1_m1, first_conditionable: ps9.answers.first, operator: nil, second_conditionable: nil)

    expect(dd1_df1.node.health_care_questions_json[0][0]['id']).to eq(dd1_ps9.id)
    expect(dd1_df1.node.health_cares_json[0]['id']).to eq(dd1_t1.id)
    expect(dd1_df1.node.health_cares_json[1]['id']).to eq(dd1_m1.id)
    expect(dd1_df1.node.health_cares_json[1]['conditions'][0]['first_conditionable_id']).to eq(ps9.answers.first.id)
  end
end
