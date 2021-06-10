# Define medical cases treated by the users
class MedicalCase < ApplicationRecord

  belongs_to :patient
  belongs_to :version

  has_many :medical_case_answers

  has_many :medical_case_health_cares
  has_many :nodes, through: :medical_case_health_cares

  has_many :medical_case_final_diagnoses
  has_many :final_diagnoses, through: :medical_case_final_diagnoses

end
