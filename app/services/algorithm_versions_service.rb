class AlgorithmVersionsService



  # @params id [AlgorithmVersion] id of the algorithm version to extract
  # @return json
  # Build a json of an algorithm version with its diagnostics, predefined syndromes, questions and health cares
  def generate_json(id)
    @algorithm_version = AlgorithmVersion.find(id)

    @managements = {}
    @questions = {}
    @treatments = {}

    @diseases = {}
    @algorithm_version.diagnostics.each do |diagnostic|
      extract_diagnostic(diagnostic)
    end

    extract_questions
    extract_managements
    extract_treatments
  end

  private

  def extract_diagnostic(diagnostic)
    hash = {}
    hash[diagnostic.reference] = {}
    hash[diagnostic.reference]['id'] = diagnostic.reference
    hash[diagnostic.reference]['label'] = diagnostic.label
    hash[diagnostic.reference]['differential'] = nil

    diagnostic.relations.each do |relation|
      relation
    end
  end

  def extract_managements

  end

  def extract_questions

  end

  def extract_treatments

  end

end
