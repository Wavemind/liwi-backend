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

  before_destroy :remove_children_from_parents

  # Delete children aswell using this instance
  def remove_children_from_parents
    instanceable.components.select { |i| i.children.select { |c| c.destroy if c.node == self.node } }
  end

end
