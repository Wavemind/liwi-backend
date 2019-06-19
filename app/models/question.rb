# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }

  attr_accessor :unavailable

  enum priority: [:basic, :mandatory]
  enum stage: [:registration, :triage, :test, :consultation]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :answer_type

  validates_presence_of :priority

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Preload the children of class Question
  def self.descendants
    [Questions::AssessmentTest, Questions::ChiefComplain, Questions::Demographic, Questions::Exposure, Questions::PhysicalExam, Questions::Symptom, Questions::Vaccine]
  end

  # Get the reference prefix according to the type
  def reference_prefix
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Get the reference prefix according to the type
  def self.reference_prefix_class(type)
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.questions.where(reference: reference_prefix + reference).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = reference_prefix + reference
  end

  def self.display_label
    I18n.t("questions.categories.#{self.variable}.label")
  end
end
