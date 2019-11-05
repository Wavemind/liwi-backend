require 'rails_helper'

RSpec.describe QuestionsSequencesController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @predefined_syndrome = @algorithm.questions_sequences.create!(reference: 1, label_en: 'Label en', type: QuestionsSequences::PredefinedSyndrome)
  end

  it 'adds translations without rendering the view' do

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @predefined_syndrome.id,
      questions_sequence: {
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
      questions_sequence: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

  end

  it 'returns error message when trying to remove a predefined syndrome who has an instance' do
    Instance.create!(instanceable: @dd7, node: @predefined_syndrome)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @predefined_syndrome.id,
    }

    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a question hasn\'t instance dependency' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @predefined_syndrome.id,
    }

    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end
end
