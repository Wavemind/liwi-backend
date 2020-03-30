# Define every drugs for a diagnostic
# Reference prefix : DR
class HealthCares::Drug < HealthCare

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
