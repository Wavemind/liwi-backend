# Define medical cases treated by the users
class MedicalCase < ApplicationRecord

  belongs_to :patient
  belongs_to :algorithm_version

end
