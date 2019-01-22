# Container of many versions of algorithms
class Algorithm < ApplicationRecord

  belongs_to :user

  has_many :algorithm_versions

  validates_presence_of :name
  validates_uniqueness_of :name

end
