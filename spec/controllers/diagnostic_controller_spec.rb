require 'rails_helper'

RSpec.describe DiagnosticsController, type: :controller do
  login_user
  create_algorithm
  create_category
  create_answer_type
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

    expect(duplicated.final_diagnostics).to contain_exactly(Instance.where(instanceable: duplicated, node: duplicated.final_diagnostics.first).first.node)
    expect(@dd7.final_diagnostics.count).to equal(duplicated.final_diagnostics.count)
    expect(@dd7.conditions.count).to equal(duplicated.conditions.count)
    expect(@dd7.components.count).to equal(duplicated.components.count)
    expect(@dd7.components.map(&:children).count).to equal(duplicated.components.map(&:children).count)
    expect(@dd7.components.map(&:conditions).count).to equal(duplicated.components.map(&:conditions).count)
    expect(@dd7.reference + I18n.t('duplicated')).to eq(duplicated.reference)
  end
end
