# Every component of an algorithm
class Node < ApplicationRecord

  has_many :available_nodes
  has_many :algorithms, through: :available_nodes

  validates_presence_of :label
  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference

  private

  def unique_reference

  end

  def complete_reference

  end
end
