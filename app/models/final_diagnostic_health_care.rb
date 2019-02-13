# health cares for a final diagnostic
class FinalDiagnosticHealthCare < ApplicationRecord

  belongs_to :final_diagnostic
  belongs_to :node

  scope :managements, ->() { joins(:node).includes(:node).where('nodes.type = ?', 'Management') }
  scope :treatments, ->() { joins(:node).includes(:node).where('nodes.type = ?', 'Treatment') }

end
