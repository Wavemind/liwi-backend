require 'rails_helper'

RSpec.describe QuestionsSequencesController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @predefined_syndrome = @algorithm.questions_sequences.create!(label_en: 'Label en', type: QuestionsSequences::PredefinedSyndrome)
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

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: {
      algorithm_id: @algorithm.id,
      instanceable_id: @predefined_syndrome.id,
      instanceable_type: @predefined_syndrome.class.name,
      questions_sequence:
        {
          algorithm: @algorithm,
          label_en: 'Severe LRTI'
        }
    }
    expect(response.status).to eq(200)
  end

  it 'should work for [get:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, id: @predefined_syndrome.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { algorithm_id: @algorithm.id, id: @predefined_syndrome.id, questions_sequence: { algorithm: @algorithm, label_en: 'Severe LRTI' } }
    expect(response.status).to eq(200)
  end

end
