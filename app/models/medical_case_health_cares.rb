# health cares selected for a medical case
class MedicalCaseHealthCare < ApplicationRecord

  belongs_to :treatable, polymorphic: true
  belongs_to :medical_case

end
