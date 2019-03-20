require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  login_user
  create_algorithm
  create_answer_type
  create_category
  create_instances
  create_question

  it 'render answer if question is valid' do
    post :create, params: {
      algorithm_id: @algorithm.id,
      question: {
        label_en: 'Cough',
        reference: '5',
        category_id: @symptom.id,
        priority: 'basic',
        answer_type_id: @input_integer.id
      }
    }
    expect(response).to render_template('answers/new')
  end

  it 'redirect_to to algorithm if question\'s category is boolean and valid' do
    post :create, params: {
      algorithm_id: @algorithm.id,
      question: {
        label_en: 'Cough',
        reference: '2',
        category_id: @symptom.id,
        priority: 'basic',
        answer_type_id: @boolean.id
      }
    }
    expect(response).to redirect_to algorithm_url(@algorithm)
  end

  it 'render new if question is invalid' do
    post :create, params: {
      algorithm_id: @algorithm.id,
      question: {
        label_en: nil,
        reference: '5',
        category_id: @symptom.id,
        priority: 'basic',
        answer_type_id: @input_integer.id
      }
    }
    expect(response).to render_template(:new)
  end

  it 'create an answer for current question if attributes is valid' do
    @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)

    expect {
      put :answers, params: {
        algorithm_id: @algorithm.id,
        id: @question.id,
        question: {
          id: @question.id,
          answers_attributes: [
            {
              reference: '45',
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            }
          ]
        }
      }
    }.to change(Answer, :count).by(1)
  end

  it 'create multiple answers for current question if attributes is valid' do
    @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)

    expect {
      put :answers, params: {
        algorithm_id: @algorithm.id,
        id: @question.id,
        question: {
          id: @question.id,
          answers_attributes: [
            {
              reference: '45',
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            },
            {
              reference: '46',
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            }
          ]
        }
      }
    }.to change(Answer, :count).by(2)
  end

  it 'doesn\'t create an answer for current question if attributes is invalid' do
    @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)

    expect {
      put :answers, params: {
        algorithm_id: @algorithm.id,
        id: @question.id,
        question: {
          id: @question.id,
          answers_attributes: [
            {
              reference: nil,
              label_en: 'more than 12 months',
              value: '12',
              operator: :more_or_equal
            }
          ]
        }
      }
    }.to change(Answer, :count).by(0)
  end

  it 'adds translations without rendering the view' do
    @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
      question: {
        label_fr: 'Label en français',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 200)

    @question.reload
    expect(@question.label_fr).to eq('Label en français')
  end

  it 'returns error when sending attributes with clearing a mandatory field' do
    @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2', category: @symptom, priority: Question.priorities[:priority], answer_type: @boolean)

    put :update_translations, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
      question: {
        label_en: '',
      }
    }

    expect(response).to render_template('diagnostics/update_translations')
    expect(response).to have_attributes(status: 422)

  end

  it 'returns error message when trying to remove a question who has an instance' do
    Instance.create!(instanceable: @dd7, node: @question)

    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
    }

    expect(response).to redirect_to(@algorithm)
    expect(response).to have_attributes(status: 302)
    expect(flash[:alert]).to eq I18n.t('dependencies')
  end

  it 'returns success full message when removing a question hasn\'t instance dependecy' do
    delete :destroy, params: {
      algorithm_id: @algorithm.id,
      id: @question.id,
    }

    expect(response).to redirect_to(@algorithm)
    expect(response).to have_attributes(status: 302)
    expect(flash[:notice]).to eq I18n.t('flash_message.success_updated')
  end
end
