require 'rails_helper'

RSpec.describe HealthCares::Management, type: :model do
  create_algorithm

  it 'is valid with valid attributes' do
    management = HealthCares::Management.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    expect(management).to be_valid
  end

  it 'is invalid with invalid attributes' do
    management = HealthCares::Management.new(reference: '9', label_en: nil, algorithm: @algorithm)
    expect(management).to_not be_valid
  end

  it 'is invalid same reference' do
    HealthCares::Management.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    management = HealthCares::Management.new(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    expect(management).to_not be_valid
  end
end
