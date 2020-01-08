# Define every treatments for a diagnostic
# Reference prefix : T
class HealthCares::Treatment < HealthCare

  enum treatment_type: [:liquid, :pill]

  def self.variable
    'treatment'
  end

end
