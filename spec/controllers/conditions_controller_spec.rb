require 'rails_helper'

RSpec.describe ConditionsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_question
  create_instances

  it 'creates diagnostic condition from controller than remove it with the remove method' do
    hash = @question.answers.first.conditionable_hash
    post :add_diagnostic_condition, params: { diagnostic_id: @dd7.id, condition: {
      first_conditionable_id: hash,
      second_conditionable_id: '',
      top_level: true
    } }

    expect(@dd7.conditions.count).to eq(1)

    delete :destroy_diagnostic_condition, params: {
      diagnostic_id: @dd7.id,
      id: @dd7.conditions.first.id
    }

    expect(@dd7.conditions.count).to eq(0)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy, params: { diagnostic_id: @dd7.id, instance_id: Instance.first, id:  @cond1.id }
    expect(response.status).to eq(204)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy, params: { questions_sequence_id: @ps6.id, instance_id: Instance.first, id:  @cond1.id }
    expect(response.status).to eq(204)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy_diagnostic_condition, params: { diagnostic_id: @dd7.id, id:  @cond1.id }
    expect(response.status).to eq(302)
  end

end
