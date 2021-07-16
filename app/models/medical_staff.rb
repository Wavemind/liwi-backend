# Manage medical staffs
class MedicalStaff < ApplicationRecord

  belongs_to :health_facility

  enum role: [:medical_doctor, :assistant_medical_officer, :clinical_officer, :nurse, :pharmacist, :midwife, :registration_assistant]

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  def full_name
    "#{first_name} #{last_name}"
  end

end
