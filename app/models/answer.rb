# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference
  validates_uniqueness_of :reference

  before_create :complete_reference

  def complete_reference
    self.reference = "#{question.reference}_#{reference}"
  end
end
