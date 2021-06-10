# Define every drugs for a diagnosis
class HealthCare < Node

  scope :managements, ->() { where('type = ?', 'HealthCares::Management') }
  scope :drugs, ->() { where('type = ?', 'HealthCares::Drug') }

  # Preload the children of class Question
  def self.descendants
    [HealthCares::Management, HealthCares::Drug]
  end

  private

  def self.variable

  end

  def reference_prefix
    I18n.t("health_cares.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Display the label for the current child
  def self.display_label
    I18n.t("health_cares.categories.#{self.variable}.label")
  end

end
