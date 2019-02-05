# Define the conditions for a relation
class Condition < ApplicationRecord

  belongs_to :referenceable, polymorphic: true
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

  scope :top_level, -> { where(top_level: true) }
  scope :low_level, -> { where(top_level: false) }

end
