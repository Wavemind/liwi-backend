# health cares for a final diagnostic
class FinalDiagnosticHealthCare < ApplicationRecord

  belongs_to :final_diagnostic
  belongs_to :health_care, foreign_key: :node_id

  scope :managements, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Management') }
  scope :drugs, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Drug') }

end
