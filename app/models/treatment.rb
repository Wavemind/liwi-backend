# Define every treatments for a diagnostic
class Treatment < Node

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.treatments.where(reference: "#{I18n.t('treatments.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('treatments.reference')}_#{reference}"
  end
end
