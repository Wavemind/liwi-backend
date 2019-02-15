# Define every treatments for a diagnostic
class Treatment < Node

  private

  # {Node#unique_reference}
  def unique_reference
    if self.algorithm.treatments.where(reference: "#{I18n.t('treatments.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('treatments.reference')}_#{reference}"
  end
end
