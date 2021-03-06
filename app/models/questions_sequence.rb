# Define a sequence of questions to be included in a diagnosis
class QuestionsSequence < Node
  before_save :adjust_cut_offs
  after_create :create_boolean

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy
  has_many :node_complaint_categories, foreign_key: 'node_id' # Complaint category linked to the QS
  has_many :complaint_categories, through: :node_complaint_categories

  validates_presence_of :type

  scope :scored, ->() { where(type: 'QuestionsSequences::Scored') }
  scope :not_scored, ->() { where.not(type: 'QuestionsSequences::Scored') }

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

  # Preload the children of class Question
  def self.descendants
    [QuestionsSequences::PredefinedSyndrome, QuestionsSequences::Comorbidity, QuestionsSequences::Triage, QuestionsSequences::Scored]
  end

  # Check recursively the QS parents
  def self.get_qs_parents(qs, parents)
    qs.instances.map do |instance|
      if instance.instanceable_type == 'Node' && instance.instanceable_id != instance.node_id
        parents.push(instance.instanceable_id)
        parents = QuestionsSequence.get_qs_parents(instance.instanceable, parents)
      end
    end
    parents
  end

  # Check if the user is doing a loop between multiple QS
  def self.is_loop(qs_diagram, qs_node)
    return false if qs_diagram.is_a? Diagnosis
    parents = QuestionsSequence.get_qs_parents(qs_diagram, [])
    parents.include? qs_node.id
  end

  # Return the reference prefix from a QS child name
  def self.reference_prefix_class(type)
    return '' unless type.present?
    I18n.t("questions_sequences.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  def self.variable

  end

  # Adjust cut offs at creation
  def adjust_cut_offs
    self.cut_off_start = (cut_off_start * 30.4166667).round if cut_off_start.present? && cut_off_value_type == 'months'
    self.cut_off_end = (cut_off_end * 30.4166667).round if cut_off_end.present? && cut_off_value_type == 'months'
    self.cut_off_value_type = '' # Empty attr accessor to prevent callbacks to falsely do the operation more than once
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    ids = components.map(&:node_id)
    nodes = algorithm.questions.diagrams_included.where.not(id: ids)
    nodes += self.is_a?(QuestionsSequences::Scored) ? algorithm.questions_sequences.not_scored.where.not(id: ids) : algorithm.questions_sequences.where.not(id: ids)
    nodes.as_json(methods: [:category_name, :node_type, :get_answers, :type, :dependencies_by_version])
  end

  def extract_nodes(nodes)
    components.includes(:node).each do |instance|
      node = instance.node
      if node.is_a? Question
        nodes.push(node)
      else
        nodes = node.extract_nodes(nodes) unless node.id == instance.instanceable_id
      end
    end
    nodes
  end

  # Get instance of the questions_sequence in its own diagram
  def get_instance_json(instanceable)
    instances.where(instanceable: instanceable).includes(:node).as_json(
      include: [
        node: {
          include: [:answers, :complaint_categories],
          methods: [
            :node_type,
            :category_name,
            :type
          ]
        },
        conditions: {
          include: [
            answer: {
              methods: [
                :get_node
              ]
            },
          ]
        },
        instanceable: {
          methods: :category_name
        }
      ]
    ).first
  end

  # @return [Json]
  # Return questions in json format
  def questions_json
    (components.questions + components.questions_sequences).as_json(
      include: [
        conditions: {
          include: [
            answer: {
              methods: [
                :get_node
              ]
            },
          ]
        },
        node: {
          include: [:answers, :complaint_categories, :medias],
          methods: [
            :node_type,
            :category_name,
            :type,
            :dependencies_by_version
          ]
        }
      ])
  end

  # @return [Json]
  # Return current questions_sequence in json format
  def questions_sequence_json
    {
      id: id,
      type: 'QuestionsSequence',
      reference: reference,
      label: label,
      category_name: category_name,
      cut_off_start: cut_off_start,
      cut_off_end: cut_off_end,
    }
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
          warnings.add(:basic, I18n.t('flash_message.questions_sequence.question_no_children', type: instance.node.node_type, reference: instance.node.reference))
        end
      end
    end
  end

  # Return the reference prefix from a QS instance
  def reference_prefix
    return '' unless type.present?
    I18n.t("questions_sequences.categories.#{Object.const_get(type).variable}.reference_prefix")
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

  # Add errors to a questions sequence scored for its components
  def validate_score
    higher_node_score = {}
    components.find_by(node: self).conditions.each do |condition|
      score = higher_node_score[condition.answer.node_id]
      higher_node_score[condition.answer.node_id] = condition.score if score.nil? || higher_node_score[condition.answer.node_id] < condition.score
    end
    higher_score = higher_node_score.values.inject(0) { |a, b| a + b }

    if higher_score < min_score
      errors.add(:basic, I18n.t('flash_message.questions_sequence.pss_no_combination'))
    end
  end

  # Add a warning level to rails validation
  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end

  private

  # Display the label for the current child
  def self.display_label
    I18n.t("questions_sequences.categories.#{self.variable}.label")
  end
end
