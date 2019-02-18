# Define the instance of a node in a diagnostic
class Instance < ApplicationRecord

  belongs_to :node
  belongs_to :instanceable, polymorphic: true

  has_many :children, dependent: :destroy
  has_many :nodes, through: :children

  has_many :conditions, as: :referenceable, dependent: :destroy

  scope :management, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Management') }
  scope :questions, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Question') }
  scope :predefined_syndromes, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'PredefinedSyndrome') }
  scope :treatments, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'Treatment') }
  scope :final_diagnostics, ->() { joins(:node).includes(:conditions).where('nodes.type = ?', 'FinalDiagnostic') }

end
