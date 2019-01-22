# Every answers to every questions
class Answer < ApplicationRecord

  belongs_to :question

  validates_presence_of :reference
  validates_presence_of :label
  validates_presence_of :value

  validates_uniqueness_of :reference

end
