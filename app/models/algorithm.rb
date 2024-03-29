# Container of many versions of algorithms
include Rails.application.routes.url_helpers
class Algorithm < ApplicationRecord
  has_many :versions
  has_many :nodes, dependent: :destroy
  has_many :final_diagnoses, -> { where type: 'FinalDiagnosis' }, source: :node
  has_many :questions, -> { where type: Question.descendants.map(&:name) }, source: :node
  has_many :health_cares, -> { where type: HealthCare.descendants.map(&:name) }, source: :node
  has_many :questions_sequences, -> { where type: QuestionsSequence.descendants.map(&:name) }, source: :node

  belongs_to :user
  belongs_to :study

  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :create_reference_table_questions
  before_update :set_emergency_content_version

  translates :emergency_content

  # Create all hardcoded questions related to reference tables and age.
  # Answer types ids : 3 is Integer, 4 is Decimal, 6 is Date, 9 is String
  def create_reference_table_questions
    age_in_days = questions.create!(label_en: 'Age in days', type: 'Questions::BasicDemographic', stage: Question.stages[:registration], is_mandatory: true, answer_type_id: 5, formula: 'ToDay', is_default: true)
    weight = questions.create!(label_en: 'Current Weight (kg)', type: 'Questions::BasicMeasurement', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 4, estimable: true, is_default: true)
    rr = questions.create!(label_en: 'Respiratory rate', type: 'Questions::VitalSignAnthropometric', stage: Question.stages[:consultation], answer_type_id: 4, is_default: true)
    muac = questions.create!(label_en: 'MUAC in cm (only if age >6 months)', type: 'Questions::BasicMeasurement', description_en: 'Mid Upper Arm Circumference', stage: Question.stages[:triage], answer_type_id: 4, is_default: true)
    gender = questions.create!(label_en: 'Gender', type: 'Questions::Demographic', stage: Question.stages[:registration], answer_type_id: 2, is_mandatory: true, is_default: true)
    height = questions.create!(label_en: 'Height (cm) - if length is measured subtract 0.7cm', type: 'Questions::BasicMeasurement', stage: Question.stages[:triage], answer_type_id: 4, is_default: true)
    length = questions.create!(label_en: 'Length (cm)', type: 'Questions::BasicMeasurement', stage: Question.stages[:triage], answer_type_id: 4, is_default: true)
    bmi = questions.create!(label_en: 'BMI', type: 'Questions::BasicMeasurement', stage: Question.stages[:registration], step: Question.steps[:basic_measurements_step], answer_type_id: 5, formula: '[BM1] / (([BM3] / 100) * ([BM3] / 100))', is_default: true)
    temperature = questions.create!(label_en: 'Axillary temperature', type: 'Questions::BasicMeasurement', stage: Question.stages[:triage], answer_type_id: 4, is_default: true)
    cc_general = questions.create!(label_en: 'General', type: 'Questions::ComplaintCategory', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 1, is_default: true)
    yi_cc_general = questions.create!(label_en: 'General / Universal Assessment', type: 'Questions::ComplaintCategory', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 1, is_default: true, is_neonat: true)
    village = questions.create!(label_en: 'Village', type: 'Questions::BasicDemographic', stage: Question.stages[:registration], answer_type_id: 9, is_mandatory: true, is_identifiable: true, is_default: true)
    kind_of_consultation = questions.create!(label_en: 'What kind of consultation is this?', type: 'Questions::Demographic', stage: Question.stages[:registration], answer_type_id: 2, is_mandatory: true, is_default: true)

    wh = questions.create!(label_en: 'How did you measure the child height ?', type: 'Questions::BasicMeasurement', stage: Question.stages[:triage], is_mandatory: true, answer_type_id: 2, is_default: true)

    # Configure basic questions into the algorithm to be used in json generation
    self.update(medal_r_config: {
      basic_questions: {
        gender_question_id: gender.id,
        weight_question_id: weight.id,
        general_cc_id: cc_general.id,
        yi_general_cc_id: yi_cc_general.id,
      },
      optional_basic_questions: {
        village_question_id: village.id,
        kind_of_consultation_id: kind_of_consultation.id,
      }
    })

    def upp(a_id, n_id)
      Node.find(n_id).update(is_default: true);
      al = Algorithm.find(a_id);
      config = al.medal_r_config;
      config['optional_basic_questions']['kind_of_consultation_id'] = n_id;
      al.update(medal_r_config: config)
    end

    gender.answers.create([
      {label_en: 'Male', value: 'male'},
      {label_en: 'Female', value: 'female'}
    ])

    kind_of_consultation.answers.create([
      {label_en: 'New (self-referral)'},
      {label_en: 'New (referral from another facility)'},
      {label_en: 'Scheduled follow-up'},
      {label_en: 'Unscheduled follow-up'}
    ])

    age = questions.create!(label_en: 'Age in months', type: 'Questions::BackgroundCalculation', is_mandatory: true, answer_type_id: 5, formula: 'ToMonth', is_default: true)
    age.answers.create([
      {label_en: 'less than 2 months', value: '2', operator: Answer.operators[:less]},
      {label_en: 'between 2 and 6 months', value: '2, 6', operator: Answer.operators[:between]},
      {label_en: 'between 6 and 12 months', value: '6, 12', operator: Answer.operators[:between]},
      {label_en: 'between 12 and 24 months', value: '12, 24', operator: Answer.operators[:between]},
      {label_en: 'between 24 and 36 months', value: '24, 36', operator: Answer.operators[:between]},
      {label_en: 'between 36 and 60 months', value: '36, 60', operator: Answer.operators[:between]},
      {label_en: 'more than 60 months', value: '60', operator: Answer.operators[:more_or_equal]},
     ])

    z_score = questions.create!(label_en: 'Weight for age (z-score)', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: age_in_days.id, reference_table_y_id: weight.id, reference_table_male: "z_score_male_table", reference_table_female: "z_score_female_table", is_default: true)
    z_score.answers.create([
       {label_en: 'less than -2 z-score', value: '-2', operator: Answer.operators[:less]},
       {label_en: '-2 z-score', value: '-2, -1', operator: Answer.operators[:between]},
       {label_en: 'more than -2 z-score', value: '-1', operator: Answer.operators[:more_or_equal]},
     ])

    bmi_z_score = questions.create!(label_en: 'BMI (z-score)', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: age_in_days.id, reference_table_y_id: bmi.id, reference_table_male: "bmi_for_age_male_table", reference_table_female: "bmi_for_age_female_table", is_default: true)
    bmi_z_score.answers.create([
       {label_en: 'less than -2 z-score', value: '-2', operator: Answer.operators[:less]},
       {label_en: '-2 z-score', value: '-2, -1', operator: Answer.operators[:between]},
       {label_en: 'more than -2 z-score', value: '-1', operator: Answer.operators[:more_or_equal]},
     ])

    weight_for_height = questions.create!(label_en: 'Weight for height', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: height.id, reference_table_y_id: weight.id, reference_table_male: "weight_for_height_male_table", reference_table_female: "weight_for_height_female_table", is_default: true)
    weight_for_height.answers.create([
       {label_en: 'less than -2 z-score', value: '-2', operator: Answer.operators[:less]},
       {label_en: '-2 z-score', value: '-2, -1', operator: Answer.operators[:between]},
       {label_en: 'more than -2 z-score', value: '-1', operator: Answer.operators[:more_or_equal]},
    ])

    weight_for_length = questions.create!(label_en: 'Weight for length', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: length.id, reference_table_y_id: weight.id, reference_table_male: "weight_for_length_male_table", reference_table_female: "weight_for_length_female_table", is_default: true)
    weight_for_length.answers.create([
       {label_en: 'less than -2 z-score', value: '-2', operator: Answer.operators[:less]},
       {label_en: '-2 z-score', value: '-2, -1', operator: Answer.operators[:between]},
       {label_en: 'more than -2 z-score', value: '-1', operator: Answer.operators[:more_or_equal]},
     ])

    rr_th = questions.create!(label_en: 'Respiratory rate in percentile', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: age.id, reference_table_y_id: temperature.id, reference_table_z_id: rr.id, reference_table_male: "respiratory_rate_table", reference_table_female: "respiratory_rate_table", is_default: true)
    rr_th.answers.create([
       {label_en: 'less than 75th', value: '75', operator: Answer.operators[:less]},
       {label_en: 'between 75th and 97th', value: '75, 97', operator: Answer.operators[:between]},
       {label_en: 'more than 97th', value: '97', operator: Answer.operators[:more_or_equal]},
     ])

    muac_z_score = questions.create!(label_en: 'MUAC for age z-score', type: 'Questions::BackgroundCalculation', answer_type_id: 3, reference_table_x_id: age_in_days.id, reference_table_y_id: muac.id, reference_table_male: "muac_z_score_male_table", reference_table_female: "muac_z_score_female_table", is_default: true)
    muac_z_score.answers.create([
      {label_en: 'less than -2 z-score', value: '-2', operator: Answer.operators[:less]},
      {label_en: '-2 z-score', value: '-2, -1', operator: Answer.operators[:between]},
      {label_en: 'more than -2 z-score', value: '-1', operator: Answer.operators[:more_or_equal]},
     ])
  end

  def display_versions_badges
    badges = ''
    versions.map do |version|
      badges += " <span class='badge badge-info'><a href='#{algorithm_version_url(id, version.id)}'>#{version.name}</a></span>"
    end
    badges
  end

  def display_archive_status
    archived ? '<span class="badge badge-danger">archived</span>' : ''
  end

  # Update emergency content version if the emergency content is updated
  def set_emergency_content_version
    if changes['emergency_content_translations'].present?
      self.emergency_content_version += 1
    end
  end
end
