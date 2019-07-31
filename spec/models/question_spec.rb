require 'rails_helper'

RSpec.describe Question, type: :model do
  create_algorithm

  before(:each) do
    @answer_type = AnswerType.new(value: 'Array', display: 'Radiobutton')
  end

  it 'is valid with valid attributes' do
    question = Questions::Symptom.new(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to be_valid
  end

  it 'is invalid with invalid attributes' do
    question = Questions::Symptom.new(reference: '4', label: 'skin issue', priority: nil, answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to_not be_valid
  end

  it 'is invalid same reference' do
    Questions::Symptom.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
    question = Questions::Symptom.new(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)

    expect(question).to_not be_valid
  end

  it 'creates automatically 2 answers when answer_type is boolean' do
    boolean_type = AnswerType.new(value: 'Boolean', display: 'Radiobutton')
    question = Questions::Symptom.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: boolean_type, algorithm: @algorithm)

    expect(question.answers.count).to eq(2)
  end

  it 'does not create automatically 3 answers when answer_type is boolean, unavailable is true but wrong category' do
    boolean_type = AnswerType.new(value: 'Boolean', display: 'Radiobutton')
    question = Questions::Symptom.create!(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: boolean_type, algorithm: @algorithm, unavailable: '1')

    expect(question.answers.count).to eq(2)
  end

  context 'it validates formula correctly' do
    before(:each) do
      @question = Questions::Symptom.new(reference: '9', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
    end

    it 'Pass through with a correct formula' do
      @question.formula = "8 * 5"

      expect(@question).to be_valid
    end

    it 'Refuses incorrect characters' do
      @question.formula = "8 * 5 + x"

      expect(@question).to_not be_valid
    end

    it 'Pass through with a correct formula within a reference' do
      integer = AnswerType.create!(value: 'Integer', display: 'Input')
      Questions::Symptom.create!(reference: '10', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: integer, algorithm: @algorithm)

      @question.formula = "[S10] * 10"
      expect(@question).to be_valid
    end

    it 'Refuses if any reference is wrong' do
      @question.formula = "[W10] * 10"

      expect(@question).to_not be_valid
    end

    it 'Refuses if the reference used is not a numeric format' do
      Questions::Symptom.create!(reference: '10', label: 'skin issue', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
      @question.formula = "[S10] * 10"

      expect(@question).to_not be_valid
    end
  end
end
