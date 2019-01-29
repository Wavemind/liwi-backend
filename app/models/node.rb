# Every component of an algorithm
class Node < ApplicationRecord

  has_many :available_nodes
  has_many :algorithms, through: :available_nodes

  validates_presence_of :label
  validates_presence_of :reference

  validates_uniqueness_of :reference
end
