# Define the children of an answer
class PredefinedSyndrome < Node
  after_create :create_boolean

  belongs_to :category

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  scope :scored, ->() { joins(:category).where('categories.reference_prefix = ?', 'PSS') }
  scope :not_scored, ->() { joins(:category).where.not('categories.reference_prefix = ?', 'PSS') }

  # @params [PredefinedSyndrome]
  # Generate the ordered questions
  def generate_questions_order
    nodes = []
    first_nodes = components.includes(:node, :conditions, :children).where(conditions: { referenceable_id: nil })
    nodes << first_nodes
    get_children(first_nodes, nodes)
  end

  # @params [Array][Instance], [Array][Node]
  # Get children question nodes
  def get_children(instances, nodes)
    current_nodes = []
    instances.includes(children: [:node]).map(&:children).flatten.each do |child|
      current_nodes << child.node if child.node.is_a?(Question) || child.node.is_a?(PredefinedSyndrome)
    end
    if current_nodes.any?
      current_instances = Instance.not_health_care_conditions.where('instanceable_id = ? AND instanceable_type = ? AND node_id IN (?)', id, 'Node', current_nodes.map(&:id).flatten)
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
    generate_questions_order.as_json(include: [conditions: { include: [first_conditionable: { methods: [:get_node] }, second_conditionable: { methods: [:get_node] }] }, node: { include: [:answers], methods: [:type, :category_name] }])
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    (algorithm.nodes.where.not(id: components.not_health_care_conditions.select(:node_id)).where.not(type: 'Treatment').where.not(type: 'Management')).as_json(methods: [:category_name, :type, :get_answers])
  end

  # Add errors to a predefined syndrome for its components
  def manual_validate
    validate_score if category.id == 8
    components.each do |instance|
      if instance.node == self
        unless instance.conditions.any?
          errors.add(:basic, "The Predefined syndrome you are describing has no condition.")
        end
      else
        unless instance.children.any?
          errors.add(:basic, "The #{instance.node.type} #{instance.node.reference} is not linked to any children.")
        end
      end
    end
  end

  # Add errors to a predefined syndrome scored for its components
  def validate_score
    higher_node_score = {}
    components.find_by(node: self).conditions.each do |condition|
      score = higher_node_score[condition.first_conditionable.node.id]
      higher_node_score[condition.first_conditionable.node.id] = condition.score if score.nil? || higher_node_score[condition.first_conditionable.node.id] < condition.score
    end

    higher_score = higher_node_score.values.inject { |a, b| a + b }
    if higher_score < min_score
      errors.add(:basic, "There is no combination for this Predefined syndrome to be true.")
    end
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.predefined_syndromes.where(reference: "#{category.reference_prefix}#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{category.reference_prefix}#{reference}"
  end
end
