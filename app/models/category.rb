# List every categories of questions
class Category < ApplicationRecord

  has_many :nodes

  validates_presence_of :name
  validates_presence_of :reference_prefix

end
