require 'rails_helper'

RSpec.describe Patient, type: :model do
  it 'is valid with valid attributes' do
    patient = Patient.new(first_name: 'John', last_name: 'Do')
    expect(patient).to be_valid
  end

  it 'is invalid with invalid attributes' do
    patient = Patient.new(first_name: 'John', last_name: nil)
    expect(patient).to_not be_valid
  end
end
