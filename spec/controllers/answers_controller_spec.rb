require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_question

  it 'adds translations without rendering the view' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      question_id: @question.id,
      id: @question.answers.first.id,
      answer: {
        label_fr: 'oui',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @question.answers.first.reload
    expect(@question.answers.first.label_fr).to eq('oui')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      question_id: @question.id,
      id: @question.answers.first.id,
      answer: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id, question_id: @question.id }
    expect(response.status).to eq(200)
  end

  # TODO: Check if this method is used
  it 'should work for [PATCH:update]' do
    patch :update, params: { algorithm_id: @algorithm.id, question_id: @question.id, id: @question.answers.first.id, answer: {reference: '4', label: 'True', operator: nil, value: 'true', node: @question}}
    expect(response.status).to eq(302)
  end

end
