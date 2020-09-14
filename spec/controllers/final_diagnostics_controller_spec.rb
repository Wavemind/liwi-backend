require 'rails_helper'

RSpec.describe FinalDiagnosticsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_version
  create_diagnostic

  before(:each) do
    @df1 = @dd7.final_diagnostics.create!(label_en: 'df')
  end

  it 'creates excluding final diagnostic from controller than remove it with the destroy method' do
    df2 = @dd7.final_diagnostics.create!(label_en: 'df')

    post :add_excluded_diagnostic, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      diagnostic_id: @dd7.id,
      final_diagnostic: {
        id: @df1.id,
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

  it 'should work for [GET:index]' do
    get :index, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, final_diagnostic: { reference: 2, label_en: 'df' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, id: @df1.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    post :create, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, id: @df1.id, final_diagnostic: { reference: 2, label_en: 'boom boom' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, id: @df1.id }
    expect(response.status).to eq(302)
  end

  it 'should work for [GET:diagram]' do
    get :diagram, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic_id: @dd7.id, id: @df1.id }
    expect(response.status).to eq(200)
  end

end
