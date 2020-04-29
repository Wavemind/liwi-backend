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

  before_create :init_orders

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

  def is_deployed?
    group_accesses.where(end_date: nil).any?
  end

  # Init orders for new version
  def init_orders
    self.questions_orders = {
      basic_measurement: [],
      consultation_related: [],
      complaint_category: [],
      basic_demographic: [],
      demographic: [],
      unique_triage_physical_sign: [],
      unique_triage_question: []
    }
  end
end
