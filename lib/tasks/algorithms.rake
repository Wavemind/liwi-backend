namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task copy_algo: :environment do
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        puts "#{Time.zone.now.strftime("%I:%M")} - Copying the Algorithm ..."
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

        Questions::AssessmentTest.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::ChronicCondition.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Exposure.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::PhysicalExam.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Symptom.skip_callback(:create, :after, :create_unavailable_answer)
        Questions::Vaccine.skip_callback(:create, :after, :create_unavailable_answer)

        FinalDiagnostic.skip_callback(:create, :before, :link_algorithm)
        Question.skip_callback(:create, :before, :associate_step)
        Question.skip_callback(:create, :after, :create_positive)
        Question.skip_callback(:create, :after, :create_present)
        Question.skip_callback(:create, :after, :create_boolean)
        QuestionsSequence.skip_callback(:create, :after, :create_boolean)
        Version.skip_callback(:create, :before, :init_config)
        Instance.skip_callback(:create, :after, :push_in_version_order)
        Condition.skip_callback(:validation, :before, :prevent_loop)

        puts "#{Time.zone.now.strftime("%I:%M")} - Copying the Nodes ..."
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
          elsif node.is_a?(QuestionsSequence)
            node.answers.each do |answer|
              new_answer = new_node.answers.create(answer.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
              answers[answer.id] = new_answer
            end
            qss[node.id] = new_node
          elsif node.is_a?(HealthCares::Drug)
            node.formulations.each do |formulation|
              new_node.formulations.create(formulation.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
            end
          end

          nodes[node.id] = new_node
        end

        # Recreate QS diagrams
        puts "#{Time.zone.now.strftime("%I:%M")} - Instancing Nodes in QS diagrams ..."
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

        puts "#{Time.zone.now.strftime("%I:%M")} - Copying Versions and their Diagnoses, along with the Instances in the diagrams..."
        origin_algorithm.versions.each do |version|
          new_version = copied_algorithm.versions.new(version.attributes.except('id', 'name', 'algorithm_id', 'medal_r_config', 'medal_data_config', 'medal_r_json', 'medal_r_json_version', 'created_at', 'updated_at'))
          new_version.name = "Copy of #{version.name}"
          new_version.init_config
          versions[version.id] = new_version
          new_version.save
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
              puts "Final diagnosis being copied : #{fd.id}"
              new_fd = nodes[fd.id]
              new_fd.update(diagnostic: new_diagnostic)
            end
          end
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating links between Instances on the copied diagrams..."
        instances.map do |key, value|
          old_instance = Instance.find(key)
          new_instance = value
          old_instance.children.map do |child|
            Child.create(instance: new_instance, node: nodes[child.node_id])
          end

          old_instance.conditions.map do |condition|
            Condition.create(referenceable: new_instance, first_conditionable: answers[condition.first_conditionable_id], top_level: condition.top_level, score: condition.score)
          end
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Exclusions on the copied Nodes..."
        NodeExclusion.where(excluding_node_id: nodes.keys).map do |exclusion|
          NodeExclusion.create(node_type: exclusion.node_type, excluding_node: nodes[exclusion.excluding_node_id], excluded_node: nodes[exclusion.excluded_node_id])
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Complaint Category restrictions on the copied nodes..."
        NodeComplaintCategory.where(node_id: nodes.keys).map do |association|
          NodeComplaintCategory.create(node: nodes[association.node_id], complaint_category: nodes[association.complaint_category_id])
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Relinking the reference tables to the copied Nodes..."
        copied_algorithm.questions.where.not(reference_table_x_id: nil).map do |reference_table|
          x = nodes[reference_table.reference_table_x_id]
          y = nodes[reference_table.reference_table_y_id]
          z = reference_table.reference_table_z_id.present? ? nodes[reference_table.reference_table_z_id] : nil
          reference_table.update(reference_table_x: x, reference_table_y: y, reference_table_z: z)
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating configs ..."
        config = copied_algorithm.medal_r_config
        config['basic_questions'].map do |k,v|
          config['basic_questions'][k] = nodes[v].id
        end

      rescue => e
        puts e
        puts e.backtrace
        raise ActiveRecord::Rollback, ''
      end
    end
  end
end

