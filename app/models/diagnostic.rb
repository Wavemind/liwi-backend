# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
include Rails.application.routes.url_helpers
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  attr_accessor :duplicating

  belongs_to :version
  belongs_to :node
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  validates_presence_of :reference
  validates_presence_of :label_en

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
    Node.joins(:instances).where('type LIKE ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Questions::%', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of predefined syndromes
  # Get every predefined syndromes used in a diagnostic
  def questions_sequences
    Node.joins(:instances).where('type LIKE ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'QuestionsSequences::%', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of managements
  # Get every managements used in a diagnostic
  def managements
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'HealthCares::Management', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of treatments
  # Get every treatments used in a diagnostic
  def treatments
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'HealthCares::Treatment', id, self.class.name)
  end

  # @param [Diagnostic]
  # After a duplicate, link DF instances to the duplicated ones instead of the source ones
  def relink_instance
    components_ids = components.map(&:id)
    components.final_diagnostics.each do |df_instance|

      new_df = Node.find_by(reference: "#{df_instance.node.reference}#{I18n.t('duplicated')}")
      Child.where(instance_id: components_ids, node: df_instance.node).each do |child|
        child.update!(node: new_df)
      end

      Instance.where(id: components_ids, final_diagnostic: df_instance.node).each do |instance|
        instance.update!(final_diagnostic: new_df)
      end

      df_instance.node = new_df
      df_instance.save
    end
  end

  # @params [Diagnostic]
  # Generate the ordered questions
  def generate_questions_order
    nodes = []
    first_instances = components.not_health_care_conditions.includes(:conditions, :children, :node).where(conditions: { referenceable_id: nil }).where('nodes.type IN (?) OR nodes.type IN (?)', Question.descendants.map(&:name), QuestionsSequence.descendants.map(&:name))
    nodes << first_instances
    get_children(first_instances, nodes)
  end


  # @params [Array][Instance], [Array][Node]
  # Get children question nodes
  def get_children(instances, nodes)
    current_nodes = []
    instances.includes(:conditions, children: [:node]).map(&:children).flatten.each do |child|
      current_nodes << child.node if child.node.is_a?(Question) || child.node.is_a?(QuestionsSequence)
    end

    if current_nodes.any?
      current_instances = Instance.not_health_care_conditions.where('instanceable_id = ? AND instanceable_type = ? AND node_id IN (?)', id, self.class.name, current_nodes.map(&:id).flatten)
      current_instances.each { |instance| nodes = remove_old_node(nodes, instance) }
      nodes << current_instances
      get_children(current_instances, nodes)
    else
      nodes
    end
  end

  # @params [Array][Array][Instances] instances before delete, [Instance] instance to delete
  # @return [Array][Array][Instances] instances after delete
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
  # Return final diagnostics in json format
  def final_diagnostics_json
    components.final_diagnostics.includes(:node).as_json(include: [ node: {methods: [:node_type]}, conditions: { include: [first_conditionable: { include: [node: { include: [:answers]}], methods: [:get_node]}, second_conditionable: { methods: [:get_node]}]}])
  end

  # @return [Json]
  # Return treatments and managements in json format
  def health_cares_json
    components.treatments.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}]) + components.managements.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    
    ids = components.not_health_care_conditions.select(:node_id)
    (
      version.algorithm.questions.no_triage_but_other.where.not(id: ids).includes(:answers) +
      version.algorithm.questions_sequences.where.not(id: ids).includes(:answers) +
      final_diagnostics.where.not(id: components.select(:node_id))
    ).as_json(methods: [:category_name, :node_type, :get_answers, :type])
  end

  # @return [Boolean]
  # Control method of destroy to avoid callback issue
  def controlled_destroy
    ActiveRecord::Base.transaction(requires_new: true) do
      instances_ids = components.map(&:id)
      Child.where(instance_id: instances_ids).map(&:delete)
      Condition.where(referenceable_type: 'Instance', referenceable_id: instances_ids).map(&:delete)
      components.map(&:delete)
      final_diagnostics.map(&:delete)
      self.delete
      return true
    end
    false
  end

  # Add errors to a diagnostic for its components
  def manual_validate
    components.includes(:node, :children, :conditions).each do |instance|
      if instance.node.is_a? FinalDiagnostic
        unless instance.conditions.any?
          errors.add(:basic, I18n.t('flash_message.diagnostic.final_diagnostic_no_condition', reference: instance.node.reference))
        end
      elsif instance.node.is_a?(Question) || instance.node.is_a?(QuestionsSequence)
        unless instance.children.any?
          if instance.final_diagnostic.nil?
            errors.add(:basic, I18n.t('flash_message.diagnostic.question_no_children', type: instance.node.node_type, reference: instance.node.reference))
          else
            errors.add(:basic, I18n.t('flash_message.diagnostic.hc_question_no_children', type: instance.node.node_type, reference: instance.node.reference, url: diagram_algorithm_version_diagnostic_final_diagnostic_url(version.algorithm.id, version.id, id, instance.final_diagnostic_id).to_s, df_reference: instance.final_diagnostic.reference))
          end
        end
      end
    end
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
