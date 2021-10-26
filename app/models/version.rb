# Version of an algorithm with its logic
class Version < ApplicationRecord

  attr_accessor :triage_id
  attr_accessor :cc_id

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnoses, dependent: :destroy

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  has_many :health_facility_accesses, dependent: :destroy

  has_many :version_languages
  has_many :languages, through: :version_languages

  has_many :medal_data_config_variables
  accepts_nested_attributes_for :medal_data_config_variables, reject_if: :all_blank, allow_destroy: true

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
    include_association :diagnoses
    include_association :components
    append name: I18n.t('duplicated')
  end

  # Return badge if the version is archived
  def display_archive_status
    archived ? '<span class="badge badge-danger">archived</span>' : ''
  end

  # @return [String]
  # Return a displayable string for this version
  def display_label
    "#{algorithm.name} - #{name}"
  end

  # Duplicate the version
  def duplicate
    ActiveRecord::Base.transaction(requires_new: true) do
      diagnoses.each { |diagnosis| diagnosis.update(duplicating: true) }
      duplicated_version = self.amoeba_dup

      if duplicated_version.save
        duplicated_version.diagnoses.each_with_index { |diagnosis, index| diagnosis.relink_instance }
        diagnoses.each { |diagnosis| diagnosis.update(duplicating: false) }
      else
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  # Add nodes that are called by the json service
  def extract_nodes_from_version
    nodes = []

    components.includes(:node).each do |instance|
      nodes.push(instance.node)
    end

    diagnoses.each do |diag|
      diag.components.includes(:node).questions.each do |instance|
        nodes.push(instance.node)
      end

      diag.components.includes(:node).questions_sequences.each do |instance|
        nodes = instance.node.extract_nodes(nodes)
      end
    end
    nodes.uniq
  end

  # Generate node order tree from version
  def generate_nodes_order_tree
    tree = []
    Question.steps.each do |step_name, step_index|
      hash = {}
      hash['title'] = I18n.t("questions.steps.#{step_name}")
      hash['subtitle'] =  I18n.t('versions.full_order_tree.subtitles.step')
      hash['type'] = 'step'
      hash['children'] = []
      if %w(medical_history_step physical_exam_step).include?(step_name)
        Question.systems.each do |system_name, system_index|
          system_hash = {}
          system_hash['title'] = I18n.t("questions.systems.#{system_name}")
          system_hash['subtitle'] =  I18n.t('versions.full_order_tree.subtitles.system')
          system_hash['subtitle_name'] = system_name
          system_hash['type'] = 'system'
          system_hash['children'] = []
          algorithm.questions.where(step: step_index, system: system_index).each do |question|
            system_hash['children'].push(question.generate_node_tree_hash)
          end
          hash['children'].push(system_hash)
        end
      elsif step_name == 'complaint_categories_step'
        older_children_hash = {}
        older_children_hash['title'] = I18n.t('older_children')
        older_children_hash['subtitle'] = I18n.t('versions.full_order_tree.subtitles.attribute')
        older_children_hash['subtitle_name'] = 'older_children'
        older_children_hash['type'] = 'attribute'
        older_children_hash['children'] = []
        algorithm.questions.where(step: step_index, is_neonat: false).each do |question|
          older_children_hash['children'].push(question.generate_node_tree_hash)
        end
        hash['children'].push(older_children_hash)

        neonat_hash = {}
        neonat_hash['title'] = I18n.t('neonat_children')
        neonat_hash['subtitle'] = I18n.t('versions.full_order_tree.subtitles.attribute')
        neonat_hash['subtitle_name'] = 'neonat_children'
        neonat_hash['type'] = 'attribute'
        neonat_hash['children'] = []
        algorithm.questions.where(step: step_index, is_neonat: true).each do |question|
          neonat_hash['children'].push(question.generate_node_tree_hash)
        end
        hash['children'].push(neonat_hash)
      else
        if step_name == 'registration_step' # Add the 3 hard coded questions in the order
          hash['children'].push({"id"=>'first_name', "title"=>I18n.t('questions.basic_questions.first_name'), "is_neonat"=>false, "expanded"=>false})
          hash['children'].push({"id"=>'last_name', "title"=>I18n.t('questions.basic_questions.last_name'), "is_neonat"=>false, "expanded"=>false})
          hash['children'].push({"id"=>'birth_date', "title"=>I18n.t('questions.basic_questions.birth_date'), "is_neonat"=>false, "expanded"=>false})
        end
        algorithm.questions.where(step: step_index).each do |question|
          hash['children'].push(question.generate_node_tree_hash)
        end
      end
      tree.push(hash)
    end
    tree.to_json
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

    # Ensure CC linked to the Diagnoses are included
    diagnoses.map(&:node_id).uniq.map do |cc_id|
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

  # Return an array of all questions that can be instantiate in a version
  def instanceable_questions(l = 'en')
    questions = algorithm.questions.where(stage: %w(registration triage)).or(algorithm.questions.where(type: %w(Questions::VitalSignAnthropometric Questions::Referral)))

    questions_json = []
    questions.map do |question|
      questions_json.push({value: question.id, label: question.reference_label(l)})
    end
    questions_json
  end

  # Init orders for new version
  def init_config
    self.full_order_json = generate_nodes_order_tree
  end

  # Return if the version is currently deployed and can't be updated
  def is_deployed?
    # TODO : Test currently disabled so the version can be updated during development phase. To be removed !
    # group_accesses.where(end_date: nil).any?
    false
  end

  # Fill labels for every node with the translation based on study settings
  def fill_order_labels
    l = algorithm.study.default_language
    order = JSON.parse(full_order_json)
    order.each do |step|
      step['children'].each do |child|
        if %w(Attribute System).include?(child['subtitle'])
          child['children'].each do |node|
            node['title'] = Node.find(node['id']).reference_label(l)
          end
        else
          if %w(first_name last_name birth_date).include?(child['id'])
            I18n.default_locale = l
            child['title'] = I18n.t("questions.basic_questions.#{child['id']}")
            I18n.default_locale = :en
          else
            child['title'] = Node.find(child['id']).reference_label(l)
          end
        end
      end
    end
    order.to_json
  end

  # @param [String] language to translate the version name
  # @return [String]
  # Return the label of the version
  def reference_label(language = 'en')
    name
  end

  # Validate full_order_json
  def validate_order
    json = JSON.parse(full_order_json)
    steps = Question.steps.map(&:first)
    wrong_steps = []
    json.each_with_index do |step_order, index|
      step = steps[index]
      questions_order_count = 0
      if %w(complaint_categories_step medical_history_step physical_exam_step).include?(step)
        step_order['children'].each do |system|
          questions_order_count += system['children'].count
        end
      else
        questions_order_count = step_order['children'].count
        questions_order_count -= 3 if step == 'registration_step' # Count the 3 default questions (firstname lastname birthdate)
      end
      wrong_steps.push(step) unless algorithm.questions.where(step: step).count == questions_order_count
    end
    wrong_steps
  end
end
