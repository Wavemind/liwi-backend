# Define the instance of a node in a diagnosis
class Instance < ApplicationRecord
  include Sourceable

  belongs_to :node
  belongs_to :instanceable, polymorphic: true
  belongs_to :final_diagnosis, optional: true
  belongs_to :source, class_name: 'Instance', optional: true

  has_one :top_left_question, foreign_key: 'top_left_question_id', class_name: 'Version', dependent: :nullify
  has_one :first_top_right_question, foreign_key: 'first_top_right_question_id', class_name: 'Version', dependent: :nullify
  has_one :second_top_right_question, foreign_key: 'second_top_right_question_id', class_name: 'Version', dependent: :nullify

  has_many :children
  has_many :nodes, through: :children

  has_many :conditions, dependent: :destroy

  scope :managements, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'HealthCares::Management') }
  scope :questions, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', Question.descendants.map(&:name)) }
  scope :questions_sequences, ->() { joins(:node).includes(:conditions).where('nodes.type IN (?)', QuestionsSequence.descendants.map(&:name)) }
  scope :drugs, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'HealthCares::Drug') }
  scope :final_diagnoses, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'FinalDiagnosis') }

  scope :triage_complaint_category, ->() { joins(:node).where('nodes.stage = ? AND nodes.type = ?', Question.stages[:triage], 'Questions::ComplaintCategory') }
  scope :triage_under_complaint_category, ->() { joins(:node).where('nodes.type NOT IN (?)', %w(Questions::UniqueTriageQuestion Questions::ComplaintCategory)) }

  # Allow to filter if the node is used as a health care condition or as a final diagnosis condition. A node can be used in both of them.
  scope :health_care_conditions, ->() { joins(:node).includes(:conditions).where.not(final_diagnosis: nil).or(joins(:node).includes(:conditions).where("nodes.type LIKE 'HealthCares::%'")) }
  scope :not_health_care_conditions, ->() { includes(:conditions).where(final_diagnosis_id: nil) }

  before_destroy :remove_condition_from_children
  after_destroy :remove_dependencies, if: Proc.new { self.node.is_a?(FinalDiagnosis) }

  validate :already_exist, on: :create

  translates :duration, :description

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :conditions
    include_association :children
  end

  # Remove condition - cut the method in order to be called for one condition
  def self.remove_condition(cond, instance)
    if cond.answer.node == instance.node
      cond.destroy!
    end
  end

  # Return the diagram where the instance is (so the final diagnosis and not the diagnosis if it's a treatment variable)
  def diagram
    final_diagnosis.present? ? final_diagnosis : instanceable
  end

  # Display question with ID
  def display_node_label_id
    "#{node.label_en} (#{node_id})"
  end

  # Return json formated of the instance depending on the node type
  def generate_json
    if node.is_a?(Question)
      self.as_json(include: [ node: { include: [:answers, :complaint_categories, :medias], methods: [:node_type, :category_name, :type, :dependencies_by_version] }, instanceable: {methods: [:category_name]}])
    elsif node.is_a?(QuestionsSequence)
      self.as_json(include: [ node: { include: [:answers, :complaint_categories], methods: [:node_type, :category_name, :type, :dependencies_by_version] }, instanceable: {methods: [:category_name]} ])
    elsif node.is_a?(HealthCares::Drug)
      self.as_json(include: [ node: { include: [:formulations], methods: [:node_type, :category_name, :type, :dependencies_by_version] }, instanceable: {methods: [:category_name]} ])
    elsif node.is_a?(HealthCares::Management) || node.is_a?(FinalDiagnosis)
      self.as_json(include: [ node: { methods: [:node_type, :category_name, :type, :dependencies_by_version], include: :medias }, instanceable: {methods: [:category_name]} ])
    else
      self.as_json(include: [ node: { methods: [:node_type, :category_name, :type, :dependencies_by_version] }, instanceable: {methods: [:category_name]} ])
    end
  end

  # Return the label of the node for display purpose
  def node_label
    node.label_en
  end

  # Return the reference label of its node
  def reference_label
    node.reference_label
  end

  # Delete properly conditions from children in the current diagnosis or predefined syndrome.
  def remove_condition_from_children
    children.each do |child|
      instance = child.node.instances.find_by(instanceable: instanceable, final_diagnosis: final_diagnosis)
      instance.conditions.each do |cond|
        self.class.remove_condition(cond, self)
      end
    end
  end

  # Remove exclusion and sub instances from a final diagnosis when its instance has been destroyed
  def remove_dependencies
    NodeExclusion.final_diagnosis.where(excluding_node_id: node_id).or(NodeExclusion.final_diagnosis.where(excluded_node_id: node_id)).map(&:destroy)
    Instance.where(final_diagnosis_id: node_id).map(&:destroy)
  end

  # Get translatable attributes to translate with excel import
  def self.get_translatable_params(data)
    fields_to_update = {}

    data.row(1).each_with_index do |head, index|
      if head.include?('Duration')
        code = head[/\((.*?)\)/m, 1]
        fields_to_update["duration_#{code}"] = index
      elsif head.include?('Description')
        code = head[/\((.*?)\)/m, 1]
        fields_to_update["description_#{code}"] = index
      end
    end

    fields_to_update
  end

  private

  # Save if validation is true and node_id doesn't already exist in current diagnosis
  def already_exist
    if instanceable.components.find_by(node_id: node_id, final_diagnosis_id: final_diagnosis_id)
      errors.add(:base, I18n.t('.already_exist'))
    end
  end
end
