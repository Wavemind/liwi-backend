require 'rails_helper'

RSpec.describe Question, type: :model do
  create_answer_type
  create_algorithm

  before(:each) do
    @answer_type = AnswerType.new(value: 'Array', display: 'Radiobutton')
  end

  it 'is valid with valid attributes' do
    question = Questions::Symptom.new(label: 'skin issue', stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to be_valid
  end

  it 'is invalid with invalid attributes' do
    question = Questions::Symptom.new(label: 'skin issue', answer_type: @answer_type, algorithm: @algorithm)
    expect(question).to_not be_valid
  end

  it 'creates automatically 2 answers when answer_type is boolean' do
    boolean_type = AnswerType.new(value: 'Boolean', display: 'Radiobutton')
    question = Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: boolean_type, algorithm: @algorithm)

    expect(question.answers.count).to eq(2)
  end

  it 'does not create automatically 3 answers when answer_type is boolean, unavailable is true but wrong category' do
    boolean_type = AnswerType.new(value: 'Boolean', display: 'Radiobutton')
    question = Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: boolean_type, algorithm: @algorithm, unavailable: '1')

    expect(question.answers.count).to eq(2)
  end

  context 'it validates formula correctly' do
    before(:each) do
      @question = Questions::Symptom.new(label: 'skin issue', stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
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
      Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: integer, algorithm: @algorithm)

      @question.formula = "[S1] * 10"
      expect(@question).to be_valid
    end

    it 'Refuses if any reference is wrong' do
      @question.formula = "[W_10] * 10"

      expect(@question).to_not be_valid
    end

    it 'Refuses if the reference used is not a numeric format' do
      Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)
      @question.formula = "[S_10] * 10"

      expect(@question).to_not be_valid
    end

    it 'Pass through with a correct formula within a date reference and a function' do
      @question.formula = "[ToDay(D1)] * 10"
      expect(@question).to be_valid
    end

    it 'Fails because ToDay() use a numeric function (and not date)' do
      Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: @answer_type, algorithm: @algorithm)

      @question.formula = "[ToDay(S_10)] * 10"
      expect(@question).to_not be_valid
    end

    it 'Fails using a date without converting it with a function' do
      @question.formula = "[D_1] * 10"
      expect(@question).to_not be_valid
    end

    it 'Fails with invalid function format' do
      @question.formula = "[ToDay de D_1] * 10"
      expect(@question).to_not be_valid
    end
  end

  context 'it validates overlaps correctly' do
    before(:each) do
      integer = AnswerType.create!(value: 'Integer', display: 'Input')
      @question = Questions::Symptom.create!(label: 'skin issue', stage: Question.stages[:triage], answer_type: integer, algorithm: @algorithm)
    end

    it 'is not valid if one less is missing' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.one_less'))
    end

    it 'is not valid if one more_or_equal is missing' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.one_more_or_equal'))
    end

    it 'is not valid if less is greater than more or equal' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '100')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '5')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.less_equal_more_or_equal'))
    end

    it 'is valid with one less and one more or equal' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '5')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(0)
    end

    it 'is not valid if there is 2 less' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '50')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(2)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.one_less'))
    end

    it 'is not valid if between is not connected to less' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '50, 100')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.first_between_different_from_less'))
    end

    it 'is not valid if between is not connected to more or equal' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '5, 80')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.last_between_different_from_more_or_equal'))
    end

    it 'is not valid if betweens are not connected to each other' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '5, 50')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '60, 100')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(1)
      expect(@question.errors[:answers][0]).to eq(I18n.t('answers.validation.overlap.between_not_following'))
    end

    it 'is valid with one less, one more or equal and some betweens' do
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:less], value: '5')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '5, 60')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:between], value: '60, 100')
      @question.answers.create!(label_en: 'test', operator: Answer.operators[:more_or_equal], value: '100')

      @question.validate_overlap
      expect(@question.errors[:answers].count).to eq(0)
    end
  end
end
