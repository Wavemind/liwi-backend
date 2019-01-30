# Define every treatments for a diagnostic
class Treatment < HealthCare

  before_validation :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('treatments.reference')}_#{reference}" if reference.present? && !reference.start_with?("#{I18n.t('treatments.reference')}_")
  end

end
