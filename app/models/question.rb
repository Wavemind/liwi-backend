# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :push_in_versions, if: Proc.new { stage == 'triage' }
  before_destroy :remove_from_versions, if: Proc.new { stage == 'triage' }

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
    return '' unless type.present?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Get the reference prefix according to the type
  def self.reference_prefix_class(type)
    return '' unless type.present?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Return hash of categories for the front-end
  def self.categories
    categories = []
    self.descendants.each do |category|
      current_category = {}
      current_category['label'] = category.display_label
      current_category['name'] = category.name
      current_category['reference_prefix'] = self.reference_prefix_class(category.name)
      categories.push(current_category)
    end
    categories
  end

  # When a question from triage stage is created, push it at the end of the versions order
  def push_in_versions
    algorithm.versions.each do |version|
      version.update(triage_questions_order: version.triage_questions_order.push(id))
    end
  end

  # Remove the triage question from the version triage orders
  def remove_from_versions
    algorithm.versions.each do |version|
      version.update(triage_questions_order: version.triage_questions_order.delete(id)) if version.triage_questions_order.include?(id)
    end
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if type.blank?
      errors.add(:type, I18n.t('questions.errors.no_blank'))
    elsif algorithm.questions.where(reference: reference_prefix + reference).any?
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
