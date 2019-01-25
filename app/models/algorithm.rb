# Container of many versions of algorithms
class Algorithm < ApplicationRecord

  has_many :algorithm_versions
  has_many :available_questions
  has_many :questions, through: :available_questions

  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name

end
