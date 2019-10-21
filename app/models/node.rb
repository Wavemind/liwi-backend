# Every component of an algorithm
class Node < ApplicationRecord

  # DF are not linked to algorithm this way, but through diagnostic > version
  belongs_to :algorithm, optional: true
  has_many :children
  has_many :instances
  has_many :medias, as: :fileable

  has_many :final_diagnostic_health_cares
  has_many :final_diagnostics, through: :final_diagnostic_health_cares

  has_many :medical_case_health_cares
  has_many :medical_cases, through: :medical_case_health_cares

  accepts_nested_attributes_for :medias, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :label_en
  validates_presence_of :reference
  before_validation :unique_reference

  translates :label, :description

  # Puts nil instead of empty string when formula is not set in the view.
  nilify_blanks only: [:formula]

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{full_reference} - #{label}"
  end

  # @return [Boolean]
  # Verify if current node have instances dependencies
  def dependencies?
    instances.where.not(instanceable: self).where.not(instanceable_type: 'Version').any?
  end

  # @return [ActiveRecord::Association]
  # List of instances
  def dependencies
    instances.select{|i| i unless i.instanceable.is_a? Version}
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (yes & no) for PS and boolean questions
  def create_boolean
    self.answers << Answer.new(reference: '1', label_en: I18n.t('answers.yes'))
    self.answers << Answer.new(reference: '2', label_en: I18n.t('answers.no'))
    self.save
  end

  # @return [Array][Answers]
  # Return answers if any
  def get_answers
    if defined? answers
      answers
    end
  end

  # Return the parent type of node -> FinalDiagnostic/Question/QuestionsSequence/HealthCare
  def node_type
    self.is_a?(FinalDiagnostic) ? self.class.name : self.class.superclass.name
  end

  # Return the final type of node -> physical_exam, predefined_syndrome, treatment, ...
  def category_name
    if self.is_a?(QuestionsSequence) || self.is_a?(Question) || self.is_a?(HealthCare)
      self.class.variable
    end
  end

  # Return reference with its prefix
  def full_reference
    reference_prefix + reference
  end

  # Ensure the reference is unique
  def unique_reference
    self.errors.add(:reference, I18n.t('nodes.validation.reference_used')) if algorithm.nodes.where(type: type, reference: reference).where.not(id: id).any?
  end
end
