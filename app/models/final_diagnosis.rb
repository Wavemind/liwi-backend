# Define a final diagnosis
# Reference prefix : DF
class FinalDiagnosis < Node

  belongs_to :diagnosis
  belongs_to :excluded_diagnosis, class_name: 'FinalDiagnosis', foreign_key: :final_diagnosis_id, optional: true

  has_many :medical_case_final_diagnoses
  has_many :medical_cases, through: :medical_case_final_diagnoses

  has_many :final_diagnosis_health_cares, dependent: :destroy
  has_many :health_cares, through: :final_diagnosis_health_cares

  has_many :components, class_name: 'Instance', dependent: :destroy

  before_create :link_algorithm

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :final_diagnosis_health_cares
  end

  # @return [Json]
  # Return drugs and managements in json format
  def health_cares_json
    diagnosis.components.drugs.includes(:answer).where(node_id: health_cares.map(&:id), final_diagnosis_id: id).as_json(
      include: [
        node: {
          include: [:formulations],
          methods: [:node_type, :type]
        },
        conditions: {
          include: [
            answer: {
              methods: [:get_node]
            }
          ]
        }
      ]
    ) + diagnosis.components.managements.where(node_id: health_cares.map(&:id), final_diagnosis_id: id).as_json(
      include: [
        node: {
          include: [:medias],
          methods: [:node_type, :type]
        },
        conditions: {
          include: [
            answer: {
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

  # Return all questions for Final Diagnosis diagram as json
  def health_care_questions_json
    (components.questions.health_care_conditions.includes(:node) + components.questions_sequences.health_care_conditions).as_json(
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
  # TODO: ADD MEDIA
  def available_nodes_health_cares_json
    ids = components.select(:node_id)
    (
      diagnosis.version.algorithm.questions.no_triage.diagrams_included.includes([:answers, :medias]).where.not(id: ids) +
      diagnosis.version.algorithm.questions_sequences.includes([:answers, :medias]).where.not(id: ids) +
      diagnosis.version.algorithm.health_cares.includes([:answers, :medias]).where.not(id: ids)
    ).as_json(methods: [:category_name, :node_type, :get_answers, :type], include: :medias)
  end

  # Get the reference prefix according to the type
  def reference_prefix
    I18n.t("final_diagnoses.reference")
  end

  # Link the DF to its algorithm (from diagnosis)
  def link_algorithm
    self.algorithm = diagnosis.version.algorithm
  end

  # Get instance of final_diagnosis in a diagnosis
  def get_instance_json
      instances.where(instanceable: diagnosis).includes(:node).as_json(
      include: [
        node: {
          methods: [:node_type, :excluded_nodes_ids, :excluding_nodes_ids]
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

  # Construct diagnosis json
  def diagnosis_json
    {
      id: diagnosis.id,
      type: 'FinalDiagnosis',
      reference: diagnosis.reference,
      label: diagnosis.label,
      version_id: diagnosis.version_id,
      chief_complaint_label: diagnosis.node.reference_label
    }
  end
end
