# Define the instance of a node in a diagnostic
class Instance < ApplicationRecord

  belongs_to :node
  belongs_to :instanceable, polymorphic: true
  belongs_to :final_diagnostic, optional: true

  has_many :children
  has_many :nodes, through: :children

  has_many :conditions, as: :referenceable, dependent: :destroy

  scope :managements, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Management') }
  scope :questions, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', Question.descendants.map(&:name)) }
  scope :questions_sequences, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', QuestionsSequence.descendants.map(&:name)) }
  scope :treatments, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Treatment') }
  scope :final_diagnostics, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'FinalDiagnostic') }
  # Allow to filter if the node is used as a health care condition or as a final diagnostic condition. A node can be used in both of them.
  scope :health_care_conditions, ->() { joins(:node).includes(:conditions).where.not(final_diagnostic: nil).or(joins(:node).includes(:conditions).where("nodes.type = 'Treatment'")).or(joins(:node).includes(:conditions).where("nodes.type = 'Management'")) }
  scope :not_health_care_conditions, ->() { includes(:conditions).where(final_diagnostic_id: nil) }

  before_destroy :remove_condition_from_children

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :conditions
  end

  # Delete properly conditions from children in the current diagnostic or predefined syndrome.
  def remove_condition_from_children
    children.each do |child|
      instance = child.node.instances.find_by(instanceable: instanceable, final_diagnostic: final_diagnostic)
      instance.conditions.each do |cond|
        self.class.remove_condition(cond, self)
      end
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
