# Every component of an algorithm
class Node < ApplicationRecord

  # DF are not linked to algorithm this way, but through diagnostic > algorithm_version
  belongs_to :algorithm, optional: true
  has_many :children
  has_many :instances

  has_many :final_diagnostic_health_cares
  has_many :final_diagnostics, through: :final_diagnostic_health_cares

  has_many :medical_case_health_cares
  has_many :medical_cases, through: :medical_case_health_cares

  scope :managements, ->() { where(type: 'Management') }
  scope :treatments, ->() { where(type: 'Treatment') }

  validates_presence_of :label
  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  private

  # @params nil
  # @return nil
  # Validate the uniqueness after validation if it is present in order to simulate #complete_reference
  def unique_reference

  end

  # @params nil
  # @return nil
  # Complete the reference with the associated prefix before the entry is created
  def complete_reference

  end
end
