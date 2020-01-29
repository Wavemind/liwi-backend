# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :create_positive, if: Proc.new { answer_type.value == 'Positive' }
  after_create :create_present, if: Proc.new { answer_type.value == 'Present' }
  after_create :push_in_versions, if: Proc.new { stage == 'triage' }
  before_destroy :remove_from_versions, if: Proc.new { stage == 'triage' }

  attr_accessor :unavailable

  enum stage: [:registration, :triage, :test, :consultation, :diagnosis_management]
  enum system: [:general, :respiratory_circulation, :ear_nose_mouth_throat, :visual, :integumentary, :digestive, :urinary_reproductive, :nervous, :muscular_skeletal]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :answer_type

  belongs_to :reference_table_x, class_name: 'Question', optional: true
  belongs_to :reference_table_y, class_name: 'Question', optional: true

  before_validation :validate_formula, if: Proc.new { self.formula.present? }
  validates_presence_of :stage

  # Return questions which has not triage stage
  scope :no_triage, ->() { where.not(stage: Question.stages[:triage]) }
  scope :no_treatment_condition, ->() { where.not(type: 'Questions::TreatmentQuestion') }
  scope :no_vital_sign, ->() { where.not(type: %w(Questions::VitalSignConsultation Questions::VitalSignTriage)) }

  accepts_nested_attributes_for :answers, allow_destroy: true

  # Preload the children of class Question
  def self.descendants
    [
        Questions::AssessmentTest,
        Questions::BackgroundCalculation,
        Questions::ChronicCondition,
        Questions::ComplaintCategory,
        Questions::Demographic,
        Questions::EmergencySign,
        Questions::Exposure,
        Questions::ObservedPhysicalSign,
        Questions::PhysicalExam,
        Questions::Symptom,
        Questions::TreatmentQuestion,
        Questions::Vaccine,
        Questions::VitalSignConsultation,
        Questions::VitalSignTriage,
    ]
  end

  # Get the reference prefix according to the type
  def reference_prefix
    return '' unless type.present?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Get the reference prefix according to the type
  def self.reference_prefix_class(type)
    return '' unless type.present?
    I18n.t("questions.categories.#{Object.const_get(type).variable}.reference_prefix")
  end

  # Return a hash with all question categories with their name, label and prefix
  def self.categories(diagram_class_name)
    categories = []
    excluded_categories = [Questions::ComplaintCategory, Questions::VitalSignTriage, Questions::VitalSignConsultation, Questions::EmergencySign]
    excluded_categories.push(Questions::TreatmentQuestion) unless diagram_class_name == 'FinalDiagnostic'
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

  # When a question from triage stage is created, push it at the end of the versions order
  def push_in_versions
    algorithm.versions.each do |version|
      version.components.create!(node: self)
      version.update("#{version_field_to_set}": version.send("#{version_field_to_set}").push(id))
    end
  end

  # Remove the triage question from the version triage orders
  def remove_from_versions
    field_to_set = version_field_to_set
    algorithm.versions.each do |version|
      version["#{field_to_set}"].delete(id) if version.send("#{field_to_set}").include?(id)
      version.save
    end
  end

  # Get the right field from the node type<
  def version_field_to_set
    case type
    when 'Questions::EmergencySign'
      return 'triage_emergency_sign_order'
    when 'Questions::ComplaintCategory'
      return 'triage_complaint_category_order'
    when 'Questions::VitalSignTriage'
      return 'triage_vital_sign_triage_order'
    when 'Questions::ChronicCondition'
      return 'triage_chronic_condition_order'
    else
      return 'triage_questions_order'
    end
  end

  # Ensure that the answers are coherent with each other, that every value the mobile user may enter match one and only one answers entered by the medal-C user
  def validate_overlap
    return true unless %w(Input Formula).include?(answer_type.display)

    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_more_or_equal')) if answers.more_or_equal.count != 1
    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_less')) if answers.less.count != 1

    if answers.less.any? && answers.more_or_equal.any?

      betweens = []
      answers.between.each do |answer|
        betweens.push(answer.value.split(',').map(&:to_f))
      end

      if betweens.any?
        self.errors.add(:answers, I18n.t('answers.validation.overlap.less_greater_than_more_or_equal')) if answers.less.first.value.to_f > answers.more_or_equal.first.value.to_f

        betweens = betweens.sort_by { |a| a[0] }
        self.errors.add(:answers, I18n.t('answers.validation.overlap.first_between_different_from_less')) if answers.less.first.value.to_f != betweens[0][0]
        self.errors.add(:answers, I18n.t('answers.validation.overlap.last_between_different_from_more_or_equal')) if answers.more_or_equal.first.value.to_f != betweens.last[1]

        betweens.each_with_index do |between, i|
          unless i == 0
            self.errors.add(:answers, I18n.t('answers.validation.overlap.between_not_following')) if between[0] != betweens[i - 1][1]
          end
        end
      else
        self.errors.add(:answers, I18n.t('answers.validation.overlap.less_equal_more_or_equal')) if answers.less.first.value.to_f != answers.more_or_equal.first.value.to_f
      end
    end

    errors.messages.blank?
  end

  def self.get_type_from_prefix(prefix)
    Question.descendants.each do |category|
      Question.reference_prefix_class(category.name)
      return category.name if Question.reference_prefix_class(category.name) == prefix
    end
  end

  def instance_dependencies?
    dependencies.map(&:instanceable).present?
  end

  private

  # Display the label for the current child
  def self.display_label
    I18n.t("questions.categories.#{self.variable}.label")
  end

  # Ensure that the formula is in a correct format
  def validate_formula
    errors.add(:formula, I18n.t('questions.errors.formula_wrong _characters')) if formula.match(/^(\[(.*?)\]|[ \(\)\*\/\+\-|0-9])*$/).nil?
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
end
