# Define every managements for a diagnostic
class Management < HealthCare

  private

  # {Node#unique_reference}
  def unique_reference
    if Management.where(reference: "#{I18n.t('managements.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end


  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('managements.reference')}_#{reference}"
  end


end
