# Define the conditions for a node to be available. Conditions can be answers (mostly) or call themselves since the link is polymorphic.
# If there is no second conditionable, it means that only the first one is required for the node to be available.
# The top level flag helps the logic to know where to begin the conditions seeking. For example, if a condition calls another, it will be likely as top_level
# in order to be processed before the sub-condition
class Condition < ApplicationRecord

  belongs_to :referenceable, polymorphic: true
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

  scope :top_level, -> { where(top_level: true) }
  scope :low_level, -> { where(top_level: false) }


  # @return [String]
  # Return the id displayed for the view
  def display_condition
    "(#{first_conditionable.display_condition} #{operator.upcase unless operator.nil?} #{second_conditionable.display_condition unless second_conditionable.nil?})"
  end
end
