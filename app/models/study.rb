class Study < ApplicationRecord
  has_many :algorithms

  validates_presence_of :label
end
