# Define every drugs for a diagnostic
# Reference prefix : DR
class HealthCares::Drug < HealthCare

  accepts_nested_attributes_for :formulations, allow_destroy: true

  def self.variable
    'drug'
  end

end
