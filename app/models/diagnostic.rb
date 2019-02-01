# How a disease is diagnosed
class Diagnostic < ApplicationRecord

  has_many :algorithm_version_diagnostics
  has_many :algorithm_versions, through: :algorithm_version_diagnostics

  validates_presence_of :reference
  validates_presence_of :label

  before_create :complete_reference
  after_validation :unique_reference

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
