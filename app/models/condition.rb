# Define the conditions for a node to be available. Conditions can be answers (mostly) or call themselves since the link is polymorphic.
# If there is no second conditionable, it means that only the first one is required for the node to be available.
# The top level flag helps the logic to know where to begin the conditions seeking. For example, if a condition calls another, it will be likely as top_level
# in order to be processed before the sub-condition
class Condition < ApplicationRecord

  enum operator: [:and_operator, :or_operator]

  belongs_to :referenceable, polymorphic: true
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

  scope :top_level, -> { where(top_level: true) }
  scope :low_level, -> { where(top_level: false) }

  validates_presence_of :first_conditionable

  before_validation :prevent_loop, unless: Proc.new { self.referenceable.is_a?(Diagnostic) }

  # Puts nil instead of empty string when operator is not set in the view.
  nilify_blanks only: [:operator]

  # @return [String]
  # Return the id displayed for the view
  def display_condition
    "#{first_conditionable.display_condition} #{operator.upcase unless operator.nil?} #{second_conditionable.display_condition unless second_conditionable.nil?}"
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  def is_child(children)
    children.each do |child|
      current_instance = child.node.instances.find_by(instanceable: referenceable.instanceable)
      return true if current_instance == referenceable || (current_instance.children.any? && is_child(current_instance.children))
    end
    false
  end

  def prevent_loop
    referenceable.errors.add(:base, I18n.t('conditions.validation.loop')) if referenceable.children.any? && is_child(referenceable.children)
  end

  # @params [String, String]
  # @return [Object]
  # Return an object (Answer or Condition) from a string with id and class name
  def create_conditionable(conditionable)
    conditionable.split(',')[1].constantize.find(conditionable.split(',')[0])
  end
end
