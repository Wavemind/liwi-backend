require 'rails_helper'

RSpec.describe HealthCares::Drug, type: :model do
  create_answer_type
  create_algorithm

  it 'is valid with valid attributes' do
    treatment = HealthCares::Treatment.new(label_en: 'skin issue', algorithm: @algorithm)
    expect(treatment).to be_valid
  end

  it 'is invalid with invalid attributes' do
    treatment = HealthCares::Treatment.new(label_en: nil, algorithm: @algorithm)
    expect(treatment).to_not be_valid
  end
end
