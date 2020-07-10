# Every component of an algorithm
class Node < ApplicationRecord

  # DF are not linked to algorithm this way, but through diagnostic > version
  belongs_to :algorithm, optional: true

  has_many :children
  has_many :instances, dependent: :destroy
  has_many :medias, as: :fileable
  has_many :diagnostics

  has_many :final_diagnostic_health_cares
  has_many :final_diagnostics, through: :final_diagnostic_health_cares

  has_many :medical_case_health_cares
  has_many :medical_cases, through: :medical_case_health_cares

  accepts_nested_attributes_for :medias, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :label_en
  after_create :generate_reference

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
    instances.where.not(instanceable: self).any?
  end

  # @return [ActiveRecord::Association]
  # List of instances
  def dependencies
    instances.select{|i| i unless i.instanceable.is_a? Version}
  end

  # Check if question is used in a deployed version
  def used_in_deployed_version
    involved_versions_ids = []
    instances.map do |instance|
      if instance.instanceable.is_a? Version
        involved_versions_ids.push(instance.instanceable_id) unless involved_versions_ids.include?(instance.instanceable_id)
      elsif instance.instanceable.is_a? Diagnostic
        involved_versions_ids.push(instance.instanceable.version_id) unless involved_versions_ids.include?(instance.instanceable.version_id)
      else
        involved_versions_ids = questions_sequence_instanceables(instance.instanceable, involved_versions_ids)
      end
    end

    GroupAccess.where(end_date: nil, version_id: involved_versions_ids).any?
  end

  # Recursively check any questions sequence to get every involved instances
  def questions_sequence_instanceables(qs, versions = [])
    qs.instances.where.not(instanceable: qs).map do |instance|
      if instance.instanceable.is_a? Diagnostic
        versions.push(instance.instanceable.version_id) unless versions.include?(instance.instanceable.version_id)
      else
        questions_sequence_instanceables(instance.instanceable, versions)
      end
    end
    versions
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (yes & no) for PS and boolean questions
  def create_boolean
    self.answers << Answer.new(reference: '1', label_en: I18n.t('answers.predefined.yes'))
    self.answers << Answer.new(reference: '2', label_en: I18n.t('answers.predefined.no'))
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

  # Return the final type of node -> physical_exam, predefined_syndrome, drug, ...
  def category_name
    if self.is_a?(QuestionsSequence) || self.is_a?(Question) || self.is_a?(HealthCare)
      self.class.variable
    end
  end

  # Return reference with its prefix
  def full_reference
    reference_prefix + reference.to_s
  end

  # Generate the reference automatically using the type
  def generate_reference
    if algorithm.nodes.where(type: type).count > 1
      self.reference = algorithm.nodes.where(type: type).maximum(:reference) + 1
    else
      self.reference = 1
    end
    self.save
  end
end
