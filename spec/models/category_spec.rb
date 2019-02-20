require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    category = Category.new(name: 'Symptom', reference_prefix: 'S')
    expect(category).to be_valid
  end

  it 'is invalid with invalid attributes' do
    category = Category.new(name: 'Symptom', reference_prefix: nil)
    expect(category).to_not be_valid
  end
end
