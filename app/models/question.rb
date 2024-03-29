# Child of Node / Questions asked to the patient
class Question < Node

  before_create :associate_step
  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :create_positive, if: Proc.new { answer_type.value == 'Positive' }
  after_create :create_present, if: Proc.new { answer_type.value == 'Present' }

  enum round: [:tenth, :half, :unit]
  enum step: [:registration_step, :first_look_assessment_step, :complaint_categories_step, :basic_measurements_step, :medical_history_step, :physical_exam_step, :test_step, :health_care_questions_step, :referral_step]
  enum stage: [:registration, :triage, :test, :consultation, :diagnosis_management]
  enum system: [
    :general,
    :respiratory_circulation,
    :ear_nose_mouth_throat,
    :visual,
    :integumentary,
    :digestive,
    :urinary_reproductive,
    :nervous,
    :muscular_skeletal,
    :exposures,
    :chronic_conditions,
    :comorbidities,
    :prevention,
    :follow_up_questions,
    :complementary_medical_history,
    :vital_sign,
    :priority_sign,
    :feeding,
    :fever,
    :dehydration,
    :malnutrition_anemia
  ]
  enum emergency_status: [:standard, :referral, :emergency, :emergency_if_no]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :answer_type

  belongs_to :reference_table_x, class_name: 'Question', optional: true
  belongs_to :reference_table_y, class_name: 'Question', optional: true
  belongs_to :reference_table_z, class_name: 'Question', optional: true
  has_many :node_complaint_categories, foreign_key: 'node_id' # Complaint category linked to the question
  has_many :complaint_categories, through: :node_complaint_categories

  before_validation :validate_formula, if: Proc.new { self.formula.present? }
  before_validation :validate_ranges, if: Proc.new { [3, 4].include?(self.answer_type_id) }
  after_create :add_to_version_orders
  after_destroy :remove_from_version_orders
  before_update :set_system_order
  validates_presence_of :stage, unless: Proc.new { self.is_a? Questions::BackgroundCalculation }
  validates_presence_of :formula, if: Proc.new { self.answer_type.display == 'Formula' }
  validates_presence_of :type

  scope :no_treatment_condition, ->() { where.not(type: 'Questions::TreatmentQuestion') }
  scope :diagrams_included, ->() { where.not(type: %w(Questions::VitalSignAnthropometric Questions::BasicMeasurement Questions::BasicDemographic Questions::ConsultationRelated Questions::Referral)) }

  accepts_nested_attributes_for :answers, allow_destroy: true

  # Return a hash with all question categories with their name, label and prefix
  def self.categories(diagram_class_name)
    categories = []
    excluded_categories = %w(Question Version).include?(diagram_class_name) ? [] : [Questions::ComplaintCategory, Questions::BasicMeasurement, Questions::VitalSignAnthropometric, Questions::Referral, Questions::UniqueTriageQuestion, Questions::UniqueTriagePhysicalSign]
    excluded_categories.push(Questions::TreatmentQuestion) unless %w(FinalDiagnosis Question Version).include?(diagram_class_name)
    self.descendants.each do |category|
      unless excluded_categories.include?(category)
        current_category = {}
        current_category['label'] = category.display_label
        current_category['name'] = category.name
        current_category['reference_prefix'] = self.reference_prefix_class(category.name)
        categories.push(current_category)
      end
    end
    categories
  end

  # Preload the children of class Question
  def self.descendants
    [
      Questions::AnswerableBasicMeasurement,
      Questions::AssessmentTest,
      Questions::BackgroundCalculation,
      Questions::BasicMeasurement,
      Questions::ChronicCondition,
      Questions::ComplaintCategory,
      Questions::BasicDemographic,
      Questions::Demographic,
      Questions::Exposure,
      Questions::ObservedPhysicalSign,
      Questions::PhysicalExam,
      Questions::Referral,
      Questions::Symptom,
      Questions::TreatmentQuestion,
      Questions::UniqueTriageQuestion,
      Questions::Vaccine,
      Questions::VitalSignAnthropometric,
    ]
  end

  # Return question category from its reference prefix
  def self.get_type_from_prefix(prefix)
    Question.descendants.each do |category|
      Question.reference_prefix_class(category.name)
      return category.name if Question.reference_prefix_class(category.name) == prefix
    end
  end

  # Send dropdown list values for react forms
  def self.list_attributes(diagram_type, algorithm)
    {
      categories: categories(diagram_type),
      answer_types: AnswerType.all.as_json(methods: :display_name),
      systems: Question.systems.map { |k, v| [I18n.t("questions.systems.#{k}"), k] },
      stages: Question.stages,
      rounds: Question.rounds,
      emergency_statuses: Question.emergency_statuses,
      complaint_categories: algorithm.questions.where(type: 'Questions::ComplaintCategory')
    }
  end

  # Get the reference prefix according to the type
  def self.reference_prefix_class(type)
    return '' if type.blank?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Add the new node to the versions orders so they can reorder it correctly
  def add_to_version_orders
    return nil if step.nil?

    algorithm.versions.each do |version|
      order = JSON.parse(version.full_order_json)
      if %w(medical_history_step physical_exam_step).include?(step)
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'].select{|i| i['title'] == I18n.t("questions.systems.#{system}")}[0]['children'].push(generate_node_tree_hash)
      elsif step == 'complaint_categories_step'
        index = is_neonat ? 1 : 0 # Older children list is first
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'][index]['children'].push(generate_node_tree_hash)
      else
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'].push(generate_node_tree_hash)
      end
      version.update!(full_order_json: order.to_json)
    end
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (positive & negative) for positive questions
  def create_positive
    self.answers << Answer.new(reference: 1, label_translations: Hash[Language.all.map(&:code).unshift('en').collect { |k| [k, I18n.t('answers.predefined.positive', locale: k)] } ])
    self.answers << Answer.new(reference: 2, label_translations: Hash[Language.all.map(&:code).unshift('en').collect { |k| [k, I18n.t('answers.predefined.negative', locale: k)] } ])
    self.save
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (present & absent) for present questions
  def create_present
    self.answers << Answer.new(reference: 1, label_translations: Hash[Language.all.map(&:code).unshift('en').collect { |k| [k, I18n.t('answers.predefined.present', locale: k)] } ])
    self.answers << Answer.new(reference: 2, label_translations: Hash[Language.all.map(&:code).unshift('en').collect { |k| [k, I18n.t('answers.predefined.absent', locale: k)] } ])
    self.save
  end

  # Display question with ID
  def display_label_id
    "#{label_en} (#{id})"
  end

  def process(a_i, v_i)
    order = get_order(a_i, v_i);
    order[3]['children'].push(get_bmi(a_i).generate_node_tree_hash);
    update_order(a_i, v_i, order);
  end

  # Generate node hash for tree order
  def generate_node_tree_hash
    question_hash = {}
    question_hash['id'] = id
    question_hash['title'] = reference_label
    question_hash['is_neonat'] = is_neonat
    question_hash
  end

  # Get the reference prefix according to the type
  def reference_prefix
    return '' if type.blank?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Remove the destroyed node in the versions orders so they don't consider it anymore
  def remove_from_version_orders
    return nil if step.nil?

    algorithm.versions.each do |version|
      order = JSON.parse(version.full_order_json)
      if %w(medical_history_step physical_exam_step).include?(step)
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'].select{|i| i['title'] == I18n.t("questions.systems.#{system}")}[0]['children'].delete_if{|i| i['id'] == id}
      elsif step == 'complaint_categories_step'
        index = is_neonat ? 1 : 0 # Older children list is first
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'][index]['children'].delete_if{|i| i['id'] == id}
      else
        order.select{|i| i['title'] == I18n.t("questions.steps.#{step}")}[0]['children'].delete_if{|i| i['id'] == id}
      end
      version.update!(full_order_json: order.to_json)
    end
  end

  # Ensure that the formula is in a correct format
  def validate_formula
    # Check if the functions ToDay or ToMonth are being used. If so, formula is correct.
    if %w(ToDay ToMonth).include?(formula)
      errors.add(:formula, I18n.t('questions.errors.formula_using_function', formula: formula)) unless is_default
      return true
    end

    errors.add(:formula, I18n.t('questions.errors.formula_wrong_characters')) if formula.match(/^(\[(.*?)\]|[ \(\)\*\/\+\-\.|0-9])*$/).nil?

    # Extract references and functions from the formula
    formula.scan(/\[.*?\]/).each do |reference|
      # Check for date functions ToDay() or ToMonth() and remove element if it's correct
      is_date = false
      if reference.include?('ToDay')
        is_date = true
        reference = reference.sub!('ToDay', '').tr('()', '')
      elsif reference.include?('ToMonth')
        is_date = true
        reference = reference.sub!('ToMonth', '').tr('()', '')
      end

      # Extract type and reference from full reference
      full_reference = reference.gsub(/[\[\]]/, '')
      type, reference = full_reference.match(/([A-Z]*)([0-9]*)/i).captures
      type = Question.get_type_from_prefix(type)

      if type.present?
        question = algorithm.questions.find_by(type: type.to_s, reference: reference.to_i)
        if question.present?
          if is_date
            errors.add(:formula, I18n.t('questions.errors.formula_reference_not_date', reference: full_reference)) unless question.answer_type.value == 'Date'
          else
            errors.add(:formula, I18n.t('questions.errors.formula_reference_not_numeric', reference: full_reference)) unless %w(Integer Float).include?(question.answer_type.value)
          end
        else
          errors.add(:formula, I18n.t('questions.errors.formula_wrong_reference', reference: full_reference))
        end
      else
        errors.add(:formula, I18n.t('questions.errors.formula_wrong_type', reference: full_reference))
      end
    end
  end

  # Ensure that the answers are coherent with each other, that every value the mobile user may enter match one and only one answers entered by the medAL-creator user
  def validate_overlap
    return true if !(%w(Float Integer).include?(answer_type.value)) || %w(Questions::BasicMeasurement Questions::BasicDemographic Questions::VitalSignAnthropometric).include?(type)

    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_more_or_equal')) if answers.filter(&:more_or_equal?).count != 1
    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_less')) if answers.filter(&:less?).count != 1

    if answers.filter(&:less?).any? && answers.filter(&:more_or_equal?).any?

      betweens = []
      answers.filter(&:between?).each do |answer|
        betweens.push(answer.value.split(',').map(&:to_f))
      end

      if betweens.any?
        self.errors.add(:answers, I18n.t('answers.validation.overlap.less_greater_than_more_or_equal')) if answers.filter(&:less?).first.value.to_f > answers.filter(&:more_or_equal?).first.value.to_f

        betweens = betweens.sort_by { |a| a[0] }
        self.errors.add(:answers, I18n.t('answers.validation.overlap.first_between_different_from_less')) if answers.filter(&:less?).first.value.to_f != betweens[0][0]
        self.errors.add(:answers, I18n.t('answers.validation.overlap.last_between_different_from_more_or_equal')) if answers.filter(&:more_or_equal?).first.value.to_f != betweens.last[1]

        betweens.each_with_index do |between, i|
          unless i == 0
            self.errors.add(:answers, I18n.t('answers.validation.overlap.between_not_following')) if between[0] != betweens[i - 1][1]
          end
        end
      else
        self.errors.add(:answers, I18n.t('answers.validation.overlap.less_equal_more_or_equal')) if answers.filter(&:less?).first.value.to_f != answers.filter(&:more_or_equal?).first.value.to_f
      end
    end

    errors.messages.blank?
  end

  # Validate correct order of validation ranges
  def validate_ranges
    values = []
    # Create array adding every value in the order it should be
    values.push(min_value_error) if min_value_error.present?
    values.push(min_value_warning) if min_value_warning.present?
    values.push(max_value_warning) if max_value_warning.present?
    values.push(max_value_error) if max_value_error.present?
    errors.add(:min_value_error, I18n.t('questions.errors.validation_range_incorrect')) if values != values.sort
  end

  private

  # Display the label for the current child
  def self.display_label
    I18n.t("questions.categories.#{self.variable}.label")
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step

  end

  # Get translatable attributes to translate with excel import
  def self.get_translatable_params(data)
    fields_to_update = {}

    data.row(1).each_with_index do |head, index|
      code = head[/\((.*?)\)/m, 1]
      if head.include?('Label')
        fields_to_update["label_#{code}"] = index
      elsif head.include?('Description')
        fields_to_update["description_#{code}"] = index
      elsif head.include?('Min message warning')
        fields_to_update["min_message_warning_#{code}"] = index
      elsif head.include?('Max message warning')
        fields_to_update["max_message_warning_#{code}"] = index
      elsif head.include?('Min message error')
        fields_to_update["min_message_error_#{code}"] = index
      elsif head.include?('Max message error')
        fields_to_update["max_message_error_#{code}"] = index
      elsif head.include?('Placeholder')
        fields_to_update["placeholder_#{code}"] = index
      end
    end

    fields_to_update
  end

  # Update json order if the system is changed
  def set_system_order
    system_change = changes['system']
    if system_change.present?
      old_system = system_change[0]
      new_system = system_change[1]
      algorithm.versions.map do |version|
        json = JSON.parse(version.full_order_json)
        json_index = Question.steps[step]
        old_place = json[json_index]['children'].select{|system| system['subtitle_name'] == old_system}[0]['children']
        node_hash = old_place.select{|node| node['id'] == id}[0]
        old_place.delete(node_hash)
        json[json_index]['children'].select{|system| system['subtitle_name'] == new_system}[0]['children'].push(node_hash)
        version.update!(full_order_json: json.to_json)
      end
    end
  end
end
