# Define every managements for a diagnostic
# Reference prefix : M
class HealthCares::Management < HealthCare

  def self.policy_class
    ManagementPolicy
  end

  def self.variable
    'management'
  end

end
