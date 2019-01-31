# Define every treatments for a diagnostic
class Treatment < HealthCare

  private

  def complete_reference
    self.reference = "#{I18n.t('treatments.reference')}_#{reference}"
  end

  def unique_reference
    if Treatment.where(reference: "#{I18n.t('treatments.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end
end
