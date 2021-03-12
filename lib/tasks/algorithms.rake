namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task copy_algo: :environment do
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        origin_algorithm = Algorithm.find(1)
        copied_algorithm = Algorithm.new(origin_algorithm.attributes.except('id', 'name', 'created_at', 'updated_at'))
        copied_algorithm.name = "Copy of #{origin_algorithm.name}"
        Algorithm.skip_callback(:create, :after, :create_reference_table_questions)
        copied_algorithm.save(validate: false)

        # Init hashes
        nodes = {}
        qss = {}
        answers = {}
        diagnostics = {}
        versions = {}
        instances = {}

        Diagnostic.skip_callback(:create, :after, :generate_reference)
        Answer.skip_callback(:create, :after, :generate_reference)
        Node.skip_callback(:create, :after, :generate_reference)
        Node.skip_callback(:create, :after, :create_unavailable_answer)
        Question.skip_callback(:create, :before, :associate_step)
        Question.skip_callback(:create, :after, :create_positive)
        Question.skip_callback(:create, :after, :create_present)
        Question.skip_callback(:create, :after, :create_boolean)
        QuestionsSequence.skip_callback(:create, :after, :create_boolean)
        Version.skip_callback(:create, :before, :init_config)
        Instance.skip_callback(:create, :after, :push_in_version_order)

        origin_algorithm.nodes.each do |node|
          new_node = copied_algorithm.nodes.new(node.attributes.except('id', 'algorithm_id', 'created_at', 'updated_at'))
          new_node.save(validate: false)

          node.medias.map do |media|
            new_node.medias.create(media.attributes.except('id', 'fileable_id', 'created_at', 'updated_at'))
          end

          if node.is_a?(Question)
            node.answers.each do |answer|
              new_answer = new_node.answers.create(answer.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
              answers[answer.id] = new_answer
            end
          elsif node.is_a?(HealthCares::Drug)
            node.formulations.each do |formulation|
              new_node.formulations.create(formulation.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
            end
          elsif node.is_a?(QuestionsSequence)
            qss[node.id] = new_node
          end

          nodes[node.id] = new_node
        end

        # Recreate QS diagrams
        qss.map do |key, value|
          old_qs = Node.find(key)
          new_qs = value
          old_qs.components.map do |instance|
            new_instance = new_qs.components.create(
              node: nodes[instance.node_id],
              final_diagnostic: nodes[instance.final_diagnostic_id],
              position_x: instance.position_x,
              position_y: instance.position_y,
              duration: instance.duration,
              description: instance.description
            )
            instances[instance.id] = new_instance
          end
        end

        origin_algorithm.versions.each do |version|
          new_version = copied_algorithm.versions.new(version.attributes.except('id', 'name', 'algorithm_id', 'medal_r_json', 'medal_r_json_version', 'created_at', 'updated_at'))
          new_version.name = "Copy of #{version.name}"
          versions[version.id] = new_version

          version.diagnostics.map do |diagnostic|
            new_diagnostic = new_version.diagnostics.create(reference: diagnostic.reference, label_translations: diagnostic.label_translations, node: nodes[diagnostic.node_id])
            diagnostics[diagnostic.id] = new_diagnostic

            diagnostic.components.map do |instance|
              new_instance = new_diagnostic.components.create(
                node: nodes[instance.node_id],
                final_diagnostic: nodes[instance.final_diagnostic_id],
                position_x: instance.position_x,
                position_y: instance.position_y,
                duration: instance.duration,
                description: instance.description
              )
              instances[instance.id] = new_instance
            end

            diagnostic.final_diagnostics.map do |fd|
              nodes[fd.id].update(diagnostic: new_diagnostic)
            end
          end
        end

        instances.map do |key, value|
          old_instance = Instance.find(key)
          new_instance = value
          old_instance.children.map do |child|
            Child.create(instance: new_instance, node: nodes[child.node_id])
          end

          old_instance.conditions.map do |condition|
            Condition.create(instance: new_instance, first_conditionable: answers[condition.first_conditionable_id], top_level: condition.top_level, score: condition.score)
          end
        end

        NodeExclusion.where(excluding_node_id: nodes.keys).map do |exclusion|
          NodeExclusion.create(node_type: exclusion.node_type, excluding_node: nodes[exclusion.excluding_node_id], excluded_node: nodes[exclusion.excluded_node_id])
        end

        NodeComplaintCategory.where(node_id: nodes.keys).map do |association|
          NodeComplaintCategory.create(node: nodes[association.node_id], complaint_category: nodes[association.complaint_category_id])
        end

        copied_algorithm.questions.where.not(reference_table_x_id: nil).map do |reference_table|
          x = nodes[reference_table.reference_table_x_id]
          y = nodes[reference_table.reference_table_y_id]
          z = reference_table.reference_table_z_id.present ? nodes[reference_table.reference_table_z_id] : nil
          reference_table.update(reference_table_x: x, reference_table_y: y, reference_table_z: z)
        end


          # Recreate configs

      rescue
        raise ActiveRecord::Rollback, ''
      end
    end
  end
end

