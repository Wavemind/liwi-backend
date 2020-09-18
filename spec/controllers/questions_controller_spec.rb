require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances
  create_question

  it 'create an answer for current question if attributes is invalid'  do
    @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @input_integer)

    expect {
      put :update, params: {
        id: @question.id,
        algorithm_id: @algorithm.id,
        from: 'rails',
        question: {
          id: @question.id,
          answers_attributes: [
            {
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            }
          ]
        }
      }
    }.to change(Answer, :count).by(0)
  end

  it 'create multiple answers for current question if attributes is valid' do
    @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @input_integer)

    expect {
      put :update, params: {
        id: @question.id,
        algorithm_id: @algorithm.id,
        from: 'rails',
        question: {
          id: @question.id,
          answers_attributes: [
            {
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            },
            {
              label_en: 'more than 12 months',
              value: '12',
              operator: :less
            }
          ]
        }
      }
    }.to change(Answer, :count).by(2)
  end

  it 'doesn\'t create an answer for current question if attributes is invalid' do
    @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @input_integer)

    expect {
      put :update, params: {
        id: @question.id,
        algorithm_id: @algorithm.id,
        from: 'rails',
        question: {
          id: @question.id,
          answers_attributes: [
            {
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            }
          ]
        }
      }
    }.to change(Answer, :count).by(0)
  end

  it 'returns error message when trying to remove a question who has an instance' do
    Instance.create!(instanceable: @dd7, node: @question)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'questions')
    expect(response).to have_attributes(status: 302)
    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a question hasn\'t instance dependency' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
    }

    expect(response).to redirect_to algorithm_url(@algorithm, panel: 'questions')
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end

  it 'create an unavailable answer if category is an assessment' do
    @question = Questions::AssessmentTest.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @boolean, unavailable: '1')

    expect(@question.answers.count).to equal(3)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', is_mandatory: true, stage: Question.stages[:triage], answer_type: @boolean)

    get :edit, params: { algorithm_id: @algorithm.id, id: @question.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, from: 'rails', question: {algorithm: @algorithm, label_en: 'Cough', is_mandatory: true, stage: 'triage', answer_type_id: @boolean.id} }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:update]' do
    @question = Questions::AssessmentTest.create!(algorithm: @algorithm, label_en: 'Cough', is_mandatory: true, stage: Question.stages[:triage], answer_type: @boolean, unavailable: '1')
    put :update, params: { algorithm_id: @algorithm.id, id: @question.id, from: 'rails', question: {id: @question.id, algorithm: @algorithm, label_en: 'Cough', is_mandatory: true, stage: 'triage', answer_type_id: @boolean.id} }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:reference_prefix]' do
    get :reference_prefix, params: { type: 'Questions::Demographic' }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:validate]' do
    put :validate, params: { algorithm_id: @algorithm.id, question: {algorithm: @algorithm, label_en: 'Cough', is_mandatory: true, stage: 'triage', answer_type_id: @boolean.id} }, xhr: true
    expect(response.status).to eq(200)
  end

end
