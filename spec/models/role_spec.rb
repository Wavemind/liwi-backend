require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'is valid with valid attributes' do
    role = Role.new(name: 'administrator')
    expect(role).to be_valid
  end

  it 'is invalid with invalid attributes' do
    role = Role.new(name: nil)
    expect(role).to_not be_valid
  end
end
