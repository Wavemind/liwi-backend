require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with valid attributes' do
    group = Group.new(name: 'administrator')
    expect(group).to be_valid
  end

  it 'is invalid with invalid attributes' do
    group = Group.new(name: nil)
    expect(group).to_not be_valid
  end
end
