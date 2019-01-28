# How a disease is diagnosed
class Diagnostic < ApplicationRecord

  has_many :algorithm_version_diagnostics
  has_many :algorithm_versions, through: :algorithm_version_diagnostics

  validates_presence_of :reference
  validates_presence_of :label

  validates_uniqueness_of :reference

end
