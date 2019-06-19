# health cares for a final diagnostic
class FinalDiagnosticHealthCare < ApplicationRecord

  belongs_to :final_diagnostic
  belongs_to :node

  after_validation :node_is_management_or_treatment

  scope :managements, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Management') }
  scope :treatments, ->() { joins(:node).where('nodes.type = ?', 'HealthCares::Treatment') }

  private

  # Throw error if the node attached to the final diagnostic is not a health care
  def node_is_management_or_treatment
    unless node.is_a?(HealthCare)
      errors.add(:node, I18n.t('medical_case.validation.wrong_node_type'))
    end
  end

end
