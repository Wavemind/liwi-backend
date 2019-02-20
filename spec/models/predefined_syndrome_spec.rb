require 'rails_helper'

RSpec.describe PredefinedSyndrome, type: :model do
  create_algorithm

  it 'is valid with valid attributes' do
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    expect(predefined_syndrome).to be_valid
  end

  it 'is invalid with invalid attributes' do
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: nil, algorithm: @algorithm)
    expect(predefined_syndrome).to_not be_valid
  end
  
  it 'generates answers automatically' do
    predefined_syndrome = PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    expect(predefined_syndrome.answers.count).to eq(2)
  end

  it 'is invalid same reference' do
    PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    predefined_syndrome = PredefinedSyndrome.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    expect(predefined_syndrome).to_not be_valid
  end
end
