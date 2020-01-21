require 'rails_helper'

RSpec.describe DiagnosticsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_version
  create_instances

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

  it 'duplicates the diagnostic properly' do
    post :duplicate, params: {
      algorithm_id: @algorithm.id,
      version_id: @dd7.version.id,
      id: @dd7.id,
    }

    duplicated = Diagnostic.last

    expect(@dd7.final_diagnostics.count).to equal(duplicated.final_diagnostics.count)
    expect(@dd7.conditions.count).to equal(duplicated.conditions.count)
    expect(@dd7.components.count).to equal(duplicated.components.count)
    expect(@dd7.components.map(&:children).count).to equal(duplicated.components.map(&:children).count)
    expect(@dd7.components.map(&:conditions).count).to equal(duplicated.components.map(&:conditions).count)
    expect(@dd7.reference + I18n.t('duplicated')).to eq(duplicated.reference)
    expect(duplicated.components.where(node: duplicated.final_diagnostics.first).count).to eq(1)
  end

  it 'should work for [GET:index]' do
    get :index, params: { algorithm_id: @algorithm.id, version_id: @version.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:show]' do
    get :show, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id, version_id: @version.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, version_id: @version.id, diagnostic: { version: @version, label_en: 'Severe LRTI', reference: '7', node: @cc } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id, diagnostic: { version: @version, label_en: 'Severe LRTI', reference: '7', node: @cc } }
    expect(response.status).to eq(302)
  end

  it 'should work for [DELETE:destroy]' do
    delete :destroy, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id }
    expect(response.status).to eq(302)
  end

  it 'should work for [GET:diagram]' do
    get :diagram, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:get]' do
    get :validate, params: { algorithm_id: @algorithm.id, version_id: @version.id, id: @dd7.id }
    expect(response.status).to eq(200)
  end

end
