# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  belongs_to :version
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  validates_presence_of :reference
  validates_presence_of :label

  translates :label

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  # @return [ActiveRecord::Relation] of questions
  # Get every questions asked in a diagnostic
  def questions
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Question', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of predefined syndromes
  # Get every predefined syndromes used in a diagnostic
  def predefined_syndromes
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'PredefinedSyndrome', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of managements
  # Get every managements used in a diagnostic
  def managements
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Management', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of treatments
  # Get every treatments used in a diagnostic
  def treatments
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Treatment', id, self.class.name)
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if Diagnostic.joins(version: :algorithm)
         .where('reference = ? AND algorithms.id = ?', "#{I18n.t('diagnostics.reference')}_#{reference}", version.algorithm.id).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}_#{reference}"
  end
end
