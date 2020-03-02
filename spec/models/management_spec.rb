require 'rails_helper'

RSpec.describe HealthCares::Management, type: :model do
  create_answer_type
  create_algorithm

  it 'is valid with valid attributes' do
    management = HealthCares::Management.new(label_en: 'skin issue', algorithm: @algorithm)
    expect(management).to be_valid
  end

  it 'is invalid with invalid attributes' do
    management = HealthCares::Management.new(label_en: nil, algorithm: @algorithm)
    expect(management).to_not be_valid
  end
end
