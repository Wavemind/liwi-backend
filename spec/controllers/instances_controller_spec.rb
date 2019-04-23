require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  login_user
  create_algorithm
  create_category
  create_answer_type
  create_instances

  it 'creates a link in both way', focus: true do
    post :create_link, params: {
      diagnostic_id: @dd7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        answer_id: @s2_1.id,
        node_id: @df7.id,
      }
    }

    expect(Child.where(instance: @dd7_s2, node: @df7).count).to equal(1)
  end
end
