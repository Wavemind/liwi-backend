# Define the conditions for a node to be available.
class Condition < ApplicationRecord
  attr_accessor :cut_off_value_type

  belongs_to :instance
  belongs_to :answer

  # belongs_to :referenceable, polymorphic: true #TODO : Remove after data migration
  # belongs_to :first_conditionable, polymorphic: true #TODO : Remove after data migration

  before_destroy :remove_children
  before_save :adjust_cut_offs
  before_validation :prevent_loop, unless: Proc.new {(self.instance.instanceable.is_a?(Diagnosis) && self.instance.instanceable.duplicating) }


  # Adjust cut offs at creation
  def adjust_cut_offs
    self.cut_off_start = (cut_off_start * 30.4166667) if cut_off_start.present? && cut_off_value_type == 'months'
    self.cut_off_end = (cut_off_end * 30.4166667) if cut_off_end.present? && cut_off_value_type == 'months'
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  # Create children from conditions automatically
  def create_children
    parent = answer.node.instances.find_by(instanceable: instance.instanceable, final_diagnosis: instance.final_diagnosis)
    parent.children.create!(node: instance.node) unless parent.nil? || parent.children.where(node: instance.node).any?
  end

  # @return [String]
  # Return the id displayed for the view
  def display_condition
    answer.display_condition
  end

  # Used for rendering json to react. Unavailable if first / second conditionable type is a condition
  # @return nil
  def get_node
    nil
  end

  # @param [Object] child
  # Verify if current instance is a child of himself
  # @return [Boolean]
  def is_child(new_instance)
    new_instance.children.each do |child|
      # Gets child instance for the same instanceable (PS OR Diagnosis)
      child_instance = instance.instanceable.components.includes(:node).select{ |c| c.node == child.node }.first
      return true if child_instance == instance || (child_instance.children.any? && is_child(child_instance))
    end
    false
  end

  private

  # Before creating a condition, verify that it is not doing a loop. Create the Child in the opposite way in the process
  def prevent_loop
    ActiveRecord::Base.transaction(requires_new: true) do
      self.create_children
      if instance.children.any? && is_child(instance)
        self.errors.add(:base, I18n.t('conditions.validation.loop'))
        raise ActiveRecord::Rollback, I18n.t('conditions.validation.loop')
      end
    end
  end

  # Remove child by instanceable type and first/second conditionable id
  def remove_children
    node_answers_ids = answer.node.answers.map(&:id) - [answer_id]
    child = Child.find_by(instance: answer.node.instances.find_by(instanceable: instance.instanceable, final_diagnosis: instance.final_diagnosis), node: instance.node)
    child.destroy! unless instance.conditions.where(answer_id: node_answers_ids).any?
  end
end
