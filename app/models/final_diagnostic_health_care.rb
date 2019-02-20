# health cares for a final diagnostic
class FinalDiagnosticHealthCare < ApplicationRecord

  belongs_to :final_diagnostic
  belongs_to :node

  after_validation :node_is_management_or_treatment

  scope :managements, ->() { joins(:node).includes(:node).where('nodes.type = ?', 'Management') }
  scope :treatments, ->() { joins(:node).includes(:node).where('nodes.type = ?', 'Treatment') }

  private

  def node_is_management_or_treatment
    unless node.is_a?(Management) || node.is_a?(Treatment)
      errors.add(:node, I18n.t('medical_case.validation.wrong_node_type'))
    end
  end

end
