# Intermediary table between medical cases and final diagnoses
class MedicalCaseFinalDiagnosis < ApplicationRecord

  belongs_to :final_diagnosis
  belongs_to :medical_case

end
