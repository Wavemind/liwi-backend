# Exclusion between two nodes
class NodeExclusion < ApplicationRecord

  enum node_type: [:drug, :final_diagnosis, :management]

  belongs_to :excluding_node, class_name: 'Node'
  belongs_to :excluded_node, class_name: 'Node'

  validates_presence_of :excluded_node_id, :excluding_node_id
  validates :excluded_node_id, uniqueness: { scope: :excluding_node_id, message: I18n.t('errors.final_diagnosis_exclusion_unique') }
  after_validation :prevent_loop


  # Recursive loop to make sure it is not excluding a grand child of excluded diagnosis
  def is_excluding_itself(node_id)
    NodeExclusion.where(excluding_node_id: node_id).map do |exclusion|
      return true if exclusion.excluded_node_id == excluding_node_id || is_excluding_itself(exclusion.excluded_node_id)
    end
    false
  end

  # Ensure that the user is not trying to loop with excluding diagnoses.
  def prevent_loop
    if excluding_node_id == excluded_node_id || is_excluding_itself(excluded_node_id)
      self.errors.add(:base, I18n.t('final_diagnoses.validation.loop'))
      raise ActiveRecord::Rollback, I18n.t('final_diagnoses.validation.loop')
    end
  end

  # Recreate exclusions from final diagnoses pointing to old version to final diagnoses pointing to duplicated version
  def self.recreate_exclusions_after_duplicate(matching_final_diagnoses)
    matching_final_diagnoses.each do |key, value|
      NodeExclusion.where(excluding_node_id: key).map do |exclusion|
        NodeExclusion.create(excluding_node_id: value, excluded_node_id: matching_final_diagnoses[exclusion.excluded_node_id])
      end
    end
  end
end
