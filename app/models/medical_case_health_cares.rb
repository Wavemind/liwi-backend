# health cares selected for a medical case
class MedicalCaseHealthCare < ApplicationRecord

  belongs_to :node
  belongs_to :medical_case

end
