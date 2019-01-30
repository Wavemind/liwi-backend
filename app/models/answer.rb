# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference
  validates_uniqueness_of :reference

  before_validation :complete_reference

  def complete_reference
    self.reference = "#{question.reference}_#{reference}" if reference.present? && !reference.start_with?("#{question.reference}_")
  end
end
