require 'rails_helper'

RSpec.describe ConditionsController, type: :controller do
  login_user
  create_algorithm
  create_category
  create_diagnostic
  create_question

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

end
