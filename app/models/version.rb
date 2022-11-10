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

  translates :age_limit_message, :description

  before_create :init_config

  validates_presence_of :name, :description_en, :age_limit, :age_limit_message, :minimum_age
  validates :age_limit, numericality: { greater_than_or_equal_to: 1 }
  validates :minimum_age, numericality: { greater_than_or_equal_to: 0 }

  amoeba do
    enable
    include_association :diagnoses
    include_association :components
    append name: I18n.t('duplicated')
  end

  def self.validate_duplicate(origin_id, duplicate_id)
    require "json-diff"

    origin_version = Version.find(origin_id) # 58
    duplicated_version = Version.find(duplicate_id) # 72
    origin_json = origin_version.medal_r_json
    duplicated_json = duplicated_version.medal_r_json
    origin_fd_ids = origin_version.diagnoses.map(&:final_diagnoses).flatten.map(&:id)
    errors = []

    # Compare root json keys
    errors.concat(JsonDiff.diff(Version.first_keys(duplicated_json), Version.first_keys(origin_json)))
    # Compare questions and qss with out the keys relating to the diagnosis (ids expected to be different) and media (link regenerated)
    errors.concat(JsonDiff.diff(duplicated_json.slice('nodes'), origin_json.slice('nodes')).select{|node|
      node['path'].exclude?('/diagnoses_related_to_cc/') &&
        node['path'].exclude?('/dd/') &&
        node['path'].exclude?('/medias/') &&
        node['path'].exclude?('/df/')})
    # Compare drugs and managements without media
    errors.concat(JsonDiff.diff(duplicated_json.slice('health_cares'), origin_json.slice('health_cares')).select{|node| node['path'].exclude?('/medias/')})
    # Compare final diagnoses without ids and media
    errors.concat(JsonDiff.diff(Version.format_fd_json(duplicated_json), Version.format_fd_json(origin_json)).select{|final_diagnosis| final_diagnosis['path'].exclude?('/medias/')})
    # Compare diagnoses without ids and ignoring errors relating to final diagnoses ids (since they got duplicated) and children order (which is not relevant to the functionality)
    errors.concat(JsonDiff.diff(Version.format_diagnosis_json(duplicated_json), Version.format_diagnosis_json(origin_json)).select{|diagnosis|
      diagnosis["op"] != "move" &&
        diagnosis['path'].exclude?('/final_diagnosis_id') &&
        !(diagnosis["op"] == "remove" && diagnosis['path'].include?('/children/')) &&
        !(diagnosis["op"] == "add" && diagnosis['path'].include?('/children/') && origin_fd_ids.include?(diagnosis["value"]))
    })

    errors.push("Diagnoses count not equal") if origin_version.diagnoses.count != duplicated_version.diagnoses.count
    errors.push("Final diagnoses count not equal") if origin_version.diagnoses.includes(:final_diagnoses).map(&:final_diagnoses).flatten.count != duplicated_version.diagnoses.includes(:final_diagnoses).map(&:final_diagnoses).flatten.count
    errors.push("Instances count not equal") if origin_version.diagnoses.includes(:components).map(&:components).flatten.count != duplicated_version.diagnoses.includes(:components).map(&:components).flatten.count
    errors.push("Conditions count not equal") if origin_version.diagnoses.includes(components: [:conditions]).map(&:components).flatten.map(&:conditions).flatten.count != duplicated_version.diagnoses.includes(components: [:conditions]).map(&:components).flatten.map(&:conditions).flatten.count
    errors
  end

  # Format final diagnoses key to not include final diagnoses and diagnoses ids
  def self.format_fd_json(json)
    json['final_diagnoses'].values.map do |dd|
      dd.except('id', 'diagnosis_id', 'excluding_final_diagnoses')
    end
  end

  # Format diagnoses to not include final diagnoses and diagnoses ids
  def self.format_diagnosis_json(json)
    json['diagnoses'].values.map do |df|
      df.except('id', 'final_diagnoses', 'excluding_final_diagnoses')
    end
  end

  def self.first_keys(json)
    json.except('version_id', 'version_name', 'json_version', 'created_at', 'updated_at', 'nodes', 'health_cares',
                'final_diagnoses', 'diagnoses')

  end

  # @return [Json]
  # Return available nodes in the algorithm in json format
  def available_nodes_json
    ids = components.map(&:node_id)
    nodes = algorithm.questions.includes(:answers).where.not(id: ids)
    nodes += algorithm.questions_sequences.includes(:answers).where.not(id: ids)
    nodes.as_json(methods: [:category_name, :node_type, :get_answers, :type, :dependencies_by_version])
  end

  def category_name
    self.class.name.underscore
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
      begin
        Diagnosis.skip_callback(:create, :after, :generate_reference)
        Node.skip_callback(:create, :after, :generate_reference)
        matching_final_diagnoses = {}
        matching_instances = {}
        # Recreate version
        new_version = Version.create!(self.attributes.except('id', 'name', 'job_id', 'created_at', 'updated_at').merge({'name': "Copy of #{name}"}))

        # Recreate components
        components.each do |instance|
          new_instance = new_version.components.create!(instance.attributes.except('id', 'final_diagnosis_id', 'created_at', 'updated_at'))
          # Store matching instances to recreate conditions afterwards
          matching_instances[instance.id] = new_instance
        end

        # Recreate Medal Data variables
        medal_data_config_variables.each do |config|
          new_version.medal_data_config_variables.create!(config.attributes.except('id', 'version_id'))
        end

        # Recreate diagnoses
        diagnoses.each do |diagnosis|
          new_diagnosis = new_version.diagnoses.create!(diagnosis.attributes.except('id', 'version_id', 'created_at', 'updated_at'))
          # Recreate final diagnoses
          diagnosis.final_diagnoses.each do |final_diagnosis|
            new_final_diagnosis = new_diagnosis.final_diagnoses.create!(final_diagnosis.attributes.except('id', 'diagnosis_id', 'created_at', 'updated_at'))
            # Store matching final diagnoses to recreate exclusions
            matching_final_diagnoses[final_diagnosis.id] = new_final_diagnosis.id
          end
          # Recreate instances
          diagnosis.components.each do |instance|
            node_id = instance.node.is_a?(FinalDiagnosis) ? matching_final_diagnoses[instance.node_id] : instance.node_id
            new_instance = new_diagnosis.components.create!(instance.attributes.except('id', 'final_diagnosis_id', 'created_at', 'updated_at').merge({'final_diagnosis_id': matching_final_diagnoses[instance.final_diagnosis_id], 'node_id': node_id}))
            # Store matching instances to recreate conditions afterwards
            matching_instances[instance.id] = new_instance
          end
        end
        # Recreate exclusions
        NodeExclusion.where(excluding_node_id: matching_final_diagnoses.keys).each do |exclusion|
          NodeExclusion.create(excluding_node_id: matching_final_diagnoses[exclusion.excluding_node_id], excluded_node_id: matching_final_diagnoses[exclusion.excluded_node_id], node_type: 'final_diagnosis')
        end
        # Recreate conditions
        matching_instances.each do |instance_id, new_instance|
          instance = Instance.find(instance_id)
          instance.conditions.each do |condition|
            new_instance.conditions.create!(condition.attributes.slice('score', 'cut_off_start', 'cut_off_end', 'answer_id'))
          end
        end
      rescue => e
        puts e
        puts e.backtrace
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

  # Gets all final diagnoses for current version
  def final_diagnoses
    FinalDiagnosis.includes(diagnosis: [:node]).joins(diagnosis: [:node]).where(diagnosis_id: diagnoses.map(&:id))
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
    self.full_order_json = generate_nodes_order_tree unless full_order_json.present?
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
            dbNode = Node.find(node['id'])
            node['title'] = dbNode.reference_label(l)
            node['is_neonat'] = dbNode.is_neonat
          end
        else
          if %w(first_name last_name birth_date).include?(child['id'])
            I18n.default_locale = l
            child['title'] = I18n.t("questions.basic_questions.#{child['id']}")
            I18n.default_locale = :en
          else
            dbNode = Node.find(child['id'])
            child['title'] = dbNode.reference_label(l)
            child['is_neonat'] = dbNode.is_neonat
          end
        end
      end
    end
    order.to_json
  end


  # @return [Json]
  # Return questions in json format
  def questions_json
    (components.includes([conditions: {answer: :node}, nodes: [:answers, :medias, :complaint_categories]]).questions + components.questions_sequences.includes([conditions: {answer: :node}, nodes: [:answers, :medias, :complaint_categories]])).as_json(
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
            :type,
            :dependencies_by_version
          ]
        }
      ])
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

  # @return [Json]
  # Return current version in json format
  def version_json
    {
      id: id,
      type: 'Version',
      label: name,
    }
  end
end
