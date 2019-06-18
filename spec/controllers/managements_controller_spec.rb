require 'rails_helper'

RSpec.describe ManagementsController, type: :controller do
  login_user
  create_algorithm
  create_answer_type
  create_instances

  before(:each) do
    @management = @algorithm.health_cares.managements.create!(reference: 1, label_en: 'Label en')
  end

  it 'adds translations without rendering the view' do

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
      health_cares_management: {
        label_fr: 'Label fr',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @management.reload
    expect(@management.label_fr).to eq('Label fr')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
      health_cares_management: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

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

  it 'returns success full message when removing a management hasn\'t instance dependecy' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'managements')
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end

end
