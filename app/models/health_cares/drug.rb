# Define every drugs for a diagnosis
# Reference prefix : DR
class HealthCares::Drug < HealthCare

  has_many :formulations, foreign_key: 'node_id', dependent: :destroy

  accepts_nested_attributes_for :formulations, allow_destroy: true

  def self.policy_class
    DrugPolicy
  end

  def self.variable
    'drug'
  end

  def self.list_attributes
    attributes = {}
    attributes['medication_forms'] = Formulation.medication_forms.to_a.map(&:first)
    attributes['breakables'] = Formulation.breakables.map { |k, v| [I18n.t("formulations.breakables.#{k}.label"), k] }
    attributes['administration_routes'] = AdministrationRoute.generate_select_options
    attributes
  end

end
