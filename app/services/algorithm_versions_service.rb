class AlgorithmVersionsService

  # @params id [AlgorithmVersion] id of the algorithm version to extract
  # @return hash
  # Build a hash of an algorithm version with its diagnostics, predefined syndromes, questions and health cares
  def self.generate_hash(id)
    @algorithm_version = AlgorithmVersion.find(id)
    @managements = {}
    @questions = {}
    @treatments = {}
    @predefined_syndromes = {}

    hash = extract_metadata
    hash['diseases'] = []

    @algorithm_version.diagnostics.each do |diagnostic|
      hash['diseases'] << extract_diagnostic(diagnostic)
    end

    hash['questions'] = generate_questions
    hash['treatments'] = generate_treatments
    hash['managements'] = generate_managements
    hash['predefined_syndromes'] = generate_predefined_syndromes

    hash
  end

  private

  def self.extract_metadata
    hash = {}
    hash['name'] = @algorithm_version.algorithm.name
    hash['version'] = @algorithm_version.version
    hash['description'] = @algorithm_version.algorithm.description
    hash['author'] = @algorithm_version.user.full_name
    hash['created_at'] = @algorithm_version.created_at
    hash['updated_at'] = @algorithm_version.updated_at
    hash
  end

  def self.extract_diagnostic(diagnostic)
    hash = {}
    hash[diagnostic.id] = {}
    hash[diagnostic.id]['id'] = diagnostic.id
    hash[diagnostic.id]['reference'] = diagnostic.reference
    hash[diagnostic.id]['label'] = diagnostic.label
    hash[diagnostic.id]['differential'] = extract_conditions(diagnostic.conditions)

    hash[diagnostic.id]['nodes'] = []

    diagnostic.relations.questions.includes([:children, node:[:answers, :answer_type, :category]]).each do |question_relation|
      # Append the questions in order to list them all at the end of the json.
      assign_node(question_relation.node)

      hash[diagnostic.id]['nodes'] << extract_relations(question_relation)
    end

    diagnostic.relations.predefined_syndromes.includes([:children, node:[:answers]]).each do |predefined_syndrome_relation|
      # Append the predefined syndromes in order to list them all at the end of the json.
      assign_node(predefined_syndrome_relation.node)

      hash[diagnostic.id]['nodes'] << extract_relations(predefined_syndrome_relation)
    end

    diagnostic.relations.final_diagnostics.each do |final_diagnostic_relation|
      hash[diagnostic.id]['nodes'] << extract_final_diagnostic(final_diagnostic_relation)
    end
    hash
  end

  def self.extract_final_diagnostic(relation)
    final_diagnostic = relation.node
    hash = {}
    hash['diagnosis'] = {}
    hash['diagnosis'][final_diagnostic.id] = extract_conditions(relation.conditions)
    hash['diagnosis'][final_diagnostic.id]['name'] = final_diagnostic.label
    hash['diagnosis'][final_diagnostic.id]['treatments'] = extract_health_cares(final_diagnostic.treatments, relation.relationable.id)
    hash['diagnosis'][final_diagnostic.id]['managements'] = extract_health_cares(final_diagnostic.managements, relation.relationable.id)
    hash['diagnosis'][final_diagnostic.id]['excluding_diagnosis'] = final_diagnostic.final_diagnostic_id
    hash
  end

  def self.extract_relations(relation)
    hash = {}
    hash[relation.id] = extract_conditions(relation.conditions)
    hash[relation.id]['id'] = relation.id
    hash[relation.id]['children'] = relation.children.collect(&:id)
    hash
  end

  def self.extract_conditions(conditions)
    hash = {}
    hash['top_conditions'] = []
    hash['conditions'] = []

    if conditions.present?
      conditions.top_level.each do |condition|
        hash['top_conditions'] << push_condition(condition)
      end

      conditions.low_level.each do |condition|
        hash['conditions'] << push_condition(condition)
      end
    end
    hash
  end

  def self.push_condition(condition)
    hash = {}
    hash[condition.id] = {}
    hash[condition.id]['first_id'] = condition.first_conditionable_id
    hash[condition.id]['first_type'] = condition.first_conditionable_type
    hash[condition.id]['first_node_id'] = condition.first_conditionable.node.id if condition.first_conditionable.is_a?(Answer)
    hash[condition.id]['operator'] = condition.operator
    hash[condition.id]['second_id'] = condition.second_conditionable_id
    hash[condition.id]['second_type'] = condition.second_conditionable_type
    hash[condition.id]['second_node_id'] = condition.second_conditionable.node.id if condition.second_conditionable.is_a?(Answer)
    hash
  end

  def self.extract_health_cares(health_cares, diagnostic_id)
    hash = {}
    health_cares.each do |health_care|
      hash[health_care.id] = extract_conditions(health_care.relations.find_by_relationable_id(diagnostic_id).conditions)
      hash[health_care.id]['id'] = health_care.id

      # Append the health care in order to list them all at the end of the json.
      assign_node(health_care)
    end
    hash
  end

  def self.assign_node(node)
    case node.type
    when 'Question'
      @questions[node.id] = node if @questions[node.id].nil?
    when 'Treatment'
      @treatments[node.id] = node if @treatments[node.id].nil?
    when 'Management'
      @managements[node.id] = node if @managements[node.id].nil?
    when 'PredefinedSyndrome'
      @predefined_syndromes[node.id] = node if @predefined_syndromes[node.id].nil?
    else
      raise "The given node's type #{node.type} (#{node.reference}) is not handled."
    end
  end

  # Generate hash for nodes
  def self.generate_questions
    hash = {}
    @questions.each do |key, question|
      hash[question.id] = {}
      hash[question.id]['id'] = question.id
      hash[question.id]['label'] = question.label
      hash[question.id]['description'] = question.description
      hash[question.id]['priority'] = question.priority
      hash[question.id]['category'] = question.category.name
      hash[question.id]['display_format'] = question.answer_type.display
      hash[question.id]['value_format'] = question.answer_type.value
      hash[question.id]['answers'] = []

      question.answers.each do |answer|
        answer_hash = {}
        answer_hash[answer.id] = {}
        answer_hash[answer.id]['id'] = answer.id
        answer_hash[answer.id]['reference'] = answer.reference
        answer_hash[answer.id]['label'] = answer.label
        answer_hash[answer.id]['value'] = answer.value
        answer_hash[answer.id]['operator'] = answer.operator

        hash[question.id]['answers'] << answer_hash
      end
    end
    hash
  end

  def self.generate_treatments
    hash = {}
    @treatments.each do |key, treatment|
      hash[treatment.id] = {}
      hash[treatment.id]['id'] = treatment.id
      hash[treatment.id]['label'] = treatment.label
      hash[treatment.id]['description'] = treatment.description
    end
    hash
  end

  def self.generate_managements
    hash = {}
    @managements.each do |key, management|
      hash[management.id] = {}
      hash[management.id]['id'] = management.id
      hash[management.id]['label'] = management.label
      hash[management.id]['description'] = management.description
    end
    hash
  end

  def self.generate_predefined_syndromes
    hash = {}
    @predefined_syndromes.each do |key, predefined_syndrome|
      hash[predefined_syndrome.id] = {}
      hash[predefined_syndrome.id]['nodes'] = []

      predefined_syndrome.relations.includes(:conditions, :children).each do |relation|
        hash[predefined_syndrome.id]['nodes'] << extract_relations(relation)
        hash[predefined_syndrome.id]['answers'] = []

        predefined_syndrome.answers.each do |answer|
          answer_hash = {}
          answer_hash[answer.id] = {}
          answer_hash[answer.id]['id'] = answer.id
          answer_hash[answer.id]['reference'] = answer.reference
          answer_hash[answer.id]['label'] = answer.label

          hash[predefined_syndrome.id]['answers'] << answer_hash
        end
      end
    end
    hash
  end

end
