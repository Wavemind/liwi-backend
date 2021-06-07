# Version of an algorithm with its logic
class Version < ApplicationRecord

  attr_accessor :triage_id
  attr_accessor :cc_id

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnostics, dependent: :destroy
  has_many :medical_case_answers

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  has_many :health_facility_accesses, dependent: :destroy

  has_many :version_languages
  has_many :languages, through: :version_languages

  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  belongs_to :top_left_question, class_name: 'Instance', optional: true
  belongs_to :first_top_right_question, class_name: 'Instance', optional: true
  belongs_to :second_top_right_question, class_name: 'Instance', optional: true

  scope :archived, ->(){ where(archived: true) }
  scope :active, ->(){ where(archived: false) }

  translates :description

  before_create :init_config

  validates_presence_of :name
  validates_presence_of :description_en

  amoeba do
    enable
    include_association :diagnostics
    include_association :components
    append name: I18n.t('duplicated')
  end

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

  # Return an array of all questions that can be instantiate in a version
  def instanceable_questions
    questions = algorithm.questions.where(stage: %w(registration triage)).or(algorithm.questions.where(type: %w(Questions::VitalSignAnthropometric Questions::Referral)))

    questions_json = []
    questions.map do |question|
      questions_json.push({value: question.id, label: question.reference_label})
    end
    questions_json
  end

  # Return an array of all questions that has been instantiated
  def instanciated_questions
    questions = components.map(&:node)

    questions_json = []
    questions.map do |question|
      questions_json.push({value: question.id, label: question.reference_label})
    end
    questions_json
  end

  def is_deployed?
    # TODO : Test currently disabled so the version can be updated during development phase. To be removed !
    # group_accesses.where(end_date: nil).any?
    false
  end

  # Add nodes that are called by the json service
  def extract_nodes_from_version
    nodes = []

    components.each do |instance|
      nodes.push(instance.node)
    end

    diagnostics.each do |diag|
      diag.components.questions.each do |instance|
        nodes.push(instance.node)
      end

      diag.components.questions_sequences.each do |instance|
        nodes = instance.node.extract_nodes(nodes)
      end
    end
    nodes.uniq
  end

  # Return needed nodes for the algorithm version to work but that are not included in it, in order to prevent crash.
  def identify_missing_questions
    nodes = extract_nodes_from_version.map(&:id)

    # Check if questions that are needed are instantiated in diagrams
    nodes_to_add = []

    # Ensure basic questions are included
    algorithm.medal_r_config['basic_questions'].each do |key, id|
      nodes_to_add.push(id) unless nodes.include?(id)
    end

    # Ensure CC linked to the Diagnostics are included
    diagnostics.map(&:node_id).uniq.map do |cc_id|
      nodes_to_add.push(cc_id) unless nodes.include?(cc_id)
    end

    # Ensure nodes in formula are included
    Node.where(id: nodes).where.not(formula: nil).each do |node|
      node.formula.scan(/\[.*?\]/).each do |reference|
        full_reference = reference.gsub(/[\[\]]/, '')
        type, reference = full_reference.match(/([A-Z]*)([0-9]*)/i).captures
        type = Question.get_type_from_prefix(type)

        question = algorithm.questions.find_by(type: type.to_s, reference: reference.to_i)

        nodes_to_add.push(question.id) unless question.nil? || nodes.include?(question.id)
      end
    end

    # Ensure nodes used for reference tables are included
    Node.where(id: nodes).where.not(reference_table_x_id: nil).each do |node|
      nodes_to_add.push(node.reference_table_x_id) unless node.reference_table_x_id.nil? || nodes.include?(node.reference_table_x_id)
      nodes_to_add.push(node.reference_table_y_id) unless node.reference_table_y_id.nil? || nodes.include?(node.reference_table_y_id)
      nodes_to_add.push(node.reference_table_z_id) unless node.reference_table_z_id.nil? || nodes.include?(node.reference_table_z_id)
    end

    nodes_to_add.uniq
  end

  # Generate node order tree from version
  def generate_nodes_order_tree
    tree = []
    Question.steps.each do |step_name, step_index|
      hash = {}
      hash['title'] = I18n.t("questions.steps.#{step_name}")
      hash['subtitle'] =  I18n.t('activerecord.attributes.question.step')
      hash['children'] = []
      if %w(medical_history_step physical_exam_step).include?(step_name)
        Question.systems.each do |system_name, system_index|
          system_hash = {}
          system_hash['title'] = I18n.t("questions.systems.#{system_name}")
          system_hash['subtitle'] =  I18n.t('activerecord.attributes.question.system')
          system_hash['system_name'] = system_name
          system_hash['children'] = []
          algorithm.questions.where(step: step_index, system: system_index).each do |question|
            system_hash['children'].push(question.generate_node_tree_hash)
          end
          hash['children'].push(system_hash)
        end
      else
        algorithm.questions.where(step: step_index).each do |question|
          hash['children'].push(question.generate_node_tree_hash)
        end
      end
      tree.push(hash)
    end
    tree.to_json
  end

  # Init orders for new version
  def init_config
    self.medal_r_config = {
      questions_orders: {
        basic_measurements: [],
        registration_step: [],
        complaint_categories: [],
        first_look_assessment: [],
      },
      systems_order: Question.systems.to_a.map(&:first),
      patient_list_order: [],
      medical_case_list_order: [],
    }
  end
end
