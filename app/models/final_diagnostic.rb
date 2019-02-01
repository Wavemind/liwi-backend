# Define a final diagnostic
class FinalDiagnostic < Node

  belongs_to :diagnostic

  has_many :final_diagnostic_health_cares
  has_many :medical_case_final_diagnostics
  has_many :medical_cases, through: :medical_case_final_diagnostics

end
