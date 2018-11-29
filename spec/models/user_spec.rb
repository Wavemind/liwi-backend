require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(first_name: 'Foo', last_name: 'Bar')
    expect(user).to be_valid
  end

  it 'is invalid with invalid attributes' do
    user = User.new(first_name: nil, last_name: 'Bar')
    expect(user).to_not be_valid
  end
end
