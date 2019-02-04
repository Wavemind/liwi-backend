# Define the children of an answer
class PredefinedSyndrom < Node

  has_many :answers, foreign_key: 'node_id'
  has_many :relations, as: :relationable

  private

  # {Node#unique_reference}
  def unique_reference
    if Management.where(reference: "#{I18n.t('predifned_syndroms.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('managements.reference')}_#{reference}"
  end
end
