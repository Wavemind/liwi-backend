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

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.health_cares.where(reference: reference_prefix + reference).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = reference_prefix + reference
  end

  def reference_prefix
    I18n.t("health_cares.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  def self.display_label
    I18n.t("health_cares.categories.#{self.variable}.label")
  end

end
