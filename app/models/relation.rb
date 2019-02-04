# Define the relations between an answer and its nodes
class Relation < ApplicationRecord

  belongs_to :node
  belongs_to :relationable, polymorphic: true

  has_many :children
  has_many :conditions, as: :referenceable

end
