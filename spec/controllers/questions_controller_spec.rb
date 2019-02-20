require 'rails_helper'

RSpec.describe QuestionsController, type: :controller, focus: :true do
  login_user
  create_algorithm
  create_answer_type
  create_category

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
              operator: '>='
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
              operator: '>='
            },
            {
              reference: '46',
              label_en: 'more than 12 months',
              value: '12',
              operator: '>='
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
              operator: '>='
            }
          ]
        }
      }
    }.to change(Answer, :count).by(0)
  end
end
