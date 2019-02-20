require 'rails_helper'

RSpec.describe FinalDiagnostic, type: :model do
  create_algorithm
  create_diagnostic

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
end
