# Define every drugs for a diagnosis
class HealthCare < Node

  has_many :node_exclusions, foreign_key: 'excluding_node_id'

  scope :managements, ->() { where('type = ?', 'HealthCares::Management') }
  scope :drugs, ->() { where('type = ?', 'HealthCares::Drug') }

  before_destroy :remove_exclusions

  # Preload the children of class Question
  def self.descendants
    [HealthCares::Management, HealthCares::Drug]
  end

  private

  def self.variable

  end

  # Display the label for the current child
  def self.display_label
    I18n.t("health_cares.categories.#{self.variable}.label")
  end

  def reference_prefix
    I18n.t("health_cares.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

end
