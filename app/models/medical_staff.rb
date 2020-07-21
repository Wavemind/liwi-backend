# Manage medical staffs
class MedicalStaff < ApplicationRecord

  belongs_to :health_facility

  enum role: [:registration_desk, :clinician, :triage_nurse, :lab, :pharmacist]

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  def full_name
    "#{first_name} #{last_name}"
  end

end
