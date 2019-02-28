require 'rails_helper'

RSpec.describe PredefinedSyndromesController, type: :controller do
  login_user
  create_algorithm
  create_predefined_syndrome_category

  before(:each) do
    @predefined_syndrome = @algorithm.predefined_syndromes.create!(reference: 1, label_en: 'Label en', category: @ps_category)
  end

  it 'adds translations without rendering the view' do

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @predefined_syndrome.id,
      predefined_syndrome: {
        label_fr: 'Label fr',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @predefined_syndrome.reload
    expect(@predefined_syndrome.label_fr).to eq('Label fr')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @predefined_syndrome.id,
      predefined_syndrome: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

  end

end
