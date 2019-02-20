require 'rails_helper'

RSpec.describe Instance, type: :model do
  create_algorithm
  create_diagnostic
  create_question

  it 'is valid with valid attributes' do
    instance = Instance.new(instanceable: @dd7, node: @question)
    expect(instance).to be_valid
  end

  it 'is invalid with invalid attributes' do
    instance = Instance.new(instanceable: @dd7, node: nil)
    instance2 = Instance.new(instanceable: nil, node: @question)
    expect(instance).to_not be_valid
    expect(instance2).to_not be_valid
  end

end
