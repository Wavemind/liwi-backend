require 'rails_helper'

RSpec.describe DrugsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @administration_route = AdministrationRoute.create!(category: 'enteral', name: 'orally')
    @drug = @algorithm.health_cares.drugs.create!(type: 'HealthCares::Drug', label_en: 'Label en')
  end

  it 'adds translations without rendering the view' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @drug.id,
      health_cares_drug: {
        label_fr: 'Label fr',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @drug.reload
    expect(@drug.label_fr).to eq('Label fr')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @drug.id,
      health_cares_drug: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)
  end

  it 'returns error message when trying to remove a drug who has an instance' do
    Instance.create!(instanceable: @dd7, node: @drug)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @drug.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'drugs')
    expect(response).to have_attributes(status: 302)
    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a drug hasn\'t instance dependecy' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @drug.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'drugs')
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, health_cares_drug: { algorithm: @algorithm, label_en: 'Severe LRTI' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [get:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, id: @drug.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: {
      algorithm_id: @algorithm.id,
      id: @drug.id,
      health_cares_drug: {
        algorithm: @algorithm,
        label_en: 'Severe LRTI',
        is_antibiotic: true,
        formulations_attributes:[
          {
            medication_form: 'suppository',
            administration_route_id: @administration_route.id,
            doses_per_day: 3,
            unique_dose: 3
          }
        ]
      }
    }
    @drug.reload

    expect(response.status).to eq(200)
    expect(@drug.formulations.count).to eq(1)
    expect(@drug.is_antibiotic).to be(true)
    expect(@drug.is_anti_malarial).to be(false)
    expect(response.status).to eq(302)
  end

end
