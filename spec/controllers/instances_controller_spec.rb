require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @predefined_syndrome = @algorithm.questions_sequences.create!(reference: 1, label_en: 'Label en', type: QuestionsSequences::PredefinedSyndrome)
  end

  it 'should work for [GET:index]' do
    get :index, params: { type: 'FinalDiagnostic', id: Instance.first.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'creates a link in both instances' do
    post :create_link, params: {
      diagnostic_id: @dd7.id,
      id: @dd7_df7.id,
      instance: {
        id: @dd7_df7.id,
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        answer_id: @s2_1.id,
      }
    }

    expect(@df7.instances.first.conditions.where(first_conditionable: @s2_1).or(@df7.instances.first.conditions.where(second_conditionable: @s2_1)).count).to equal(1)
    expect(Child.where(instance: @dd7_s2, node: @df7).count).to equal(1)
  end

  it 'removes a link in both instances' do
    delete :remove_link, params: {
      diagnostic_id: @dd7.id,
      id: @dd7_df7.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        condition_id: @df7.instances.first.conditions.first.id
      }
    }

    expect(@df7.instances.first.conditions.where(first_conditionable: @p1_1).or(@df7.instances.first.conditions.where(second_conditionable: @p1_1)).count).to equal(0)
    expect(Child.where(instance: @dd7_p1, node: @df7).count).to equal(0)
  end

  it 'creates a node from diagram' do
    m5 = HealthCares::Management.create!(label_en: 'Test', algorithm: @algorithm)
    post :create, params: {
      diagnostic_id: @dd7.id,
      from: 'react',
      id: m5.id,
      instance: {
        instanceable_id: @dd7.id,
        instanceable_type: @dd7.class.name,
        node_id: m5.id,
        final_diagnostic_id: @df7.id,
      }
    }

    expect(@dd7.components.where(node_id: m5.id).count).to equal(1)
  end

  it 'Remove an instances' do
    delete :destroy, params: {
      diagnostic_id: @dd7.id,
      id: @dd7_p1.id,
      instance: {
        id: @dd7_p1.id
      }
    }

    expect(@dd7.components.where(node_id: @p1.id).count).to equal(0)
  end

  it 'should work for [POST:create]' do
    post :create, params: { diagnostic_id: @dd7.id, instance: { instanceable: @dd7, node: @p1 } }
    expect(response.status).to eq(302)
  end

  it 'should work for [GET:by_reference]' do
    get :by_reference, params: { diagnostic_id: @dd7.id, reference: @p1.reference }
    expect(response.status).to eq(200)
  end

end
