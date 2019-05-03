# Define a final diagnostic
class FinalDiagnostic < Node

  belongs_to :diagnostic
  belongs_to :excluded_diagnostic, class_name: 'FinalDiagnostic', foreign_key: :final_diagnostic_id, optional: true

  has_many :medical_case_final_diagnostics
  has_many :medical_cases, through: :medical_case_final_diagnostics

  has_many :final_diagnostic_health_cares, dependent: :destroy
  has_many :nodes, through: :final_diagnostic_health_cares

  after_create :create_instance

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :final_diagnostic_health_cares
    append reference: I18n.t('duplicated')
  end

  private

  def create_instance
    diagnostic.components.create!(node: self)
  end

  # {Node#unique_reference}
  def unique_reference
    if FinalDiagnostic.joins(diagnostic: [version: :algorithm])
         .where('nodes.reference = ? AND algorithms.id = ?', "#{I18n.t('final_diagnostics.reference')}#{reference}", diagnostic.version.algorithm.id).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  # Scoped by the current algorithm
  def complete_reference
    self.reference = "#{I18n.t('final_diagnostics.reference')}#{reference}" unless self.reference.include?(I18n.t('duplicated'))
  end
end
