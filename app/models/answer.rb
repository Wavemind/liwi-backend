# Every answers to every questions
class Answer < ApplicationRecord

  enum operator: [:less, :between, :more_or_equal]

  belongs_to :node
  has_many :children
  has_many :medical_case_answers

  validates_presence_of :label_en
  validates_presence_of :operator, if: Proc.new { self.node.is_a?(Question) && self.node.answer_type.display == 'Input' && !%w(Questions::BasicMeasurement Questions::VitalSignAnthropometric).include?(self.node.type) && value != 'not_available'}

  after_validation :correct_value_type
  after_create :generate_reference, if: Proc.new { !self.node.is_a?(QuestionsSequence) && ![1,7,8].include?(self.node.answer_type_id) }
  before_destroy :remove_conditions

  translates :label

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  # @return [String]
  # Return the reference of the answer. This function is needed to do a recursive functional call
  # with conditions or answers, answer being the last level
  def display_condition
    "#{full_reference}"
  end

  # Return reference with its prefix
  def full_reference
    "#{node.full_reference}_#{reference}"
  end

  # Return the parent node with all the answers in order to include it in a json if the condition is an answer and not a condition
  def get_node
    node.as_json(include: [:answers], methods: [:type])
  end

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{full_reference} - #{label}"
  end

  private

  # Get translatable attributes to translate with excel import
  def self.get_translatable_params(data)
    fields_to_update = {}

    data.row(1).each_with_index do |head, index|
      if head.include?('Label')
        code = head[/\((.*?)\)/m, 1]
        fields_to_update["label_#{code}"] = index unless code == 'en'
      end
    end

    fields_to_update
  end

  # Ensure that the entered values are in the correct type
  def correct_value_type
    if node.is_a?(Question) && %w(Input Formula).include?(node.answer_type.display)
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

  def generate_reference
    if node.answers.count > 1
      self.reference = node.answers.maximum(:reference) + 1
    else
      self.reference = 1
    end
    self.save
  end

  # Remove conditions linked to the answer when it is deleted
  def remove_conditions
    Condition.where(answer: self).destroy_all
  end

  # @param [String] val
  # Force value into Integer or Float and raise a validation error otherwise
  def validate_value_type(val)
    return nil if val == 'not_available'
    if node.answer_type.value == 'Integer'
      Integer(val) rescue errors.add(:value, I18n.t('answers.validation.wrong_value_type', type: node.answer_type.value))
    elsif node.answer_type.value == 'Float'
      Float(val) rescue errors.add(:value, I18n.t('answers.validation.wrong_value_type', type: node.answer_type.value))
    end
  end
end
