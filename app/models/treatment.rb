# Define every treatments for a diagnostic
class Treatment < HealthCare

  before_create :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('treatments.reference')}_#{reference}"
  end

end
