require 'rails_helper'

RSpec.describe DiagnosticsController, type: :controller do
  login_user
  create_algorithm
  create_diagnostic

  it 'adds translations without rendering the view' do

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      id: @dd7.id,
      diagnostic: {
        label_fr: 'Label en français',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @dd7.reload
    expect(@dd7.label_fr).to eq('Label en français')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      id: @dd7.id,
      diagnostic: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

  end

end
