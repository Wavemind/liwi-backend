require 'rails_helper'

RSpec.describe Version, type: :model do
  create_answer_type
  create_algorithm

  it 'is valid with valid attributes' do
    version = Version.new(name: '1.3.2', user: @user, description: 'Small description', algorithm: @algorithm)
    expect(version).to be_valid
  end

  it 'is invalid with invalid attributes' do
    version = Version.new(name: nil, user: @user, algorithm: @algorithm)
    expect(version).to_not be_valid
  end
end
