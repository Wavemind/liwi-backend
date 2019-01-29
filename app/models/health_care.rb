# Define every health cares for a diagnostic (treatments or managements)
class HealthCare < Node

  has_many :diagnostic_health_cares
  has_many :diagnostics, through: :diagnostic_health_cares

end
