class Study < ApplicationRecord
  has_rich_text :description

  has_many :algorithms

  validates_presence_of :label
end
