require 'rails_helper'

RSpec.describe HealthCares::Drug, type: :model do
  create_answer_type
  create_algorithm

  it 'is valid with valid attributes' do
    drug = HealthCares::Drug.new(label_en: 'skin issue', algorithm: @algorithm)
    expect(drug).to be_valid
  end

  it 'is invalid with invalid attributes' do
    drug = HealthCares::Drug.new(label_en: nil, algorithm: @algorithm)
    expect(drug).to_not be_valid
  end
end
