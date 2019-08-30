# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :push_in_versions, if: Proc.new { stage == 'triage' }
  before_destroy :remove_from_versions, if: Proc.new { stage == 'triage' }

  attr_accessor :unavailable

  enum priority: [:basic, :mandatory]
  enum stage: [:registration, :triage, :test, :consultation]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :answer_type

  before_validation :validate_formula, if: Proc.new { self.formula.present? }
  validates_presence_of :priority, :stage

  # Return questions which has not triage stage
  scope :no_triage, ->() { where.not(stage: Question.stages(:triage)) }
  # Return questions without basic triage categories but still get the triage stage for other categories
  scope :no_triage_but_other, ->() { where.not(type: %w(Questions::FirstLookAssessment Questions::ChiefComplaint Questions::VitalSign Questions::ChronicalCondition)) }

  accepts_nested_attributes_for :answers, allow_destroy: true

  # Preload the children of class Question
  def self.descendants
    [Questions::AssessmentTest, Questions::ChiefComplaint, Questions::ChronicalCondition, Questions::Demographic, Questions::Exposure, Questions::FirstLookAssessment, Questions::PhysicalExam, Questions::Symptom, Questions::Vaccine, Questions::VitalSign]
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
  def self.categories
    categories = []
    self.descendants.each do |category|
      unless [Questions::FirstLookAssessment, Questions::ChiefComplaint, Questions::ChronicalCondition, Questions::VitalSign].include?(category)
        current_category = {}
        current_category['label'] = category.display_label
        current_category['name'] = category.name
        current_category['reference_prefix'] = self.reference_prefix_class(category.name)
        categories.push(current_category)
      end
    end
    categories
  end

  # When a question from triage stage is created, push it at the end of the versions order
  def push_in_versions
    algorithm.versions.each do |version|
      version.components.create!(node: self)
      version.update(triage_questions_order: version.triage_questions_order.push(id))
    end
  end

  # Remove the triage question from the version triage orders
  def remove_from_versions
    algorithm.versions.each do |version|
      version.update(triage_questions_order: version.triage_questions_order.delete(id)) if version.triage_questions_order.include?(id)
    end
  end

  # After all answers have been created, ensure that they does not share the same reference
  def validate_answers_references
    valid = true
    answers.map do |answer|
      valid = false unless answer.unique_reference
    end
    valid
  end

  # Ensure that the answers are coherent with each other, that every value the mobile user may enter match one and only one answers entered by the medal-C user
  def validate_overlap
    return true if answer_type.display != 'Input'

    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_more_or_equal')) if answers.more_or_equal.count != 1
    self.errors.add(:answers, I18n.t('answers.validation.overlap.one_less')) if answers.less.count != 1

    if answers.less.any? && answers.more_or_equal.any?
      self.errors.add(:answers, I18n.t('answers.validation.overlap.less_greater_than_more_or_equal')) if answers.less.first.value.to_f > answers.more_or_equal.first.value.to_f

      betweens = []
      answers.between.each do |answer|
        betweens.push(answer.value.split(',').map(&:to_f))
      end
      betweens = betweens.sort_by {|a| a[0]}

      if betweens.any?
        self.errors.add(:answers, I18n.t('answers.validation.overlap.first_between_different_from_less')) if answers.less.first.value.to_f != betweens[0][0]
        self.errors.add(:answers, I18n.t('answers.validation.overlap.last_between_different_from_more_or_equal')) if answers.more_or_equal.first.value.to_f != betweens.last[1]

        betweens.each_with_index do |between, i|
          unless i == 0
            self.errors.add(:answers, I18n.t('answers.validation.overlap.between_not_following')) if between[0] != betweens[i - 1][1]
          end
        end
      end
    end

    errors.messages.blank?
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if type.blank?
      errors.add(:type, I18n.t('questions.errors.no_blank'))
    else
      question = algorithm.questions.where(reference: reference_prefix + reference).first
      errors.add(:reference, I18n.t('nodes.validation.reference_used')) if question.present? && question.id != id
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = reference_prefix + reference
  end

  # Display the label for the current child
  def self.display_label
    I18n.t("questions.categories.#{self.variable}.label")
  end

  # Ensure that the formula is in a correct format
  def validate_formula
    errors.add(:formula, I18n.t('questions.errors.formula_wrong_characters')) if formula.match(/^(\[(.*?)\]|[ \(\)\*\/\+\-|0-9])*$/).nil?
    formula.scan(/\[.*?\]/).each do |reference|
      reference = reference.tr('[]', '')
      question = algorithm.questions.find_by(reference: reference)
      if question.present?
        errors.add(:formula, I18n.t('questions.errors.formula_reference_not_numeric', reference: reference)) unless question.answer_type.display == 'Input'
      else
        errors.add(:formula, I18n.t('questions.errors.formula_wrong_reference', reference: reference))
      end
    end
  end
end
