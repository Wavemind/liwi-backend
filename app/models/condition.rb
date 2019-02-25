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

  validates_presence_of :first_conditionable

  nilify_blanks :only => [:operator]

  # @return [String]
  # Return the id displayed for the view
  def display_condition
    "Cond : (#{first_conditionable.display_condition} #{operator.upcase unless operator.nil?} #{second_conditionable.display_condition unless second_conditionable.nil?})"
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  # @params [String, String]
  # @return [Object]
  # Return an object (Answer or Condition) from a string with id and class name
  def create_conditionable(conditionable)
    conditionable.split(',')[1].constantize.find(conditionable.split(',')[0])
  end
end
