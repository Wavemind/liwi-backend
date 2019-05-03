# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  belongs_to :version
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  validates_presence_of :reference
  validates_presence_of :label

  translates :label

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :components
    include_association :final_diagnostics
    include_association :conditions
    append reference: I18n.t('duplicated')
  end

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  # @return [ActiveRecord::Relation] of questions
  # Get every questions asked in a diagnostic
  def questions
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Question', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of predefined syndromes
  # Get every predefined syndromes used in a diagnostic
  def predefined_syndromes
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'PredefinedSyndrome', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of managements
  # Get every managements used in a diagnostic
  def managements
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Management', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of treatments
  # Get every treatments used in a diagnostic
  def treatments
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Treatment', id, self.class.name)
  end

  # @params [Diagnostic]
  # After a duplicate, link DF instances to the duplicated ones instead of the source ones
  def relink_instance
    components.final_diagnostics.each do |df_instance|
      df_instance.node = Node.find_by(reference: "#{df_instance.node.reference}#{I18n.t('duplicated')}")
      df_instance.save
    end
  end

  # @params [Diagnostic]
  # Generate the ordered questions
  def generate_questions_order
    nodes = []
    first_instances = components.includes(:node, :conditions, :children).where(conditions: { referenceable_id: nil }).where('nodes.type = ? OR nodes.type = ?', 'Question', 'PredefinedSyndrome')

    health_cares = components.treatments + components.managements
    # Excluding health cares conditions
    first_instances.each do |instance|
      isHcCondition = false
      health_cares.map(&:conditions).flatten.each do |cond|
        isHcCondition = true if ((cond.first_conditionable.is_a?(Answer) && cond.first_conditionable.node.id == instance.node.id) || (cond.second_conditionable.is_a?(Answer) && cond.second_conditionable.node.id == instance.node.id))
      end
      first_instances = first_instances.where.not(id: instance.id) if isHcCondition
    end

    nodes << first_instances
    get_children(first_instances, nodes)
  end

  # @params [Array][Instance], [Array][Node]
  # Get children question nodes
  def get_children(instances, nodes)
    current_nodes = []
    instances.includes(children: [:node]).map(&:children).flatten.each do |child|
      current_nodes << child.node if child.node.is_a?(Question) || child.node.is_a?(PredefinedSyndrome)
    end

    if current_nodes.any?
      current_instances = Instance.where('instanceable_id = ? AND instanceable_type = ? AND node_id IN (?)', id, self.class.name, current_nodes.map(&:id).flatten)
      current_instances.each { |instance| nodes = remove_old_node(nodes, instance) }
      nodes << current_instances
      get_children(current_instances, nodes)
    else
      nodes
    end
  end

  # @params [Array][Array][Instances] instances before delete, [Instance] instance to delete
  # @@return [Array][Array][Instances] instances after delete
  # Remove the duplicated node if it was already set before. We keep the last one in order to be coherent in the diagram.
  def remove_old_node(instances, instance)
    instances.each_with_index do |level, index|
      instances[index] = instances[index].to_a unless instances[index].is_a? Array # Convert ActiveRelation to Array to prevent database updating
      instances[index].delete(instance)
    end
    instances
  end

  # @return [Json]
  # Return questions in json format
  def questions_json
    generate_questions_order.as_json(include: [conditions: { include: [first_conditionable: { include: [:node] }, second_conditionable: { include: [:node] }] }, node: { include: [:answers], methods: [:type] }])
  end

  # @return [Json]
  # Return final diagnostics in json format
  def final_diagnostics_json
    components.final_diagnostics.as_json(include: [ node: {methods: [:type]}, conditions: { include: [first_conditionable: { include: [node: { include: [:answers]}]}, second_conditionable: { include: [node: { include: [:answers]}]}]}])
  end

  # @return [Json]
  # Return treatments and managements in json format
  def health_cares_json
    components.treatments.as_json(include: [node: {methods: [:type]}, conditions: { include: [first_conditionable: { include: [node: { include: [:answers]}]}]}]) + components.managements.as_json(include: [ :node, conditions: { include: [first_conditionable: { include: [:node]}]}])
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    (version.algorithm.nodes.where.not(id: components.select(:node_id)) + final_diagnostics.where.not(id: components.select(:node_id))).as_json(methods: [:category_name, :type, :get_answers])
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if Diagnostic.joins(version: :algorithm)
         .where('reference = ? AND algorithms.id = ?', "#{I18n.t('diagnostics.reference')}#{reference}", version.algorithm.id).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}#{reference}" unless self.reference.include?(I18n.t('duplicated'))
  end
end
