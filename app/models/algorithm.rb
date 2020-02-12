# Container of many versions of algorithms
class Algorithm < ApplicationRecord

  has_many :versions
  has_many :nodes, dependent: :destroy
  has_many :questions, -> { where type: Question.descendants.map(&:name) }, source: :node
  has_many :health_cares, -> { where type: HealthCare.descendants.map(&:name) }, source: :node
  has_many :questions_sequences, -> { where type: QuestionsSequence.descendants.map(&:name) }, source: :node

  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :create_reference_table_questions

  # Create all hardcoded questions related to reference tables and age.
  # Answer types ids : 3 is Integer, 4 is Decimal, 6 is Date
  def create_reference_table_questions
    birth_date = questions.create!(label_en: 'Birth date', type: 'Questions::Demographic', stage: Question.stages[:registration], is_mandatory: true, answer_type_id: 6, is_default: true)
    age_in_days = questions.create!(label_en: 'Age in days', type: 'Questions::VitalSignTriage', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 5, formula: '[ToDay(D1)]', is_default: true)
    weight = questions.create!(label_en: 'Weight (kg)', type: 'Questions::VitalSignTriage', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 4, is_default: true)
    hr = questions.create!(label_en: 'Heart rate', type: 'Questions::VitalSignConsultation', stage: Question.stages[:consultation], answer_type_id: 4, is_default: true)
    rr = questions.create!(label_en: 'Respiratory rate', type: 'Questions::VitalSignConsultation', stage: Question.stages[:consultation], answer_type_id: 4, is_default: true)

    age = questions.create!(label_en: 'Age in months', type: 'Questions::Demographic', stage: Question.stages[:registration], is_mandatory: true, answer_type_id: 5, formula: '[ToMonth(D1)]', is_default: true)
    age.answers.create([
      {label_en: 'less than 2 months', value: '2', operator: Answer.operators[:less]},
      {label_en: 'between 2 and 6 months', value: '2, 6', operator: Answer.operators[:between]},
      {label_en: 'between 6 and 12 months', value: '6, 12', operator: Answer.operators[:between]},
      {label_en: 'between 12 and 24 months', value: '12, 24', operator: Answer.operators[:between]},
      {label_en: 'between 24 and 36 months', value: '24, 36', operator: Answer.operators[:between]},
      {label_en: 'between 36 and 60 months', value: '36, 60', operator: Answer.operators[:between]},
      {label_en: 'more than 60 months', value: '60', operator: Answer.operators[:more_or_equal]},
     ])

    z_score = questions.create!(label_en: 'Weight for age (z-score)', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], is_mandatory: true, answer_type_id: 3, reference_table_x_id: age_in_days.id, reference_table_y_id: weight.id, reference_table_male: "z_score_male_table", reference_table_female: "z_score_female_table", is_default: true)
    z_score.answers.create([
       {label_en: 'less than -3 z-score', value: '-3', operator: Answer.operators[:less]},
       {label_en: '-2 z-score', value: '-3, -2', operator: Answer.operators[:between]},
       {label_en: 'more than -2 z-score', value: '-2', operator: Answer.operators[:more_or_equal]},
     ])

    hr_th = questions.create!(label_en: 'Heart rate in percentile', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], is_mandatory: true, answer_type_id: 3, reference_table_x_id: age.id, reference_table_y_id: hr.id, reference_table_male: "heart_rate_table", reference_table_female: "heart_rate_table", is_default: true)
    hr_th.answers.create([
       {label_en: 'less than 90th', value: '90', operator: Answer.operators[:less]},
       {label_en: 'more than 90th', value: '90', operator: Answer.operators[:more_or_equal]},
     ])

    rr_th = questions.create!(label_en: 'Respiratory rate in percentile', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], is_mandatory: true, answer_type_id: 3, reference_table_x_id: age.id, reference_table_y_id: rr.id, reference_table_male: "respiratory_rate_table", reference_table_female: "respiratory_rate_table", is_default: true)
    rr_th.answers.create([
       {label_en: 'less than 75th', value: '75', operator: Answer.operators[:less]},
       {label_en: 'between 75th and 97th', value: '75, 97', operator: Answer.operators[:between]},
       {label_en: 'more than 97th', value: '97', operator: Answer.operators[:more_or_equal]},
     ])
  end
end
