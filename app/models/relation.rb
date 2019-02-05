# Define the relations between an answer and its nodes
class Relation < ApplicationRecord

  belongs_to :node
  belongs_to :relationable, polymorphic: true

  has_many :children
  has_many :conditions, as: :referenceable

  scope :management, ->() {joins(:node).includes([:conditions]).where('nodes.type': "Management")}
  scope :questions, ->() {joins(:node).includes([:conditions]).where('nodes.type': "Question")}
  scope :predefined_syndromes, ->() {joins(:node).includes([:conditions]).where('nodes.type': "PredefinedSyndrome")}
  scope :treatments, ->() {joins(:node).includes([:conditions]).where('nodes.type': "Treatment")}
  scope :final_diagnostics, ->() {joins(:node).includes([:conditions]).where('nodes.type': "FinalDiagnostic")}

end
