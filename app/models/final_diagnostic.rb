# Define a final diagnostic
class FinalDiagnostic < Node

  belongs_to :diagnostic
  belongs_to :excluded_diagnostic, class_name: 'FinalDiagnostic', foreign_key: :final_diagnostic_id, optional: true

  has_many :medical_case_final_diagnostics
  has_many :medical_cases, through: :medical_case_final_diagnostics

  has_many :final_diagnostic_health_cares
  has_many :nodes, through: :final_diagnostic_health_cares

  private

  # {Node#unique_reference}
  def unique_reference
    if FinalDiagnostic.joins(diagnostic: [algorithm_version: :algorithm])
         .where("nodes.reference = ? AND algorithms.id = ?", "#{I18n.t('final_diagnostics.reference')}_#{reference}", "#{diagnostic.version.algorithm.id}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  # Scoped by the current algorithm
  def complete_reference
    self.reference = "#{I18n.t('final_diagnostics.reference')}_#{reference}"
  end
end
