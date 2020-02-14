# Answers give for a medical case
class MedicalCaseAnswer < ApplicationRecord

  belongs_to :medical_case
  belongs_to :version
  belongs_to :answer

  validates_presence_of :value

end
