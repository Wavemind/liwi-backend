require 'rails_helper'

RSpec.describe TreatmentsController, type: :controller do
  login_user
  create_algorithm
  create_answer_type
  create_category
  create_instances

  before(:each) do
    @treatment = @algorithm.treatments.create!(reference: 1, label_en: 'Label en')
  end

  it 'adds translations without rendering the view' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @treatment.id,
      treatment: {
        label_fr: 'Label fr',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @treatment.reload
    expect(@treatment.label_fr).to eq('Label fr')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @treatment.id,
      treatment: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)
  end

  it 'returns error message when trying to remove a treatment who has an instance' do
    Instance.create!(instanceable: @dd7, node: @treatment)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @treatment.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'treatments')
    expect(response).to have_attributes(status: 302)
    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a treatment hasn\'t instance dependecy' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @treatment.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'treatments')
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end

end