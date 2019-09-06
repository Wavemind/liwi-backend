# Every answers to every questions
class Answer < ApplicationRecord

  enum operator: [:less, :between, :more_or_equal]

  belongs_to :node
  has_many :children
  has_many :medical_case_answers

  validates_presence_of :reference
  validates_presence_of :label_en
  validates_presence_of :operator, if: Proc.new { self.node.is_a?(Question) && self.node.answer_type.display == 'Input' }

  validates :reference, exclusion: { in: %w(0), message: I18n.t('flash_message.reserved_reference') }
  after_validation :correct_value_type
  after_validation :unique_reference, on: [ :create ]
  before_destroy :remove_conditions

  translates :label

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  # @return [String]
  # Return the reference of the answer. This function is needed to do a recursive functional call
  # with conditions or answers, answer being the last level
  def display_condition
    "#{reference}"
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  # @param [Integer] node id to link to questions
  # Create 1 automatic answer for tests/assessments if attr_accessor :unavailable in question is checked
  def self.create_unavailable(node_id)
    answer = Answer.new(node_id: node_id, reference: '0', value: 'not_available', label_en: I18n.t('answers.unavailable'))
    answer.save(validate: false)
  end

  # Return the parent node with all the answers in order to include it in a json if the condition is an answer and not a condition
  def get_node
    node.as_json(include: [:answers], methods: [:type])
  end

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if node.answers.where(reference: reference).or(node.answers.where(reference: "#{node.reference}_#{reference}")).where.not(id: id).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
      return false
    end
    true
  end

  private

  # Remove conditions linked to the answer when it is deleted
  def remove_conditions
    Condition.where(first_conditionable: self).or(Condition.where(second_conditionable: self)).destroy_all
  end

  # Ensure that the entered values are in the correct type
  def correct_value_type
    if node.is_a?(Question) && node.answer_type.display == 'Input'
      if between?
        if value.include?(',')
          values = value.split(',').map(&:to_i)
          errors.add(:value, I18n.t('answers.validation.between_wrong_order')) if values[0] > values[1]
        else
          errors.add(:value, I18n.t('answers.validation.value_missing'))
        end

        value.split(',').each(&method(:validate_value_type))
      else
        validate_value_type(value)
      end
    end
  end

  # @param [String] val
  # Force value into Integer or Float and raise a validation error otherwise
  def validate_value_type(val)
    if node.answer_type.value == 'Integer'
      Integer(val) rescue errors.add(:value, I18n.t('answers.validation.wrong_value_type', type: node.answer_type.value))
    elsif node.answer_type.value == 'Float'
      Float(val) rescue errors.add(:value, I18n.t('answers.validation.wrong_value_type', type: node.answer_type.value))
    end
  end
end
