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
    birth_date = questions.create!(reference: '1', label_en: 'Birth date', type: 'Questions::Demographic', stage: Question.stages[:registration], priority: Question.priorities[:mandatory], answer_type_id: 6, is_default: true)
    weight = questions.create!(reference: '1', label_en: 'Weight', type: 'Questions::VitalSign', stage: Question.stages[:triage], priority: Question.priorities[:mandatory], answer_type_id: 4, is_default: true)
    hr = questions.create!(reference: '4', label_en: 'Heart rate', type: 'Questions::VitalSign', stage: Question.stages[:consultation], priority: Question.priorities[:basic], answer_type_id: 4, is_default: true)
    rr = questions.create!(reference: '5', label_en: 'Respiratory rate', type: 'Questions::VitalSign', stage: Question.stages[:consultation], priority: Question.priorities[:basic], answer_type_id: 4, is_default: true)

    age = questions.create!(reference: '2', label_en: 'Age in months', type: 'Questions::Demographic', stage: Question.stages[:registration], priority: Question.priorities[:mandatory], answer_type_id: 3, formula: '[D_1]', is_default: true)
    age.answers.create([
      {reference: 1, label_en: 'less than 2 months', value: '2', operator: Answer.operators[:less]},
      {reference: 2, label_en: 'between 2 and 6 months', value: '2, 6', operator: Answer.operators[:between]},
      {reference: 3, label_en: 'between 6 and 12 months', value: '6, 12', operator: Answer.operators[:between]},
      {reference: 4, label_en: 'between 12 and 24 months', value: '12, 24', operator: Answer.operators[:between]},
      {reference: 5, label_en: 'between 24 and 36 months', value: '24, 36', operator: Answer.operators[:between]},
      {reference: 6, label_en: 'between 36 and 60 months', value: '36, 60', operator: Answer.operators[:between]},
      {reference: 7, label_en: 'more than 60 months', value: '60', operator: Answer.operators[:more_or_equal]},
     ])

    z_score = questions.create!(reference: '1', label_en: 'Weight for age (z-score)', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], priority: Question.priorities[:mandatory], answer_type_id: 3, reference_table_x_id: birth_date.id, reference_table_y_id: weight.id, reference_table_male: File.read(File.join(Rails.root, "app/assets/reference_tables/z_score_male_table.json")), reference_table_female: File.read(File.join(Rails.root, "app/assets/reference_tables/z_score_female_table.json")), is_default: true)
    z_score.answers.create([
       {reference: 1, label_en: 'less than -3 z-score', value: '-3', operator: Answer.operators[:less]},
       {reference: 2, label_en: '-2 z-score', value: '-3, -2', operator: Answer.operators[:between]},
       {reference: 3, label_en: 'more than -2 z-score', value: '-2', operator: Answer.operators[:more_or_equal]},
     ])

    hr_th = questions.create!(reference: '8', label_en: 'Heart rate in percentile', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], priority: Question.priorities[:mandatory], answer_type_id: 3, reference_table_x_id: birth_date.id, reference_table_y_id: hr.id, reference_table_male: File.read(File.join(Rails.root, "app/assets/reference_tables/heart_rate_table.json")), reference_table_female: File.read(File.join(Rails.root, "app/assets/reference_tables/heart_rate_table.json")), is_default: true)
    hr_th.answers.create([
       {reference: 1, label_en: 'less than 90th', value: '90', operator: Answer.operators[:less]},
       {reference: 3, label_en: 'more than 90th', value: '90', operator: Answer.operators[:more_or_equal]},
     ])

    rr_th = questions.create!(reference: '9', label_en: 'Respiratory rate in percentile', type: 'Questions::PhysicalExam', stage: Question.stages[:consultation], priority: Question.priorities[:mandatory], answer_type_id: 3, reference_table_x_id: birth_date.id, reference_table_y_id: rr.id, reference_table_male: File.read(File.join(Rails.root, "app/assets/reference_tables/respiratory_rate_table.json")), reference_table_female: File.read(File.join(Rails.root, "app/assets/reference_tables/respiratory_rate_table.json")), is_default: true)
    rr_th.answers.create([
       {reference: 1, label_en: 'less than 75th', value: '75', operator: Answer.operators[:less]},
       {reference: 2, label_en: 'between 75th and 97th', value: '75, 97', operator: Answer.operators[:between]},
       {reference: 3, label_en: 'more than 97th', value: '97', operator: Answer.operators[:more_or_equal]},
     ])
  end
end
