# Define a final diagnostic
# Reference prefix : DF
class FinalDiagnostic < Node

  belongs_to :diagnostic
  belongs_to :excluded_diagnostic, class_name: 'FinalDiagnostic', foreign_key: :final_diagnostic_id, optional: true

  has_many :medical_case_final_diagnostics
  has_many :medical_cases, through: :medical_case_final_diagnostics

  has_many :final_diagnostic_health_cares, dependent: :destroy
  has_many :health_cares, through: :final_diagnostic_health_cares

  has_many :components, class_name: 'Instance', dependent: :destroy

  before_create :link_algorithm

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :final_diagnostic_health_cares
  end

  # Get every final diagnoses excluded by this final diagnosis
  def excluded_diagnoses_ids
    FinalDiagnosisExclusion.where(excluding_diagnosis_id: id).map(&:excluded_diagnosis_id)
  end

  # Get every final diagnoses excluding this final diagnosis
  def excluding_diagnoses_ids
    FinalDiagnosisExclusion.where(excluded_diagnosis_id: id).map(&:excluding_diagnosis_id)
  end

  # @return [Json]
  # Return drugs and managements in json format
  def health_cares_json
    diagnostic.components.drugs.where(node_id: health_cares.map(&:id), final_diagnostic_id: id).as_json(
      include: [
        node: {
          include: [:formulations],
          methods: [:node_type, :type]
        },
        conditions: {
          include: [
            first_conditionable: {
              methods: [:get_node]
            }
          ]
        }
      ]
    ) + diagnostic.components.managements.where(node_id: health_cares.map(&:id), final_diagnostic_id: id).as_json(
      include: [
        node: {
          methods: [:node_type, :type]
        },
        conditions: {
          include: [
            first_conditionable: {
              methods: [:get_node]
            }
          ]
        }
      ]
    )

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

  # Return all questions for Final Diagnostic diagram as json
  def health_care_questions_json
    (components.questions.health_care_conditions + components.questions_sequences.health_care_conditions).as_json(
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
  # Return available nodes for health cares diagram in the algorithm in json format
  def available_nodes_health_cares_json
    ids = components.select(:node_id)
    (
      diagnostic.version.algorithm.questions.no_triage.diagrams_included.where.not(id: ids) +
      diagnostic.version.algorithm.questions_sequences.where.not(id: ids) +
      diagnostic.version.algorithm.health_cares.where.not(id: ids)
    ).as_json(methods: [:category_name, :node_type, :get_answers, :type])
  end

  # Get the reference prefix according to the type
  def reference_prefix
    I18n.t("final_diagnostics.reference")
  end

  # Link the DF to its algorithm (from diagnostic)
  def link_algorithm
    self.algorithm = diagnostic.version.algorithm
  end

  # Get instance of final_diagnostic in a diagnostic
  def get_instance_json
      instances.where(instanceable: diagnostic).includes(:node).as_json(
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
    ).first
  end

  # Construct diagnostic json
  def diagnostic_json
    {
      id: diagnostic.id,
      type: 'FinalDiagnostic',
      reference: diagnostic.reference,
      label: diagnostic.label,
      version_id: diagnostic.version_id,
      chief_complaint_label: diagnostic.node.reference_label
    }
  end
end
