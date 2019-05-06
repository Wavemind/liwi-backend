require 'rails_helper'

RSpec.describe FinalDiagnosticsController, type: :controller do
  login_user
  create_algorithm
  create_diagnostic

  before(:each) do
    @df1 = @dd7.final_diagnostics.create!(reference: 1, label_en: 'df')
  end

  it 'creates excluding final diagnostic from controller than remove it with the destroy method' do
    df2 = @dd7.final_diagnostics.create!(reference: 2, label_en: 'df')

    post :add_excluded_diagnostic, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
      final_diagnostic: {
        final_diagnostic_id: df2.id,
      }
    }

    @df1.reload

    expect(@df1.excluded_diagnostic.id).to eq(df2.id)

    delete :remove_excluded_diagnostic, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
    }

    @df1.reload

    expect(@df1.excluded_diagnostic).to eq(nil)
  end

  it 'adds translations without rendering the view' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
      final_diagnostic: {
        label_fr: 'Label en français',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @df1.reload
    expect(@df1.label_fr).to eq('Label en français')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
      final_diagnostic: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)
  end

  it 'returns error message when trying to remove a final diagnostic who has an instance' do
    Instance.create!(instanceable: @dd7, node: @df1)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
    }

    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'creates a language then be able to translate in that language' do
    Language.create!(name: 'Hebrew', code: 'he')

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      id: @df1.id,
      final_diagnostic: {
        label_he: 'Shalom',
      }
    }

    @df1.reload
    expect(@df1.label_he).to eq('Shalom')
  end

end
