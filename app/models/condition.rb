# Define the conditions for a node to be available. Conditions can be answers (mostly) or call themselves since the link is polymorphic.
# If there is no second conditionable, it means that only the first one is required for the node to be available.
# The top level flag helps the logic to know where to begin the conditions seeking. For example, if a condition calls another, it will be likely as top_level
# in order to be processed before the sub-condition
class Condition < ApplicationRecord

  enum operator: [:and_operator, :or_operator]

  belongs_to :referenceable, polymorphic: true
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

  after_create :create_children, unless: Proc.new { self.referenceable.is_a?(Diagnostic) }
  before_destroy :remove_children, unless: Proc.new { self.referenceable.is_a?(Diagnostic) }

  scope :top_level, -> { where(top_level: true) }
  scope :low_level, -> { where(top_level: false) }

  validates_presence_of :first_conditionable

  # Puts nil instead of empty string when operator is not set in the view.
  nilify_blanks only: [:operator]

  # @return [String]
  # Return the id displayed for the view
  def display_condition
    "(#{first_conditionable.display_condition} #{I18n.t("conditions.operators.#{operator}") unless operator.nil?} #{second_conditionable.display_condition unless second_conditionable.nil?})"
  end

  def create_children
    create_child(self)
  end

  def create_child(condition)
    if condition.first_conditionable.is_a?(Answer) && (!condition.first_conditionable.node.is_a?(Treatment) || !condition.first_conditionable.node.is_a?(Management))
      Child.create!(instance: condition.first_conditionable.node.instances.find_by(instanceable: condition.referenceable.instanceable), node: condition.referenceable.node)
    else
      create_link(condition.first_conditionable)
    end

    if condition.second_conditionable.is_a?(Answer) && (!condition.second_conditionable.node.is_a?(Treatment) || !condition.second_conditionable.node.is_a?(Management))
      Child.create!(instance: condition.second_conditionable.node.instances.find_by(instanceable: condition.referenceable.instanceable), node: condition.referenceable.node)
    elsif second_conditionable.is_a?(Condition)
      create_link(condition.second_conditionable)
    end
  end

  def remove_children
    Child.find_by(instance: first_conditionable.node.instances.find_by(instanceable: referenceable.instanceable),
                node: referenceable.node).destroy! if first_conditionable.is_a?(Answer) && (!first_conditionable.node.is_a?(Treatment) || !first_conditionable.node.is_a?(Management))
    Child.find_by(instance: second_conditionable.node.instances.find_by(instanceable: referenceable.instanceable),
                node: referenceable.node).destroy! if second_conditionable.is_a?(Answer) && (!second_conditionable.node.is_a?(Treatment) || !second_conditionable.node.is_a?(Management))
  end

  def get_node
    nil
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
