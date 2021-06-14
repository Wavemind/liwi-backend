# health cares for a final diagnosis
class FinalDiagnosisHealthCare < ApplicationRecord

  belongs_to :final_diagnosis
  belongs_to :health_care, foreign_key: :node_id

  scope :managements, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Management') }
  scope :drugs, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Drug') }

end
