# Define every treatments for a diagnostic
# Reference prefix : T
class HealthCares::Treatment < HealthCare

  enum treatment_type: [:liquid, :pill]

  validates_presence_of :minimal_dose_per_kg, :maximal_dose_per_kg, :maximal_dose, :doses_per_day, :treatment_type
  validates_presence_of :pill_size, if: Proc.new { self.pill? }

  def self.variable
    'treatment'
  end

end
