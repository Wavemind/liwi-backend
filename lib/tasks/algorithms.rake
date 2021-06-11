namespace :algorithms do
  desc "Create copy of questions, treatments and managements of an algorithm to a new one. ENV : PROD"
  task copy_algo: :environment do
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        puts "#{Time.zone.now.strftime("%I:%M")} - Copying the Algorithm ..."
        origin_algorithm = Algorithm.find(5)
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
          unless node.is_a?(FinalDiagnostic)
            new_node = copied_algorithm.nodes.new(node.attributes.except('id', 'algorithm_id', 'created_at', 'updated_at'))
            new_node.save(validate: false)

            node.medias.map do |media|
              new_media = Media.new(label_translations: media.label_translations, fileable: new_node)
              new_media.duplicate_file(media)
            end

            if node.is_a?(Question)
              node.answers.each do |answer|
                new_answer = new_node.answers.new(answer.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
                new_answer.save(validate: false)
                answers[answer.id] = new_answer
              end
            elsif node.is_a?(QuestionsSequence)
              node.answers.each do |answer|
                new_answer = new_node.answers.new(answer.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
                new_answer.save(validate: false)
                answers[answer.id] = new_answer
              end
              qss[node.id] = new_node
            elsif node.is_a?(HealthCares::Drug)
              node.formulations.each do |formulation|
                new_formulation = new_node.formulations.new(formulation.attributes.except('id', 'node_id', 'created_at', 'updated_at'))
                new_formulation.save(validate: false)
              end
            end

            nodes[node.id] = new_node
          end
        end


        # Recreate QS diagrams
        puts "#{Time.zone.now.strftime("%I:%M")} - Instancing Nodes in QS diagrams ..."
        qss.map do |key, value|
          old_qs = Node.find(key)
          new_qs = value
          old_qs.components.map do |instance|
            new_instance = new_qs.components.create!(
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
        origin_algorithm.versions.active.each do |version|

          # TODO : Add left/right top questions
          # Update medal_r_config and medal_data_config instead of reseting it
          new_version = copied_algorithm.versions.new(version.attributes.except('id', 'name', 'algorithm_id', 'medal_r_config', 'medal_data_config', 'medal_r_json', 'medal_r_json_version', 'created_at', 'updated_at'))
          new_version.name = "Copy of #{version.name}"
          new_version.init_config
          versions[version.id] = new_version
          new_version.save
          version.diagnostics.map do |diagnostic|
            new_diagnostic = new_version.diagnostics.create!(reference: diagnostic.reference, label_translations: diagnostic.label_translations, node: nodes[diagnostic.node_id])
            diagnostics[diagnostic.id] = new_diagnostic

            diagnostic.final_diagnostics.map do |fd|
              puts "Final diagnosis being copied : #{fd.id}"

              new_fd = copied_algorithm.nodes.new(fd.attributes.except('id', 'algorithm_id', 'diagnostic_id', 'created_at', 'updated_at'))
              new_fd.diagnostic_id = new_diagnostic.id
              new_fd.save(validate: false)

              fd.medias.map do |media|
                new_media = Media.new(label_translations: media.label_translations, fileable: new_fd)
                new_media.duplicate_file(media)
              end

              FinalDiagnosticHealthCare.where(final_diagnostic: fd).map do |link|
                FinalDiagnosticHealthCare.create!(final_diagnostic: new_fd, node_id: nodes[link.node_id].id)
              end

              nodes[fd.id] = new_fd
            end

            diagnostic.components.map do |instance|
              new_instance = new_diagnostic.components.create!(
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
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating links between Instances on the copied diagrams..."
        instances.map do |key, value|
          old_instance = Instance.find(key)
          new_instance = value
          old_instance.children.map do |child|
            Child.create!(instance: new_instance, node: nodes[child.node_id])
          end

          old_instance.conditions.map do |condition|
            Condition.create!(instance: new_instance, answer: answers[condition.answer_id], score: condition.score)
          end
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Exclusions on the copied Nodes..."
        NodeExclusion.where(excluding_node_id: nodes.keys).map do |exclusion|
          NodeExclusion.create!(node_type: exclusion.node_type, excluding_node: nodes[exclusion.excluding_node_id], excluded_node: nodes[exclusion.excluded_node_id])
        end

        puts "#{Time.zone.now.strftime("%I:%M")} - Recreating Complaint Category restrictions on the copied nodes..."
        NodeComplaintCategory.where(node_id: nodes.keys).map do |association|
          NodeComplaintCategory.create!(node: nodes[association.node_id], complaint_category: nodes[association.complaint_category_id])
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
        config['basic_questions'].map do |k, v|
          config['basic_questions'][k] = nodes[v].id
        end
        copied_algorithm.medal_r_config = config
        copied_algorithm.save(validate: false)

      rescue => e
        puts e
        puts e.backtrace
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  def values_from_conditions(conditions)
    values = []
    Answer.find(conditions).each do |answer|
      answer.value.split(',').each do |value|
        values.push(value.to_i)
      end
    end
    values.sort
  end

  task update_cut_offs: :environment do

    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        impossible_diagram_to_manage = []
        Algorithm.all.each do |algorithm|
          puts '#######################################'
          puts algorithm.name
          puts '#######################################'
          algorithm.questions.where('formula LIKE ?', '%To%').each do |cut_off_question|
            cut_off_question.instances.each do |cut_off_instance|
              next if cut_off_instance.instanceable.is_a?(Version)

              puts '***'
              puts cut_off_instance.instanceable_type
              puts cut_off_instance.instanceable_id
              puts '***'

              if cut_off_instance.conditions.any? # Cut off to put in conditions (because not in the top)
                cut_off_instance.children.each do |child|
                  child_instance = cut_off_instance.instanceable.components.where(node: child.node, final_diagnostic_id: nil)
                  conditions = []
                  child_instance.conditions.each do |cond|
                    if cond.answer.node == cut_off_question
                      conditions.push(cond)
                    end
                  end
                  values = values_from_conditions(conditions.map(&:answer_id))
                  cut_off_instance.conditions.each do |parent_cond|
                    if parent_cond.answer.node.formula.present? && parent_cond.answer.node.formula.include?('To')
                      impossible_diagram_to_manage.push(cut_off_instance.instanceable)
                    else
                      child_instance.conditions.create(answer_id: parent_cond.answer_id, cut_off_start: values.first, cut_off_end: values.last, cut_off_value_type: 'months')
                    end
                  end
                end
              else
                if cut_off_instance.instanceable.components.select {|component| component.conditions.any? && component.final_diagnostic_id.nil?}.count > 1
                  impossible_diagram_to_manage.push(cut_off_instance.instanceable)
                else
                  first_child_conditions = cut_off_instance.instanceable.components.where(node: cut_off_instance.children.first.node, final_diagnostic_id: nil).first.conditions.map(&:answer_id).sort
                  impossible_to_manage = false
                  cut_off_instance.children.each do |child|
                    impossible_to_manage = true if child.node.formula.present? && child.node.formula.include?('To')
                    impossible_to_manage = true unless first_child_conditions == cut_off_instance.instanceable.components.where(node: child.node, final_diagnostic_id: nil).first.conditions.map(&:answer_id).sort
                  end

                  if impossible_to_manage
                    impossible_diagram_to_manage.push(cut_off_instance.instanceable)
                  else
                    values = values_from_conditions(first_child_conditions)
                    cut_off_instance.instanceable.update(cut_off_start: values.first, cut_off_end: values.last, cut_off_value_type: 'months')
                    # cut_off_instance.destroy
                  end
                end
              end
            end
          end
        end
        puts '##################################'
        puts 'Diagrams that were impossible to automatically process and need to be handled : '
        impossible_diagram_to_manage.each do |diagram|
          puts diagram.reference_label
        end
        puts '##################################'
      rescue => e
        puts e
        puts e.backtrace
        raise ActiveRecord::Rollback, ''
      end
    end
  end
end

