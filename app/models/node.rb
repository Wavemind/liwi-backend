# Every component of an algorithm
class Node < ApplicationRecord

  has_many :available_nodes
  has_many :algorithms, through: :available_nodes
  has_many :children
  has_many :relations

  validates_presence_of :label
  validates_presence_of :reference

  after_validation :unique_reference
  before_create :complete_reference

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} | #{label}"
  end

  private

  # @params nil
  # @return nil
  # Validate the uniqueness after validation if it is present in order to simulate #complete_reference
  def unique_reference

  end

  # @params nil
  # @return nil
  # Complete the reference with the associated prefix before the entry is created
  def complete_reference

  end
end
