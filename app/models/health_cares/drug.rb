# Define every drugs for a diagnostic
# Reference prefix : DR
class HealthCares::Drug < HealthCare

  has_many :drug_formulations

  def self.variable
    'drug'
  end

end
