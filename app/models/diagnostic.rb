# How a disease is diagnosed
class Diagnostic < ApplicationRecord

  has_many :questions
  has_many :algorithm_version_diagnostics, through: :questions

  validates_presence_of :value
  validates_presence_of :display

end
