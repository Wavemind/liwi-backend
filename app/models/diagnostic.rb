# How a disease is diagnosed
class Diagnostic < ApplicationRecord

  has_many :algorithm_version_diagnostics
  has_many :algorithm_versions, through: :algorithm_version_diagnostics

  validates_presence_of :reference
  validates_presence_of :label

  validates_uniqueness_of :reference

  before_create :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}_#{reference}"
  end

end
