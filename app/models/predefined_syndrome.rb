# Define the children of an answer
class PredefinedSyndrome < Node
  before_destroy :diagnostic_dependencies

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :relations, as: :relationable, dependent: :destroy

  has_many :algorithm_version_predefined_syndromes
  has_many :algorithm_versions, through: :algorithm_version_predefined_syndromes

  private

  # {Node#unique_reference}
  def unique_reference
    if Management.where(reference: "#{I18n.t('predefined_syndromes.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('predefined_syndromes.reference')}_#{reference}"
  end

  private

  # Delete current predefined syndrome used in diagnostics
  def diagnostic_dependencies
    Relation.where(relationable_type: 'Diagnostic', node_id: id).destroy_all
  end

end
