# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
# Reference prefix : DD
include Rails.application.routes.url_helpers
class Diagnostic < ApplicationRecord
  attr_accessor :duplicating

  belongs_to :version
  belongs_to :node # Complaint Category
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  before_validation :validate_complaint_category
  after_create :generate_reference
  validates_presence_of :label_en

  translates :label

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :components
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

  # @return [ActiveRecord::Relation] of drugs
  # Get every drugs used in a diagnostic
  def drugs
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'HealthCares::Drug', id, self.class.name)
  end

  # @param [Diagnostic]
  # After a duplicate, link DF instances to the duplicated ones instead of the source ones
  def relink_instance
    components_ids = (components - components.final_diagnostics).map(&:id)

    components.final_diagnostics.each do |df_instance|
      new_df = df_instance.node.amoeba_dup
      if new_df.save
        # Relink children
        Child.where(instance_id: components_ids, node: df_instance.node).each do |child|
          child.update!(node: new_df)
        end

        # Relink final_diagnostic diagram
        Instance.where(id: components_ids, final_diagnostic: df_instance.node).each do |instance|
          instance.update!(final_diagnostic: new_df)
        end

        # Relink final diagnostic exclusion
        FinalDiagnostic.where(final_diagnostic_id: df_instance.node_id, diagnostic: self).each do |fd|
          fd.update!(final_diagnostic_id: new_df.id)
        end

        df_instance.node = new_df
        df_instance.save
      else
        raise ActiveRecord::Rollback, ''
      end
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
    (components.questions.not_health_care_conditions + components.questions_sequences.not_health_care_conditions).as_json(
      include: [
        conditions: {
          include: [
            first_conditionable: {
              methods: [
                :get_node
              ]
            },
          ]
        },
        node: {
          include: [:answers, :complaint_categories, :medias],
          methods: [
            :node_type,
            :category_name,
            :type
          ]
        }
      ])
  end

  # @return [Json]
  # Return final diagnostics in json format
  def final_diagnostics_json
    components.final_diagnostics.includes(:node).as_json(
      include: [
        node: {
          methods: [:node_type, :excluded_diagnoses_ids, :excluding_diagnoses_ids]
        },
        conditions: {
          include: [
            first_conditionable: {
              include: [
                node: {
                  include: [:answers]
                }
              ],
              methods: [:get_node]
            }
          ]
        }
      ]
    )
  end

  # @return [Json]
  # Return drugs and managements in json format
  def health_cares_json
    components.drugs.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}]) + components.managements.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    # Exclude triage questions if they have a condition on a CC which is not defined in this diagnostic
    excluded_ids = version.components.select { |i| i.conditions.any? && i.conditions.map(&:first_conditionable).map(&:node).flatten.exclude?(node) }.map(&:node_id)
    # Exclude the questions that are already used in the diagnostic diagram (it still takes the questions used in the final diagnostic diagram, since it can be used in both diagram)
    excluded_ids += components.not_health_care_conditions.map(&:node_id)
    (
      version.algorithm.questions.no_triage.no_treatment_condition.diagrams_included.where.not(id: excluded_ids).includes(:answers) +
      version.algorithm.questions_sequences.where.not(id: excluded_ids).includes([:answers]) +
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

  # Add a warning level to rails validation
  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end

  # Add errors to a diagnostic for its components
  def manual_validate
    components.includes(:node, :children, :conditions).each do |instance|
      if instance.node.is_a? FinalDiagnostic
        errors.add(:basic, I18n.t('flash_message.diagnostic.final_diagnostic_no_condition', reference: instance.node.full_reference)) unless instance.conditions.any?
      elsif instance.node.is_a?(Question) || instance.node.is_a?(QuestionsSequence)
        unless instance.children.any?
          if instance.final_diagnostic.nil?
            warnings.add(:basic, I18n.t('flash_message.diagnostic.question_no_children', type: instance.node.node_type, reference: instance.node.full_reference))
          else
            warnings.add(:basic, I18n.t('flash_message.diagnostic.hc_question_no_children', type: instance.node.node_type, reference: instance.node.full_reference, url: diagram_algorithm_version_diagnostic_final_diagnostic_url(version.algorithm.id, version.id, id, instance.final_diagnostic_id).to_s, df_reference: instance.final_diagnostic.full_reference))
          end
        end

        if instance.node.is_a? QuestionsSequence
          instance.node.manual_validate
          errors.add(:basic, I18n.t('flash_message.diagnostic.error_in_questions_sequence', url: diagram_questions_sequence_url(instance.node), reference: instance.node.full_reference)) if instance.node.errors.messages.any?
        end
      elsif instance.node.is_a?(HealthCares::Drug) && instance.node.formulations.map(&:by_age).include?(true)
        age_missing = true
        instance.conditions.each do |cond|
          age_missing = false if cond.first_conditionable.is_a?(Answer) && !cond.first_conditionable.node.formula.nil? && cond.first_conditionable.node.formula.include?('BD1')
        end
        errors.add(:basic, I18n.t('flash_message.diagnostic.drug_conditioned_by_age_without_age', url: diagram_algorithm_version_diagnostic_final_diagnostic_url(version.algorithm.id, version.id, id, instance.final_diagnostic_id).to_s, df_reference: instance.final_diagnostic.full_reference)) if age_missing
      end
    end
  end

  # Validate the complaint category that is being linked to the diagnostic
  def validate_complaint_category
    errors.add(:node, I18n.t('flash_message.diagnostic.node_is_not_complaint_category')) unless node.is_a? Questions::ComplaintCategory

    triage_questions = components.joins(:node).where('nodes.stage = ?', Question.stages[:triage])
    triage_questions.each do |instance|
      version_instance = version.components.find_by(node: instance.node)
      errors.add(:node, I18n.t('flash_message.diagnostic.complaint_category_exclude_triage_question')) if version_instance.conditions.any? && version_instance.conditions.map(&:first_conditionable).map(&:node).flatten.exclude?(node)
    end
  end

  def full_reference
    I18n.t('diagnostics.reference') + reference.to_s
  end

  # Automatic reference generation
  def generate_reference
    if version.diagnostics.count > 1
      self.reference = version.diagnostics.maximum(:reference) + 1
    else
      self.reference = 1
    end
    self.save
  end

  # Construct diagnostic json
  def diagnostic_json
    {
      id: id,
      type: 'Diagnostic',
      reference: reference,
      label: label,
      version_id: version_id,
      chief_complaint_label: node.reference_label
    }
  end
end
