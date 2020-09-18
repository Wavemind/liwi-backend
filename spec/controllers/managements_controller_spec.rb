require 'rails_helper'
require 'json'

RSpec.describe ManagementsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @management = @algorithm.health_cares.managements.create!(label_en: 'Label en')
  end

  it 'returns error message when trying to remove a management who has an instance' do
    Instance.create!(instanceable: @dd7, node: @management)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'managements')
    expect(response).to have_attributes(status: 302)
    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a management hasn\'t instance dependency' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'managements')
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { from: 'react', algorithm_id: @algorithm.id, id: @management.id, health_cares_management: { algorithm: @algorithm, label_en: 'Severe LRTI' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { from: 'rails', algorithm_id: @algorithm.id, diagnostic_id: @dd7.id, health_cares_management: { algorithm: @algorithm, label_en: 'Severe LRTI' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, id: @management.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { from: 'rails', algorithm_id: @algorithm.id, id: @management.id, health_cares_management: { algorithm: @algorithm, label_en: 'Severe LRTI' } }
    expect(response.status).to eq(200)
  end

end
