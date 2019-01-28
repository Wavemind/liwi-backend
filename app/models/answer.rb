# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference
  validates_uniqueness_of :reference

  before_save :complete_reference

  private

  def complete_reference
    self.reference = "#{question.reference}_#{reference}"
  end
end
