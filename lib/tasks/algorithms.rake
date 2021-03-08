namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task copy_algo: :environment do
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        origin_algorithm = Algorithm.find(1)
        copied_algorithm = Algorithm.new(origin_algorithm.attributes.except('id', 'name', 'medal_r_config', 'created_at', 'updated_at'))
        copied_algorithm.name = "Copy of #{origin_algorithm.name}"
        copied_algorithm.save

        # Init hashes
        nodes = {}
        answers = {}
        diagnostics = {}
        versions = {}
        instances = {}

        origin_algorithm.nodes.each do |node|
          if node.is_a?(Question) && !node.is_default
            new_question = copied_algorithm.nodes.new(node.attributes.except('id', 'reference', 'algorithm_id', 'formula', 'created_at', 'updated_at'))
            new_question.save(validate: false)
            unless [1, 7, 8].include? node.answer_type_id
              node.answers.each do |answer|
                unless answer.value == 'not_available'
                  new_answer = new_question.answers.create(answer.attributes.except('id', 'reference', 'node_id', 'created_at', 'updated_at'))
                  answers[answer.id] = new_answer
                end
              end
            end

            nodes[node.id] = new_question
          elsif node.is_a?(HealthCares::Drug)
            new_drug = copied_algorithm.nodes.create(node.attributes.except('id', 'reference', 'algorithm_id', 'created_at', 'updated_at'))
            node.formulations.each do |formulation|
              new_drug.formulations.create(formulation.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
            end
            nodes[node.id] = new_drug
          elsif node.is_a?(HealthCares::Management)
            new_management = copied_algorithm.nodes.create(node.attributes.except('id', 'reference', 'algorithm_id', 'created_at', 'updated_at'))
            nodes[node.id] = new_management
          elsif node.is_a?(FinalDiagnostic)
            new_management = copied_algorithm.nodes.create(node.attributes.except('id', 'reference', 'algorithm_id', 'created_at', 'updated_at'))
            nodes[node.id] = new_management
          elsif node.is_a?(QuestionsSequence)

          end
        end

        origin_algorithm.versions.each do |version|

        end

      rescue
        raise ActiveRecord::Rollback, ''
      end
    end
  end
end
