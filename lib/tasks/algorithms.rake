namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task copy_algo: :environment do
    origin_algorithm = Algorithm.find(1)
    copied_algorithm = Algorithm.new(origin_algorithm.attributes.except('id', 'name', 'medal_r_config', 'created_at', 'updated_at'))
    copied_algorithm.name = "Copy of #{origin_algorithm.name}"
    copied_algorithm.save
    origin_algorithm.nodes.each do |node|
      if node.is_a? Question && !node.is_default
        new_question = copied_algorithm.nodes.new(node.attributes.except('id', 'reference', 'algorithm_id', 'formula', 'created_at', 'updated_at'))
        new_question.save(validate: false)
        unless [1,7,8].include? node.answer_type_id
          node.answers.each do |answer|
            new_question.answers.create(answer.attributes.except('id', 'reference', 'node_id', 'created_at', 'updated_at')) unless answer.value == 'not_available'
          end
        end
      elsif node.is_a? HealthCares::Drug
        new_drug = copied_algorithm.nodes.create(node.attributes.except('id', 'reference', 'algorithm_id', 'created_at', 'updated_at'))
        node.formulations.each do |formulation|
          new_drug.formulations.create(formulation.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
        end
      elsif node.is_a? HealthCares::Management
        copied_algorithm.nodes.create(node.attributes.except('id', 'reference', 'algorithm_id', 'created_at', 'updated_at'))
      end
    end
  end
end
