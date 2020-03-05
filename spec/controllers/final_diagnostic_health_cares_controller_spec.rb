require 'rails_helper'

RSpec.describe FinalDiagnosticHealthCaresController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_version
  create_instances

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, final_diagnostic_id: @df7.id, final_diagnostic_health_care: { node_id: 1, final_diagnostic_id: @df7.id } }
    expect(response.status).to eq(302)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, final_diagnostic_id: @df7.id, id: @dfh7.id }
    expect(response.status).to eq(302)
  end
end
