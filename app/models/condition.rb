# Define the conditions for a relation
class Condition < ApplicationRecord

  belongs_to :relation
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

end
