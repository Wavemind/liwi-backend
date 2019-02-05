# How a disease is diagnosed -> Differential diagnostics
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  has_many :enabled_diagnostics
  has_many :algorithm_versions, through: :enabled_diagnostics
  has_many :final_diagnostics
  has_many :conditions, as: :referenceable

  has_many :relations, as: :relationable

  validates_presence_of :reference
  validates_presence_of :label

  private

  # {Node#unique_reference}
  def unique_reference
    if Diagnostic.where(reference: "#{I18n.t('diagnostics.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}_#{reference}"
  end



end
