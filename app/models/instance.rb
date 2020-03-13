# Define the instance of a node in a diagnostic
class Instance < ApplicationRecord

  belongs_to :node
  belongs_to :instanceable, polymorphic: true
  belongs_to :final_diagnostic, optional: true

  has_many :children
  has_many :nodes, through: :children

  has_many :conditions, as: :referenceable, dependent: :destroy

  scope :managements, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'HealthCares::Management') }
  scope :questions, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', Question.descendants.map(&:name)) }
  scope :questions_sequences, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', QuestionsSequence.descendants.map(&:name)) }
  scope :treatments, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'HealthCares::Treatment') }
  scope :final_diagnostics, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'FinalDiagnostic') }

  scope :triage_complaint_category, ->() { joins(:node).where('nodes.stage = ? AND nodes.type = ?', Question.stages[:triage], 'Questions::ComplaintCategory') }
  scope :triage_under_complaint_category, ->() { joins(:node).where('nodes.type NOT IN (?)', %w(Questions::EmergencySign Questions::ComplaintCategory)) }

  # Allow to filter if the node is used as a health care condition or as a final diagnostic condition. A node can be used in both of them.
  scope :health_care_conditions, ->() { joins(:node).includes(:conditions).where.not(final_diagnostic: nil).or(joins(:node).includes(:conditions).where("nodes.type LIKE 'HealthCares::%'")) }
  scope :not_health_care_conditions, ->() { includes(:conditions).where(final_diagnostic_id: nil) }

  before_destroy :remove_condition_from_children

  validate :already_exist, on: :create

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :conditions
    include_association :children
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

  # Return the reference label of its node
  def reference_label
    node.reference_label
  end

  # Return json formated of the instance depending on the node type
  def generate_json
    # TODO: Drug

    if node.is_a?(Question) || node.is_a?(QuestionsSequence)
      self.as_json(include: { node: { include: [:answers], methods: [:node_type, :category_name, :type] } })
    else
      self.as_json(include: { node: { methods: [:node_type, :category_name, :type] } })
    end
  end

  private

  # Save if validation is true and node_id doesn't already exist in current diagnostic
  def already_exist
    if instanceable.components.find_by(node_id: node_id, final_diagnostic_id: final_diagnostic_id)
      errors.add(:base, I18n.t('.already_exist'))
    end
  end
end
