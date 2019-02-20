require 'rails_helper'

RSpec.describe FinalDiagnostic, type: :model do
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
end
