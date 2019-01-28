require 'rails_helper'

RSpec.describe AnswerType, type: :model do
  it 'is valid with valid attributes' do
    answer_type = AnswerType.new(value: 'numeric', display: 'checkbox')
    expect(answer_type).to be_valid
  end

  it 'is invalid with invalid attributes' do
    answer_type = AnswerType.new(value: 'numeric', display: nil)
    expect(answer_type).to_not be_valid
  end
end
