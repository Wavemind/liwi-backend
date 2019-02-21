require 'rails_helper'

RSpec.describe ManagementsController, type: :controller do
  login_user
  create_algorithm

  before(:each) do
    @management = @algorithm.managements.create!(reference: 1, label_en: 'Label en')
  end

  it 'adds translations without rendering the view' do

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @management.id,
      management: {
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
      management: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

  end

end
