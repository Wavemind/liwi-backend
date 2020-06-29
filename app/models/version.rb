# Version of an algorithm with its logic
class Version < ApplicationRecord

  attr_accessor :triage_id
  attr_accessor :cc_id

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnostics, dependent: :destroy
  has_many :medical_case_answers

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  belongs_to :top_left_question, class_name: 'Instance', optional: true
  belongs_to :first_top_right_question, class_name: 'Instance', optional: true
  belongs_to :second_top_right_question, class_name: 'Instance', optional: true

  before_create :init_config

  validates_presence_of :name
  validates_presence_of :description

  amoeba do
    enable
    include_association :diagnostics
    include_association :components
    append name: I18n.t('duplicated')
  end

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

  # Return an array of all questions that can be instantiate in a version
  def instanceable_questions
    questions = algorithm.questions.where(stage: %w(registration triage)).or(algorithm.questions.where(type: 'VitalSignAnthropometric'))

    questions_json = []
    questions.map do |question|
      questions_json.push({value: question.id, label: question.reference_label})
    end
    questions_json
  end

  # Return an array of all questions that has been instantiated
  def instanciated_questions
    questions = components.map(&:node)

    questions_json = []
    questions.map do |question|
      questions_json.push({value: question.id, label: question.reference_label})
    end
    questions_json
  end

  def is_deployed?
    # TODO : Test currently disabled so the version can be updated during development phase. To be removed !
    # group_accesses.where(end_date: nil).any?
    false
  end

  # Init orders for new version
  def init_config
    self.medal_r_config = {
      questions_orders: {
        basic_measurement: [],
        consultation_related: [],
        complaint_category: [],
        basic_demographic: [],
        demographic: [],
        unique_triage_physical_sign: [],
        unique_triage_question: []
      },
      patient_list_order: [],
      medical_case_list_order: [],
    }
  end
end
