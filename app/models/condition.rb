# Define the conditions for a node to be available. Conditions can be answers (mostly) or call themselves since the link is polymorphic.
# If there is no second conditionable, it means that only the first one is required for the node to be available.
# The top level flag helps the logic to know where to begin the conditions seeking. For example, if a condition calls another, it will be likely as top_level
# in order to be processed before the sub-condition
class Condition < ApplicationRecord

  enum operator: [:and_operator, :or_operator]

  belongs_to :referenceable, polymorphic: true
  belongs_to :first_conditionable, polymorphic: true
  belongs_to :second_conditionable, polymorphic: true, optional: true

  before_destroy :remove_children, unless: Proc.new { self.referenceable.is_a?(Diagnostic) }
  before_validation :prevent_loop, unless: Proc.new { self.referenceable.is_a?(Diagnostic) || (self.referenceable.is_a?(Instance) && self.referenceable.instanceable.is_a?(Diagnostic) && self.referenceable.instanceable.duplicating) }
  before_validation :already_exist, on: :create

  validates_presence_of :first_conditionable

  scope :top_level, -> { where(top_level: true) }
  scope :low_level, -> { where(top_level: false) }

  # Puts nil instead of empty string when operator is not set in the view.
  nilify_blanks only: [:operator]

  # @return [String]
  # Return the id displayed for the view
  def display_condition
    "(#{first_conditionable.display_condition} #{I18n.t("conditions.operators.#{operator}") unless operator.nil?} #{second_conditionable.display_condition unless second_conditionable.nil?})"
  end

  # @params [String, String]
  # @return [Object]
  # Return an object (Answer or Condition) from a string with id and class name
  def create_conditionable(conditionable)
    conditionable.split(',')[1].constantize.find(conditionable.split(',')[0])
  end

  # Create children from conditions automatically
  def create_children
    if first_conditionable.is_a?(Answer)
      parent = first_conditionable.node.instances.find_by(instanceable: referenceable.instanceable, final_diagnostic: referenceable.final_diagnostic)
      parent.children.create!(node: referenceable.node) unless parent.nil? || parent.children.where(node: referenceable.node).any?
    elsif first_conditionable.is_a?(Condition)
      first_conditionable.create_children
    end

    if second_conditionable.is_a?(Answer)
      parent = second_conditionable.node.instances.find_by(instanceable: referenceable.instanceable, final_diagnostic: referenceable.final_diagnostic)
      parent.children.create!(node: referenceable.node) unless parent.nil? || parent.children.where(node: referenceable.node).any?
    elsif second_conditionable.is_a?(Condition)
      second_conditionable.create_children
    end
  end

  # Used for rendering json to react. Unavailable if first / second conditionable type is a condition
  # @return nil
  def get_node
    nil
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  # @param [Object] child
  # Verify if current instance is a child of himself
  # @return [Boolean]
  def is_child(instance)
    instance.children.each do |child|
      # Gets child instance for the same instanceable (PS OR Diagnostic)
      child_instance = referenceable.instanceable.components.includes(:node).select{ |c| c.node == child.node }.first
      return true if child_instance == referenceable || (child_instance.children.any? && is_child(child_instance))
    end
    false
  end

  private

  # Before creating a condition, verify that it is not doing a loop. Create the Child in the opposite way in the process
  def prevent_loop
    ActiveRecord::Base.transaction(requires_new: true) do
      self.create_children
      if referenceable.children.any? && is_child(referenceable)
        self.errors.add(:base, I18n.t('conditions.validation.loop'))
        raise ActiveRecord::Rollback, I18n.t('conditions.validation.loop')
      end
    end
  end

  # Remove child by instanceable type and first/second conditionable id
  def remove_children
    if first_conditionable.is_a?(Answer)
      node_answers_ids = first_conditionable.node.answers.map(&:id) - [first_conditionable_id]
      child = Child.find_by(instance: first_conditionable.node.instances.find_by(instanceable: referenceable.instanceable, final_diagnostic: referenceable.final_diagnostic), node: referenceable.node)
      child.destroy! unless referenceable.conditions.where(first_conditionable_id: node_answers_ids, first_conditionable_type: 'Answer').or(referenceable.conditions.where(second_conditionable_id: node_answers_ids, second_conditionable_type: 'Answer')).any?
    end

    if second_conditionable.is_a?(Answer)
      node_answers_ids = second_conditionable.node.answers.map(&:id) - [second_conditionable_id]
      child = Child.find_by(instance: second_conditionable.node.instances.find_by(instanceable: referenceable.instanceable, final_diagnostic: referenceable.final_diagnostic), node: referenceable.node)
      child.destroy! unless referenceable.conditions.where(first_conditionable_id: node_answers_ids, first_conditionable_type: 'Answer').or(referenceable.conditions.where(second_conditionable_id: node_answers_ids, second_conditionable_type: 'Answer')).any?
    end
  end

  # Throw an error if condition with same referenceable and first_conditionable already exist
  def already_exist
    if Condition.exists?(referenceable: referenceable, first_conditionable: first_conditionable)
      self.errors.add(:base, I18n.t('conditions.validation.link_already_exist'))
    end
  end
end
