require 'rails_helper'

RSpec.describe Condition, type: :model do
  create_answer_type
  create_algorithm
  create_instances

  it 'is valid with valid attributes' do
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: @s2_1, operator: nil, second_conditionable: nil)
    expect(condition).to be_valid
  end

  it 'is valid with valid attributes for AND condition (P3_2 AND P13_1)' do
    condition = Condition.new(referenceable: @df7.instances.first, first_conditionable: @p3_2, operator: Condition.operators[:and_operator], second_conditionable: @p13_1)
    expect(condition).to be_valid
  end

  it 'is valid with valid attributes mapping for AND AND condition (P3_2 AND P13_1 AND S2_1)' do
    conditionAND = Condition.new(referenceable: @df7.instances.first, first_conditionable: @p3_2, operator: Condition.operators[:and_operator], second_conditionable: @p13_1)
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: @s2_1, operator: Condition.operators[:and_operator], second_conditionable: conditionAND)
    expect(condition).to be_valid
  end

  it 'is invalid with invalid attributes' do
    condition = Condition.new(referenceable: @dd7_p1, first_conditionable: nil, operator: nil, second_conditionable: nil)
    expect(condition).to_not be_valid
  end

  it 'is not a loop' do
    is_child = @cond1.is_child(@dd7_df7)

    expect(is_child).to eq(false)
  end

  it 'is a loop and its not valid' do
    Condition.create!(referenceable: @dd7_p3, first_conditionable: @p1_1, top_level: true)
    cond2 = Condition.create(referenceable: @dd7_p1, first_conditionable: @p3_2, top_level: false)

    expect(cond2.valid?).to eq(false)
  end

end
