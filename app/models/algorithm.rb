# Container of many versions of algorithms
class Algorithm < ApplicationRecord

  has_many :versions
  has_many :nodes, dependent: :destroy
  has_many :questions, -> { where type: Question.descendants.map(&:name) }, source: :node
  has_many :health_cares, -> { where type: HealthCare.descendants.map(&:name) }, source: :node
  has_many :questions_sequences, -> { where type: QuestionsSequence.descendants.map(&:name) }, source: :node
  has_many :treatments, -> { where type: 'HealthCares::Treatment'}, source: :health_care

  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name

end
