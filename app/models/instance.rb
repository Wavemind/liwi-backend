# Define the instance of a node in a diagnostic
class Instance < ApplicationRecord

  belongs_to :node
  belongs_to :instanceable, polymorphic: true

  has_many :children
  has_many :nodes, through: :children

  has_many :conditions, as: :referenceable, dependent: :destroy

  scope :managements, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Management') }
  scope :questions, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Question') }
  scope :predefined_syndromes, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'PredefinedSyndrome') }
  scope :treatments, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Treatment') }
  scope :final_diagnostics, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'FinalDiagnostic') }

  before_destroy :remove_children_from_parents, :remove_condition_from_children

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :conditions
  end

  # Delete children as well using this instance
  def remove_children_from_parents
    instanceable.components.select { |i| i.children.select { |c| c.destroy if c.node == self.node } }
  end

  # Delete properly conditions from children in the current diagnostic or predefined syndrome.
  def remove_condition_from_children
    instanceable.components.map(&:conditions).flatten.each do |cond|
      self.class.remove_condition(cond, self)
    end
  end

  # Remove condition - cut the method in order to be called for one condition
  def self.remove_condition(cond, instance)
    if cond.first_conditionable.is_a?(Answer) && cond.first_conditionable.node == instance.node
      if cond.second_conditionable.is_a?(Answer)
        cond.update!(first_conditionable: cond.second_conditionable, operator: nil, second_conditionable: nil)
      else
        cond.second_conditionable.update!(top_level: cond.top_level) if cond.second_conditionable.is_a?(Condition)
        cond.destroy!
      end
    elsif cond.second_conditionable.is_a?(Answer) && cond.second_conditionable.node == instance.node
      cond.update!(operator: nil, second_conditionable: nil)
    end
  end
end
