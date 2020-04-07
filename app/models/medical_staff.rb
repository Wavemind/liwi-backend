# Manage medical staffs
class MedicalStaff < ApplicationRecord

  belongs_to :group

  enum role: [:registration_nurse, :clinician]

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

end
