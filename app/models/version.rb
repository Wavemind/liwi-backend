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

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :algorithm
  after_validation :check_triage_questions

  after_create :instantiate_questions

  # Make sure that the question added to the triage order is a triage question
  def check_triage_questions
    triage_questions_order.each do |question_id|
      self.errors.add(:triage_questions_order, I18n.t('conditions.validation.loop')) unless Question.find(question_id).triage?
    end
  end

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

  # Create an instance per question who has triage stage or vital sign category
  def instantiate_questions
    algorithm.questions.triage.each do |question|
      components.create!(node: question)
    end
  end
end
