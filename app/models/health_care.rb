# Define every treatments for a diagnostic
class HealthCare < Node

  scope :managements, ->() { where('type = ?', 'HealthCares::Management') }
  scope :treatments, ->() { where('type = ?', 'HealthCares::Treatment') }

  # Preload the children of class Question
  def self.descendants
    [HealthCares::Management, HealthCares::Treatment]
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
