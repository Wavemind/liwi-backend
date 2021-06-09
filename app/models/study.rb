class Study < ApplicationRecord
  has_many :algorithms
  has_many :health_facility
  has_many :user_studies


  validates_presence_of :label

  translates :description
end
