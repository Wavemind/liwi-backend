# Define the different forms for a drug
class Formulation < ApplicationRecord

  enum medication_form: [:tablet, :capsule, :syrup, :suspension, :suppository, :drops, :solution, :patch, :cream, :ointment, :gel, :spray, :inhaler]
  enum breakable: [:one, :two, :four]

  belongs_to :node
  belongs_to :administration_route

  validates_presence_of :medication_form, :doses_per_day
  validates_presence_of :minimal_dose_per_kg, :maximal_dose_per_kg, :maximal_dose, :dose_form, if: Proc.new { %w(tablet capsule syrup suspension).include?(self.medication_form) && !( self.by_age == '1' || self.by_age == true)}
  validates_presence_of :liquid_concentration, if: Proc.new { %w(syrup suspension).include?(self.medication_form) && !( self.by_age == '1' || self.by_age == true)}
  validates_presence_of :breakable, if: Proc.new { %w(tablet).include?(self.medication_form) && !( self.by_age == '1' || self.by_age == true)}
  validates_presence_of :unique_dose, unless: Proc.new { %w(tablet capsule syrup suspension).include?(self.medication_form) || ( self.by_age == '1' || self.by_age == true) }

  after_validation :validate_dosage_logic, if: Proc.new { %w(tablet capsule syrup suspension).include?(self.medication_form) && !( self.by_age == '1' || self.by_age == true)}

  def validate_dosage_logic
    errors.add(:minimal_dose_per_kg, I18n.t('formulations.errors.minimum_higher_than_maximum')) if minimal_dose_per_kg > maximal_dose_per_kg
    errors.add(:maximal_dose_per_kg, I18n.t('formulations.errors.maximum_per_kg_higher_than_maximum')) if maximal_dose_per_kg > maximal_dose
  end

end
