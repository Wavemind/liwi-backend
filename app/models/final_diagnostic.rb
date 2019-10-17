# Define a final diagnostic
# Reference prefix : DF
class FinalDiagnostic < Node

  belongs_to :diagnostic
  belongs_to :excluded_diagnostic, class_name: 'FinalDiagnostic', foreign_key: :final_diagnostic_id, optional: true

  has_many :medical_case_final_diagnostics
  has_many :medical_cases, through: :medical_case_final_diagnostics

  has_many :final_diagnostic_health_cares, dependent: :destroy
  has_many :health_cares, through: :final_diagnostic_health_cares

  has_many :components, class_name: 'Instance', dependent: :destroy

  before_validation :prevent_loop

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :final_diagnostic_health_cares
    append reference: I18n.t('duplicated')
  end

  # @return [Json]
  # Return treatments and managements in json format
  def health_cares_json
    diagnostic.components.where(node_id: health_cares.map(&:id), final_diagnostic_id: id).as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])
  end

  # @params [FinalDiagnostic]
  # Generate the ordered conditions of health cares
  def generate_health_care_conditions_order
    nodes = []
    first_instances = components.joins(:node).includes(:conditions, :children).where(conditions: { referenceable_id: nil }).where('nodes.type IN (?) OR nodes.type IN (?)', Question.descendants.map(&:name), QuestionsSequence.descendants.map(&:name))
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
      current_instances = Instance.health_care_conditions.where('instanceable_id = ? AND instanceable_type = ? AND node_id IN (?)', id, self.class.name, current_nodes.map(&:id).flatten)
      current_instances.each { |instance| nodes = remove_old_node(nodes, instance) }
      nodes << current_instances
      get_children(current_instances, nodes)
    else
      nodes
    end
  end

  # Return all questions for Final Diagnostic diagram as json
  def health_care_questions_json
    generate_health_care_conditions_order.as_json(include: [conditions: { include: [first_conditionable: { methods: [:get_node] }, second_conditionable: { methods: [:get_node] }] }, node: { include: [:answers], methods: [:node_type, :category_name, :type] }])
  end

  # @return [Json]
  # Return available nodes for health cares diagram in the algorithm in json format
  def available_nodes_health_cares_json
    ids = components.select(:node_id)
    (
      diagnostic.version.algorithm.questions.no_triage_but_other.where.not(id: ids) +
      diagnostic.version.algorithm.questions_sequences.where.not(id: ids) +
      diagnostic.version.algorithm.health_cares.where.not(id: ids)
    ).as_json(methods: [:category_name, :node_type, :get_answers, :type])
  end

  # Recursive loop to make sure it is not excluding a grand child of excluded diagnostic
  def is_excluded(excluded_diagnostic)
    return true if self.id == excluded_diagnostic.id || (excluded_diagnostic.excluded_diagnostic.present? && is_excluded(excluded_diagnostic.excluded_diagnostic))
    false
  end

  # Ensure that the user is not trying to loop with excluding diagnostics.
  def prevent_loop
    if excluded_diagnostic.present? && is_excluded(excluded_diagnostic)
      self.errors.add(:base, I18n.t('final_diagnostics.validation.loop'))
      raise ActiveRecord::Rollback, I18n.t('final_diagnostics.validation.loop')
    end
  end

  # Get the reference prefix according to the type
  def reference_prefix
    I18n.t("final_diagnostics.reference")
  end

end
