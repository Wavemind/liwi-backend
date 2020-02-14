# Define every patients concerned by the medical cases
class Patient < ApplicationRecord

  has_many :medical_cases

  validates_presence_of :first_name
  validates_presence_of :last_name

end
