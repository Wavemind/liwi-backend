# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :create_positive, if: Proc.new { answer_type.value == 'Positive' }
  after_create :create_present, if: Proc.new { answer_type.value == 'Present' }

  attr_accessor :unavailable

  enum stage: [:registration, :triage, :test, :consultation, :diagnosis_management]
  enum system: [:general, :respiratory_circulation, :ear_nose_mouth_throat, :visual, :integumentary, :digestive, :urinary_reproductive, :nervous, :muscular_skeletal]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :answer_type

  belongs_to :reference_table_x, class_name: 'Question', optional: true
  belongs_to :reference_table_y, class_name: 'Question', optional: true
  has_many :node_complaint_categories, foreign_key: 'node_id' # Complaint category linked to the question
  has_many :complaint_categories, through: :node_complaint_categories

  before_validation :validate_formula, if: Proc.new { self.formula.present? }
  before_validation :validate_ranges, if: Proc.new { [3, 4].include?(self.answer_type_id) }
  validates_presence_of :stage, unless: Proc.new { self.is_a? Questions::BackgroundCalculation }
  validates_presence_of :formula, if: Proc.new { self.answer_type.display == 'Formula' }
  validates_presence_of :type

  # Return questions which has not triage stage
  scope :no_triage, ->() { where.not(stage: Question.stages[:triage]).or(where(stage: nil)) }
  scope :no_treatment_condition, ->() { where.not(type: 'Questions::TreatmentQuestion') }
  scope :diagrams_included, ->() { where.not(type: %w(Questions::VitalSignAnthropometric Questions::BasicMeasurement Questions::BasicDemographic Questions::ConsultationRelated)) }

  accepts_nested_attributes_for :answers, allow_destroy: true

  # Preload the children of class Question
  def self.descendants
    [
      Questions::AssessmentTest,
      Questions::BackgroundCalculation,
      Questions::BasicMeasurement,
      Questions::ChronicCondition,
      Questions::ConsultationRelated,
      Questions::ComplaintCategory,
      Questions::BasicDemographic,
      Questions::Demographic,
      Questions::Exposure,
      Questions::ObservedPhysicalSign,
      Questions::PhysicalExam,
      Questions::Symptom,
      Questions::TreatmentQuestion,
      Questions::UniqueTriagePhysicalSign,
      Questions::UniqueTriageQuestion,
      Questions::Vaccine,
      Questions::VitalSignAnthropometric,
    ]
  end

  # Get the reference prefix according to the type
  def reference_prefix
    return '' if type.blank?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Get the reference prefix according to the type
  def self.reference_prefix_class(type)
    return '' if type.blank?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Return a hash with all question categories with their name, label and prefix
  def self.categories(diagram_class_name)
    categories = []
    excluded_categories = diagram_class_name == 'Question' ? [] : [Questions::ComplaintCategory, Questions::BasicMeasurement, Questions::VitalSignAnthropometric, Questions::UniqueTriageQuestion, Questions::UniqueTriagePhysicalSign]
    excluded_categories.push(Questions::TreatmentQuestion) unless %w(FinalDiagnostic Question).include?(diagram_class_name)
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

  # TODO: COMMENTAIRE
  def self.list_attributes(diagram_type, algorithm)
    {
      categories: categories(diagram_type),
      answer_types: AnswerType.all.as_json(methods: :display_name),
      systems: Question.systems.map { |k, v| [I18n.t("questions.systems.#{k}"), k] },
      stages: Question.stages,
      complaint_categories: algorithm.questions.where(type: 'Questions::ComplaintCategory')
    }
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (positive & negative) for positive questions
  def create_positive
    self.answers << Answer.new(reference: '1', label_en: I18n.t('answers.predefined.positive'))
    self.answers << Answer.new(reference: '2', label_en: I18n.t('answers.predefined.negative'))
    self.save
  end

  # Automatically create the answers, since they can't be changed
  # Create 2 automatic answers (present & absent) for present questions
  def create_present
    self.answers << Answer.new(reference: '1', label_en: I18n.t('answers.predefined.present'))
    self.answers << Answer.new(reference: '2', label_en: I18n.t('answers.predefined.absent'))
    self.save
  end

  # Ensure that the answers are coherent with each other, that every value the mobile user may enter match one and only one answers entered by the medal-C user
  def validate_overlap
    return true unless %w(Float Integer).include?(answer_type.value)

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

  # TODO: COMMENTAIRE
  def self.get_type_from_prefix(prefix)
    Question.descendants.each do |category|
      Question.reference_prefix_class(category.name)
      return category.name if Question.reference_prefix_class(category.name) == prefix
    end
  end

  # TODO: COMMENTAIRE
  def instance_dependencies?
    dependencies.map(&:instanceable).present?
  end

  # Check if question is used in a deployed version
  def used_in_deployed_version
    involved_versions_ids = []
    instances.map do |instance|
      if instance.instanceable.is_a? Version
        involved_versions_ids.push(instance.instanceable_id) unless involved_versions_ids.include?(instance.instanceable_id)
      elsif instance.instanceable.is_a? Diagnostic
        involved_versions_ids.push(instance.instanceable.version_id) unless involved_versions_ids.include?(instance.instanceable.version_id)
      else
        involved_versions_ids = questions_sequence_instanceables(instance.instanceable, involved_versions_ids)
      end
    end

    GroupAccess.where(end_date: nil, version_id: involved_versions_ids).any?
  end

  # Recursively check any questions sequence to get every involved instances
  def questions_sequence_instanceables(qs, versions = [])
    qs.instances.where.not(instanceable: qs).map do |instance|
      if instance.instanceable.is_a? Diagnostic
        versions.push(instance.instanceable.version_id) unless versions.include?(instance.instanceable.version_id)
      else
        questions_sequence_instanceables(instance.instanceable, versions)
      end
    end
    versions
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

  # Ensure that the formula is in a correct format
  def validate_formula
    errors.add(:formula, I18n.t('questions.errors.formula_wrong_characters')) if formula.match(/^(\[(.*?)\]|[ \(\)\*\/\+\-|0-9])*$/).nil?
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

  private

  # Display the label for the current child
  def self.display_label
    I18n.t("questions.categories.#{self.variable}.label")
  end
end
