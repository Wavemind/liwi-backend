# Define every managements for a diagnostic
class Management < HealthCare

  before_validation :complete_reference

  def complete_reference
    self.reference = "#{I18n.t('managements.reference')}_#{reference}" if reference.present? && !reference.start_with?("#{I18n.t('managements.reference')}_")
  end

end
