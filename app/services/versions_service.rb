class VersionsService

  # @params id [Version] id of the algorithm version to extract
  # @return hash
  # Build a hash of an algorithm version with its diagnostics, predefined syndromes, questions and health cares and metadata
  def self.generate_version_hash(id)
    init
    @version = Version.find(id)

    hash = extract_version_metadata
    hash['diseases'] = {}

    # Loop in each diagnostics defined in current algorithm version
    @version.diagnostics.includes(:conditions).each do |diagnostic|
      @diagnostics_ids << diagnostic.id
      hash['diseases'][diagnostic.id] = extract_diagnostic(diagnostic)
    end

    # Set all questions/treatments/managements used in this version of algorithm
    hash['nodes'] = generate_nodes

    hash
  end

  # @params [Diagnostic]
  def self.generate_diagnostic_hash(diagnostic)
    init

    hash = extract_diagnostic_metadata(diagnostic)
    hash['diagnostic'] = extract_diagnostic(diagnostic)
    hash['nodes'] = generate_nodes
    hash
  end

  private

  def self.init
    @questions = {}
    @treatments = {}
    @managements = {}
    @questions_sequences = {}
    @final_diagnostics = {}

    # Get all qs and dd ids in order to build working diagnosis
    @diagnostics_ids = []
    @questions_sequences_ids = []
  end
  
  def self.generate_nodes
    hash = {}
    hash = hash.merge(generate_questions_sequences)
    hash = hash.merge(generate_questions)
    hash = hash.merge(generate_managements)
    hash = hash.merge(generate_treatments)
    hash.merge(@final_diagnostics)
  end

  # @return hash
  # Build a hash of metadata about the algorithm and algorithm version
  def self.extract_diagnostic_metadata(diagnostic)
    hash = {}
    hash['id'] = diagnostic.id
    hash
  end

  # @return hash
  # Build a hash of metadata about the algorithm and algorithm version
  def self.extract_version_metadata
    hash = {}
    hash['id'] = @version.id
    hash['algorithm_id'] = @version.algorithm.id
    hash['name'] = @version.algorithm.name
    hash['version'] = @version.name
    hash['description'] = @version.algorithm.description
    hash['author'] = @version.user.full_name
    hash['created_at'] = @version.created_at
    hash['updated_at'] = @version.updated_at
    hash
  end

  # @params object [Diagnostic]
  # @return hash
  # Set metadata of diagnostic and it's condition for differential diagnosis
  def self.extract_diagnostic(diagnostic)
    hash = {}
    hash['id'] = diagnostic.id
    hash['reference'] = diagnostic.reference
    hash['label'] = diagnostic.label
    hash['differential'] = extract_conditions(diagnostic.conditions)
    hash['nodes'] = {}
    hash['diagnosis'] = {}

    # Loop in each question used in current diagnostic
    diagnostic.components.questions.includes([:children, :nodes, node:[:answers, :answer_type]]).each do |question_instance|
      # Append the questions in order to list them all at the end of the json.
      assign_node(question_instance.node)

      hash['nodes'][question_instance.node.id] = extract_instances(question_instance)
    end

    # Loop in each predefined syndromes used in current diagnostic
    diagnostic.components.questions_sequences.includes([:children, :nodes, node:[:answers]]).each do |questions_sequence_instance|
      # Append the predefined syndromes in order to list them all at the end of the json.
      assign_node(questions_sequence_instance.node)

      hash['nodes'][questions_sequence_instance.node.id] = extract_instances(questions_sequence_instance)
    end

    # Loop in each final diagnostics for set conditional acceptance and health cares related to it
    diagnostic.components.final_diagnostics.each do |final_diagnostic_instance|
      final_diagnostic_hash = extract_final_diagnostic(final_diagnostic_instance)
      @final_diagnostics[final_diagnostic_instance.node.id] = final_diagnostic_hash
      hash['diagnosis'][final_diagnostic_instance.node.id] = final_diagnostic_hash
    end

    hash
  end

  # @params object [Instance]
  # @return hash
  # Set metadata of a final diagnostic
  def self.extract_final_diagnostic(instance)
    final_diagnostic = instance.node
    hash = extract_conditions(instance.conditions)
    hash['disease_id'] = final_diagnostic.diagnostic.id
    hash['name'] = final_diagnostic.label
    hash['id'] = final_diagnostic.id
    hash['type'] = final_diagnostic.node_type
    hash['treatments'] = extract_health_cares(final_diagnostic.health_cares.treatments, instance.instanceable.id)
    hash['managements'] = extract_health_cares(final_diagnostic.health_cares.managements, instance.instanceable.id)
    hash['excluding_diagnosis'] = final_diagnostic.final_diagnostic_id
    hash
  end

  # @params object [Instance]
  # @return hash
  # Set children and condition for current node
  def self.extract_instances(instance)
    hash = extract_conditions(instance.conditions)
    hash['id'] = instance.node.id
    hash['children'] = instance.nodes.collect(&:id)
    hash
  end

  # @params array [Conditions]
  # @return hash
  # Return hash of top conditions and conditions
  def self.extract_conditions(conditions)
    hash = {}
    hash['top_conditions'] = []
    hash['conditions'] = []

    if conditions.present?
      conditions.includes([:first_conditionable, :second_conditionable]).top_level.each do |condition|
        hash['top_conditions'] << push_condition(condition)
      end

      conditions.low_level.each do |condition|
        hash['conditions'] << push_condition(condition)
      end
    end
    hash
  end

  # @params hash [Condition]
  # @return hash
  # Set metadata for condition
  def self.push_condition(condition)
    hash = {}
    hash['first_id'] = condition.first_conditionable_id
    hash['first_type'] = condition.first_conditionable_type

    # Give the question's/predefined syndrome's id in order to retrieve it in front-end
    hash['first_node_id'] = condition.first_conditionable.is_a?(Answer) ? condition.first_conditionable.node.id : nil

    hash['operator'] = condition.operator
    hash['second_id'] = condition.second_conditionable_id
    hash['second_type'] = condition.second_conditionable_type

    # Give the question's/predefined syndrome's id in order to retrieve it in front-end
    hash['second_node_id'] = condition.second_conditionable.is_a?(Answer) ? condition.second_conditionable.node.id : nil
    hash['score'] = condition.score
    hash
  end

  # @params activerecord collection [Treatment, Management]
  # @params [Integer] id of current diagnostic
  # @return hash
  # Set metadata for treatments and managements (health cares)
  def self.extract_health_cares(health_cares, diagnostic_id)
    hash = {}
    health_cares.each do |health_care|
      hash[health_care.id] = extract_conditions(health_care.instances.find_by_instanceable_id(diagnostic_id).conditions)
      hash[health_care.id]['id'] = health_care.id

      # Append the health care in order to list them all at the end of the json.
      assign_node(health_care)
    end
    hash
  end

  # @params object [Node]
  # Push the current node in the appropriate hash if it doesn't exist
  def self.assign_node(node)
    case node.node_type
    when 'Question'
      @questions[node.id] = node if @questions[node.id].nil?
    when 'HealthCare'
      if node.category_name == 'treatment'
        @treatments[node.id] = node if @treatments[node.id].nil?
      else
        @managements[node.id] = node if @managements[node.id].nil?
      end
    when 'QuestionsSequence'
      @questions_sequences_ids << node.id
      @questions_sequences[node.id] = node if @questions_sequences[node.id].nil?

      # Recursive nodes on PS
      Instance.where(instanceable: node).each do |instance|
        assign_node(instance.node) unless instance.node == node
      end
    else
      raise "The given node's type #{node.node_type} (#{node.reference}) is not handled."
    end
  end

  # @return hash
  # Generate all questions with its answers
  def self.generate_questions
    hash = {}
    @questions.each do |key, question|
      hash[question.id] = {}
      hash[question.id]['id'] = question.id
      hash[question.id]['type'] = question.node_type
      hash[question.id]['reference'] = question.reference
      hash[question.id]['label'] = question.label
      hash[question.id]['description'] = question.description
      hash[question.id]['priority'] = question.priority
      hash[question.id]['stage'] = question.stage
      hash[question.id]['category'] = question.category_name
      hash[question.id]['display_format'] = question.answer_type.display
      hash[question.id]['value_format'] = question.answer_type.value
      hash[question.id]['qs'] = get_node_questions_sequences(question, [])
      hash[question.id]['dd'] = get_node_diagnostics(question, [])
      hash[question.id]['counter'] = 0
      hash[question.id]['value'] = 0
      hash[question.id]['answer'] = nil
      hash[question.id]['answers'] = {}

      question.answers.each do |answer|
        answer_hash = {}
        answer_hash['id'] = answer.id
        answer_hash['reference'] = answer.reference
        answer_hash['label'] = answer.label
        answer_hash['value'] = answer.value
        answer_hash['operator'] = answer.operator

        hash[question.id]['answers'][answer.id] = answer_hash
      end
    end
    hash
  end

  # @params [Node, Array]
  # @return [Array]
  # Recursive method in order to retrieve every diagnostics the question appears in.
  def self.get_node_diagnostics(node, diagnostics)
    node.instances.map(&:instanceable).each do |instanceable|
      unless instanceable == node
        if instanceable.is_a?(Diagnostic)
          # push the id in the array only if it is not already there and if it is handled by the current algorithm version
          if @diagnostics_ids.include?(instanceable.id) && !diagnostics.include?(instanceable.id)
            hash = {}
            hash['id'] = instanceable.id
            hash['conditionValue'] = nil
            diagnostics << hash
          end
        end
      end
    end
    diagnostics
  end

  # @params [Node, Array]
  # @return [Array]
  # Recursive method in order to retrieve every predefined syndromes the question appears in.
  def self.get_node_questions_sequences(node, questions_sequences)
    node.instances.map(&:instanceable).each do |instanceable|
      unless instanceable == node
        if instanceable.is_a?(Node)
          # push the id in the array only if it is not already there and if it is handled by the current algorithm version
          if @questions_sequences_ids.include?(instanceable.id) && !questions_sequences.include?(instanceable.id)
            hash = {}
            hash['id'] = instanceable.id
            hash['conditionValue'] = nil
            questions_sequences << hash
          end
        end
      end
    end
    questions_sequences
  end

  # @return hash
  # Generate all treatments
  def self.generate_treatments
    hash = {}
    @treatments.each do |key, treatment|
      hash[treatment.id] = {}
      hash[treatment.id]['id'] = treatment.id
      hash[treatment.id]['type'] = treatment.node_type
      hash[treatment.id]['reference'] = treatment.reference
      hash[treatment.id]['label'] = treatment.label
      hash[treatment.id]['description'] = treatment.description
    end
    hash
  end

  # @return hash
  # Generate all managements
  def self.generate_managements
    hash = {}
    @managements.each do |key, management|
      hash[management.id] = {}
      hash[management.id]['id'] = management.id
      hash[management.id]['type'] = management.node_type
      hash[management.id]['reference'] = management.reference
      hash[management.id]['label'] = management.label
      hash[management.id]['description'] = management.description
    end
    hash
  end

  # @return hash
  # Generate all predefined syndromes with its answers and conditions related
  def self.generate_questions_sequences
    hash = {}
    @questions_sequences.each do |key, questions_sequence|
      hash[questions_sequence.id] = extract_conditions(questions_sequence.instances.find_by(instanceable_id: questions_sequence.id).conditions)
      hash[questions_sequence.id]['id'] = questions_sequence.id
      hash[questions_sequence.id]['reference'] = questions_sequence.reference
      hash[questions_sequence.id]['min_score'] = questions_sequence.min_score
      hash[questions_sequence.id]['type'] = questions_sequence.node_type
      hash[questions_sequence.id]['category'] = questions_sequence.category_name
      hash[questions_sequence.id]['nodes'] = {}
      hash[questions_sequence.id]['answers'] = push_questions_sequence_answers(questions_sequence)
      hash[questions_sequence.id]['qs'] = get_node_questions_sequences(questions_sequence, [])
      hash[questions_sequence.id]['dd'] = get_node_diagnostics(questions_sequence, [])
      hash[questions_sequence.id]['answer'] = nil

      # Loop in each instance for defined condition
      questions_sequence.components.questions.includes(:conditions, :children, :nodes, node:[:answer_type, :answers]).each do |instance|
        # assign_node(instance.node)
        hash[questions_sequence.id]['nodes'][instance.node.id] = extract_instances(instance)
      end

      questions_sequence.components.questions_sequences.includes(:conditions, :children, :nodes).each do |instance|
        hash[questions_sequence.id]['nodes'][instance.node.id] = extract_instances(instance) unless questions_sequence == instance.node
      end
    end
    hash
  end

  # Loop in each output possibilities(answer) for defined predefined syndrome
  def self.push_questions_sequence_answers(questions_sequence)
    hash = {}
    questions_sequence.answers.each do |answer|
      answer_hash = {}
      answer_hash['id'] = answer.id
      answer_hash['reference'] = answer.reference
      answer_hash['label'] = answer.label

      hash[answer.id] = answer_hash
    end
    hash
  end
end
