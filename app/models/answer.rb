# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference
  validates_uniqueness_of :reference

end
