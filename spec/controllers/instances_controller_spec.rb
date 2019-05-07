require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  login_user
  create_algorithm
  create_category
  create_answer_type
  create_instances

  it 'creates a link in both instances' do
    post :create_link, params: {
      diagnostic_id: @dd7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        answer_id: @s2_1.id,
        node_id: @df7.id,
      }
    }

    expect(@df7.instances.first.conditions.where(first_conditionable: @s2_1).or(@df7.instances.first.conditions.where(second_conditionable: @s2_1)).count).to equal(1)
    expect(Child.where(instance: @dd7_s2, node: @df7).count).to equal(1)
  end

  it 'removes a link in both instances' do
    @df7.instances.first.conditions.create!(first_conditionable: @p1_1, top_level: true)

    delete :remove_link, params: {
      diagnostic_id: @dd7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        answer_id: @p1_1.id,
        node_id: @df7.id,
      }
    }

    expect(@df7.instances.first.conditions.where(first_conditionable: @p1_1).or(@df7.instances.first.conditions.where(second_conditionable: @p1_1)).count).to equal(0)
    expect(Child.where(instance: @dd7_p1, node: @df7).count).to equal(0)
  end

  it 'creates a node from diagram' do
    m5 = Management.create!(reference: '5', label_en: 'Test', algorithm: @algorithm)
    post :create_from_diagram, params: {
      diagnostic_id: @dd7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        node_id: m5.id,
      }
    }

    expect(@dd7.components.where(node_id: m5.id).count).to equal(1)
  end

  it 'removes a node from diagram' do
    delete :remove_from_diagram, params: {
      diagnostic_id: @dd7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        node_id: @p1.id,
      }
    }

    expect(@dd7.components.where(node_id: @p1.id).count).to equal(0)
  end

end
