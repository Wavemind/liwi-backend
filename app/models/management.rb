# Define every managements for a diagnostic
class Management < HealthCare

  before_create :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('managements.reference')}_#{reference}"
  end

end
