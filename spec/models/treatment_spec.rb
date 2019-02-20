require 'rails_helper'

RSpec.describe Treatment, type: :model do
  create_algorithm

  it 'is valid with valid attributes' do
    treatment = Treatment.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    expect(treatment).to be_valid
  end

  it 'is invalid with invalid attributes' do
    treatment = Treatment.new(reference: '9', label_en: nil, algorithm: @algorithm)
    expect(treatment).to_not be_valid
  end

  it 'is invalid same reference' do
    Treatment.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    treatment = Treatment.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    expect(treatment).to_not be_valid
  end
end
