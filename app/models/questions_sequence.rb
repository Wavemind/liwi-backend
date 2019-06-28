# Define a sequence of questions to be included in a diagnostic
class QuestionsSequence < Node
  after_create :create_boolean

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  scope :scored, ->() { where(type: 'QuestionsSequences::Scored') }
  scope :not_scored, ->() { where.not(type: 'QuestionsSequences::Scored') }

  # Preload the children of class Question
  def self.descendants
    [QuestionsSequences::PredefinedSyndrome, QuestionsSequences::Comorbidity, QuestionsSequences::Triage, QuestionsSequences::Scored]
  end

  # @params [QuestionsSequence]
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
      current_nodes << child.node if child.node.is_a?(Question) || child.node.is_a?(QuestionsSequence)
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
    generate_questions_order.as_json(include: [conditions: { include: [first_conditionable: { methods: [:get_node] }, second_conditionable: { methods: [:get_node] }] }, node: { include: [:answers], methods: [:node_type, :category_name, :type] }])
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    (algorithm.nodes.where.not(id: components.not_health_care_conditions.select(:node_id)).where.not('type LIKE ?', 'HealthCares::%')).as_json(methods: [:category_name, :node_type, :get_answers, :type])
  end

  # Add errors to a predefined syndrome for its components
  def manual_validate
    validate_score if self.is_a? QuestionsSequences::Scored
    components.each do |instance|
      if instance.node == self
        unless instance.conditions.any?
          errors.add(:basic, I18n.t('flash_message.questions_sequence.ps_no_condition'))
        end
      else
        unless instance.children.any?
          errors.add(:basic, I18n.t('flash_message.questions_sequence.question_no_children', type: instance.node.node_type, reference: instance.node.reference))
        end
      end
    end
  end

  # Add errors to a questions sequence scored for its components
  def validate_score
    higher_node_score = {}
    components.find_by(node: self).conditions.each do |condition|
      score = higher_node_score[condition.first_conditionable.node.id]
      higher_node_score[condition.first_conditionable.node.id] = condition.score if score.nil? || higher_node_score[condition.first_conditionable.node.id] < condition.score
    end
    higher_score = higher_node_score.values.inject(0) { |a, b| a + b }

    if higher_score < min_score
      errors.add(:basic, I18n.t('flash_message.questions_sequence.pss_no_combination'))
    end
  end

  # Return the reference prefix from a QS instance
  def reference_prefix
    return '' unless type.present?
    I18n.t("questions_sequences.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Return the reference prefix from a QS child name
  def self.reference_prefix_class(type)
    return '' unless type.present?
    I18n.t("questions_sequences.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  def self.variable

  end

  # Return a hash with all questions sequence categories with their name, label and prefix
  def self.categories
    categories = []
    self.descendants.each do |category|
      current_category = {}
      current_category['label'] = category.display_label
      current_category['name'] = category.name
      current_category['reference_prefix'] = self.reference_prefix_class(category.name)
      categories.push(current_category)
    end
    categories
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.questions_sequences.where(reference: reference_prefix + reference).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = reference_prefix + reference
  end

  # Display the label for the current child
  def self.display_label
    I18n.t("questions_sequences.categories.#{self.variable}.label")
  end
end
