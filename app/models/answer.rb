# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference

  private

  def unique_reference
    if Answer.where(reference: "#{question.reference}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  def complete_reference
    self.reference = "#{question.reference}_#{reference}" unless reference.start_with?("#{question.reference}_")
  end
end
