# Intermediary table between medical cases and final diagnostics
class MedicalCaseFinalDiagnostic < ApplicationRecord

  belongs_to :final_diagnostic
  belongs_to :medical_case

end
