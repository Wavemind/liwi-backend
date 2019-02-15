# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  belongs_to :algorithm_version
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :relations, as: :relationable, dependent: :destroy

  validates_presence_of :reference
  validates_presence_of :label

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if Diagnostic.joins(algorithm_version: :algorithm)
         .where("reference = '#{I18n.t('diagnostics.reference')}_#{reference}' AND algorithms.id = '#{algorithm_version.algorithm.id}'").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}_#{reference}"
  end

end
