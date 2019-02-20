require 'rails_helper'

RSpec.describe Treatment, type: :model do
  create_algorithm

  it 'is valid with valid attributes' do
    management = Management.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    expect(management).to be_valid
  end

  it 'is invalid with invalid attributes' do
    management = Management.new(reference: '9', label_en: nil, algorithm: @algorithm)
    expect(management).to_not be_valid
  end

  it 'is invalid same reference' do
    Management.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    management = Management.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    expect(management).to_not be_valid
  end
end
