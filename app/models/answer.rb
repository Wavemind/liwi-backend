# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :node
  has_many :children

  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference


  # @return [String]
  # Return the reference of the answer. This function is needed to do a recursive functional call
  # with conditions or answers, answer being the last level
  def display_condition
    reference
  end

  # @return [String]
  # Return a formatted String with the id and type of polymorphic instance
  def conditionable_hash
    "#{self.id},#{self.class.name}"
  end

  private

  # {Node#unique_reference}
  def unique_reference
    if Answer.where(reference: "#{node.reference}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{node.reference}_#{reference}"
  end
end
