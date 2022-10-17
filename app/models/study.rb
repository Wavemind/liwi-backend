class Study < ApplicationRecord
  has_many :algorithms
  has_many :health_facilities
  has_many :user_studies
  has_many :users, through: :user_studies

  validates_presence_of :label
  validates_uniqueness_of :label

  translates :description
end
