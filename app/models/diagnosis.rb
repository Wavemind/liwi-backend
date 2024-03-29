# How a disease is diagnosed -> Differential diagnoses
# Contains the actual logic from its relations
# Reference prefix : DD
include Rails.application.routes.url_helpers
class Diagnosis < ApplicationRecord
  include Sourceable

  attr_accessor :duplicating
  attr_accessor :cut_off_value_type

  belongs_to :version
  belongs_to :node # Complaint Category
  belongs_to :source, class_name: 'Diagnosis', optional: true

  has_many :final_diagnoses, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  before_validation :validate_complaint_category
  before_save :adjust_cut_offs
  after_create :generate_reference
  validates_presence_of :label_translations

  translates :label

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :components
  end

  # Get translatable attributes to translate with excel import
  def self.get_translatable_params(data)
    fields_to_update = {}

    data.row(1).each_with_index do |head, index|
      if head.include?('Label')
        code = head[/\((.*?)\)/m, 1]
        fields_to_update["label_#{code}"] = index
      end
    end

    fields_to_update
  end

  # Adjust cut offs at creation
  def adjust_cut_offs
    self.cut_off_start = (cut_off_start * 30.4166667).round if cut_off_start.present? && cut_off_value_type == 'months'
    self.cut_off_end = (cut_off_end * 30.4166667).round if cut_off_end.present? && cut_off_value_type == 'months'
    self.cut_off_value_type = '' # Empty attr accessor to prevent callbacks to falsely do the operation more than once
  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  # TODO: ADD MEDIA
  def available_nodes_json
    # Exclude the questions that are already used in the diagnosis diagram (it still takes the questions used in the final diagnosis diagram, since it can be used in both diagram)
    excluded_ids = components.not_health_care_conditions.map(&:node_id)
    (
    version.algorithm.questions.no_treatment_condition.diagrams_included.where.not(id: excluded_ids).includes(:answers, :diagnoses) +
      version.algorithm.questions_sequences.where.not(id: excluded_ids).includes([:answers, :diagnoses]) +
      final_diagnoses.where.not(id: components.select(:node_id))
    ).as_json(methods: [:category_name, :node_type, :get_answers, :type, :dependencies_by_version])
  end

  def category_name
    self.class.name.underscore
  end

  # @return [Boolean]
  # Control method of destroy to avoid callback issue
  def controlled_destroy
    ActiveRecord::Base.transaction(requires_new: true) do
      instances_ids = components.map(&:id)
      Child.where(instance_id: instances_ids).map(&:delete)
      Condition.where(instance_id: instances_ids).map(&:delete)
      components.map(&:delete)
      fd_ids = final_diagnoses.map(&:id)
      NodeExclusion.where(excluding_node_id: fd_ids).or(NodeExclusion.where(excluded_node_id: fd_ids)).map(&:delete)
      final_diagnoses.map(&:delete)
      self.delete
      return true
    end
    false
  end

  # Construct diagnosis json
  def diagnosis_json
    {
      id: id,
      type: 'Diagnosis',
      reference: reference,
      label: label,
      version_id: version_id,
      chief_complaint_label: node.reference_label,
      cut_off_start: cut_off_start,
      cut_off_end: cut_off_end,
    }
  end

  # @return [ActiveRecord::Relation] of drugs
  # Get every drugs used in a diagnosis
  def drugs
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'HealthCares::Drug', id, self.class.name)
  end

  # @return [Json]
  # Return final diagnoses in json format
  def final_diagnoses_json
    components.final_diagnoses.includes(:node).as_json(
      include: [
        node: {
          include: [:diagnosis],
          methods: [:node_type, :excluded_nodes_ids, :excluding_nodes_ids, :dependencies_by_version]
        },
        conditions: {
          include: [
            answer: {
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

  def full_reference
    I18n.t('diagnoses.reference') + reference.to_s
  end

  # Automatic reference generation
  def generate_reference
    if version.diagnoses.count > 1
      self.reference = version.diagnoses.maximum(:reference) + 1
    else
      self.reference = 1
    end
    self.save
  end

  # @return [Json]
  # Return drugs and managements in json format
  def health_cares_json
    components.drugs.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [answer: { methods: [:get_node] }]}]) + components.managements.as_json(include: [node: {methods: [:node_type, :type]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])
  end

  # @return [ActiveRecord::Relation] of managements
  # Get every managements used in a diagnosis
  def managements
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'HealthCares::Management', id, self.class.name)
  end

  # Add errors to a diagnosis for its components
  def manual_validate
    components.includes(:node, :children, :conditions).each do |instance|
      if instance.node.is_a? FinalDiagnosis
        errors.add(:basic, I18n.t('flash_message.diagnosis.final_diagnosis_no_condition', reference: instance.node.full_reference)) unless version.is_arm_control || instance.conditions.any?
      elsif instance.node.is_a?(Question) || instance.node.is_a?(QuestionsSequence)
        unless instance.children.any?
          if instance.final_diagnosis.nil?
            warnings.add(:basic, I18n.t('flash_message.diagnosis.question_no_children', type: instance.node.node_type, reference: instance.node.full_reference))
          else
            warnings.add(:basic, I18n.t('flash_message.diagnosis.hc_question_no_children', type: instance.node.node_type, reference: instance.node.full_reference, url: diagram_algorithm_version_diagnosis_final_diagnosis_url(version.algorithm.id, version.id, id, instance.final_diagnosis_id).to_s, df_reference: instance.final_diagnosis.full_reference))
          end
        end

        if instance.node.is_a? QuestionsSequence
          instance.node.manual_validate
          errors.add(:basic, I18n.t('flash_message.diagnosis.error_in_questions_sequence', url: diagram_questions_sequence_url(instance.node), reference: instance.node.full_reference)) if instance.node.errors.messages.any?
        end
      # elsif instance.node.is_a?(HealthCares::Drug) && instance.node.formulations.map(&:by_age).include?(true)
      #   age_missing = true
      #   instance.conditions.each do |cond|
      #     age_missing = false if %w(ToDay ToMonth).include?(cond.answer.node.formula)
      #   end
      #   errors.add(:basic, I18n.t('flash_message.diagnosis.drug_conditioned_by_age_without_age', url: diagram_algorithm_version_diagnosis_final_diagnosis_url(version.algorithm.id, version.id, id, instance.final_diagnosis_id).to_s, df_reference: instance.final_diagnosis.full_reference)) if age_missing
      end
    end
  end

  # @return [ActiveRecord::Relation] of questions
  # Get every questions asked in a diagnosis
  def questions
    Node.joins(:instances).where('type LIKE ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Questions::%', id, self.class.name)
  end

  # @return [Json]
  # Return questions in json format
  def questions_json
    (components.includes(:node, conditions: :answer).questions.not_health_care_conditions + components.includes(:node, conditions: :answer).questions_sequences.not_health_care_conditions).as_json(
      include: [
        conditions: {
          include: [
            answer: {
              methods: [
                :get_node
              ]
            },
          ]
        },
        node: {
          include: [:answers, :complaint_categories, :medias, :diagnoses],
          methods: [
            :node_type,
            :category_name,
            :type,
            :dependencies_by_version
          ]
        }
      ])
  end

  # @return [ActiveRecord::Relation] of predefined syndromes
  # Get every predefined syndromes used in a diagnosis
  def questions_sequences
    Node.joins(:instances).where('type LIKE ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'QuestionsSequences::%', id, self.class.name)
  end

  # @return [String]
  # Return the label with the reference for the view
  def reference_label(language = 'en')
    "#{full_reference} - #{self.send("label_#{language}")}"
  end

  # @param [Diagnosis]
  # After a duplicate, link DF instances to the duplicated ones instead of the source ones
  def relink_instance
    components_ids = (components - components.final_diagnoses).map(&:id)

    old_diagnosis = nil

    matching_final_diagnoses = {}

    components.final_diagnoses.each do |df_instance|
      old_diagnosis = df_instance.node.diagnosis
      new_df = df_instance.node.amoeba_dup
      new_df.diagnosis_id = id
      new_df.valid?
      if new_df.save(validate: false)
        # Relink children
        Child.where(instance_id: components_ids, node: df_instance.node).each do |child|
          child.update!(node: new_df)
        end

        # Relink final_diagnosis diagram
        Instance.where(id: components_ids, final_diagnosis: df_instance.node).each do |instance|
          instance.update!(final_diagnosis: new_df)
        end

        # Push in matching hash so we can reconstruct the exclusions
        matching_final_diagnoses[df_instance.node_id] = new_df.id

        df_instance.node = new_df
        df_instance.save
      else
        raise ActiveRecord::Rollback, ''
      end
    end

    # Copy final diagnoses that were not instantiated
    old_diagnosis.final_diagnoses.map do |old_fd|
      unless old_fd.instances.any?
        new_fd = final_diagnoses.create(label_translations: old_fd.label_translations, description_translations: old_fd.description_translations)

        # Push in matching hash so we can reconstruct the exclusions
        matching_final_diagnoses[old_fd.id] = new_fd.id
      end
    end unless old_diagnosis.nil?

    NodeExclusion.recreate_exclusions_after_duplicate(matching_final_diagnoses)
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

  # Validate the complaint category that is being linked to the diagnosis
  def validate_complaint_category
    errors.add(:node, I18n.t('flash_message.diagnosis.node_is_not_complaint_category')) unless node.is_a? Questions::ComplaintCategory

    triage_questions = components.joins(:node).where('nodes.stage = ?', Question.stages[:triage])
    triage_questions.each do |instance|
      version_instance = version.components.find_by(node: instance.node)
      errors.add(:node, I18n.t('flash_message.diagnosis.complaint_category_exclude_triage_question')) if version_instance.conditions.any? && version_instance.conditions.map(&:answer).map(&:node).flatten.exclude?(node)
    end
  end

  # Add a warning level to rails validation
  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end
end
