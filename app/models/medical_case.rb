# Define medical cases treated by the users
class MedicalCase < ApplicationRecord

  belongs_to :patient
  belongs_to :version

  has_many :medical_case_health_cares
  has_many :nodes, through: :medical_case_health_cares

  has_many :medical_case_final_diagnostics
  has_many :final_diagnostics, through: :medical_case_final_diagnostics

end
