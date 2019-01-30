# How a disease is diagnosed
class Diagnostic < ApplicationRecord

  has_many :algorithm_version_diagnostics
  has_many :algorithm_versions, through: :algorithm_version_diagnostics

  validates_presence_of :reference
  validates_presence_of :label

  validates_uniqueness_of :reference

  before_validation :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}_#{reference}" if reference.present? && !reference.start_with?("#{I18n.t('diagnostics.reference')}_")
  end

end
