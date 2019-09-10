# health cares selected for a medical case
class MedicalCaseHealthCare < ApplicationRecord

  belongs_to :node
  belongs_to :medical_case

  after_validation :node_is_management_or_treatment

  private

  # Throw error if the node attached to the medical case is not a health care
  def node_is_management_or_treatment
    unless node.is_a?(HealthCare)
      errors.add(:node, I18n.t('medical_case.validation.wrong_node_type'))
    end
  end
end
