# How a disease is diagnosed -> Differential diagnostics
# Contains the actual logic from its relations
class Diagnostic < ApplicationRecord
  before_create :complete_reference
  after_validation :unique_reference

  belongs_to :version
  has_many :final_diagnostics, dependent: :destroy
  has_many :conditions, as: :referenceable, dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  validates_presence_of :reference
  validates_presence_of :label

  translates :label

  # Enable recursive duplicating
  # https://github.com/amoeba-rb/amoeba#usage
  amoeba do
    enable
    include_association :components
    include_association :final_diagnostics
    include_association :conditions
    append reference: I18n.t('duplicated')
  end

  # @return [String]
  # Return the label with the reference for the view
  def reference_label
    "#{reference} - #{label}"
  end

  # @return [ActiveRecord::Relation] of questions
  # Get every questions asked in a diagnostic
  def questions
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Question', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of predefined syndromes
  # Get every predefined syndromes used in a diagnostic
  def predefined_syndromes
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'PredefinedSyndrome', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of managements
  # Get every managements used in a diagnostic
  def managements
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Management', id, self.class.name)
  end

  # @return [ActiveRecord::Relation] of treatments
  # Get every treatments used in a diagnostic
  def treatments
    Node.joins(:instances).where('type = ? AND instances.instanceable_id = ? AND instances.instanceable_type = ?', 'Treatment', id, self.class.name)
  end

  def management_instances
    components.joins(:node).where('nodes.type = ?', 'Management')
  end

  def treatment_instances
    components.joins(:node).where('nodes.type = ?', 'Treatment')
  end

  # @params [Diagnostic]
  # After a duplicate, link DF instances to the duplicated ones instead of the source ones
  def relink_instance
    components.final_diagnostics.each do |df_instance|
      df_instance.node = Node.find_by(reference: "#{df_instance.node.reference}#{I18n.t('duplicated')}")
      df_instance.save
    end
  end

  # @params [Diagnostic]
  # Generate the ordered questions
  def generate_questions_order
    nodes = []
    first_nodes = components.includes(:node, :conditions, :children).where(conditions: { referenceable_id: nil }).where.not(children: { node_id: nil }).where('nodes.type = ? OR nodes.type = ?', 'Question', 'PredefinedSyndrome')
    nodes << first_nodes
    get_children(first_nodes, nodes)
  end

  # @params [Array][Instance], [Array][Node]
  # Get children question nodes
  def get_children(instances, nodes)
    current_nodes = []
    instances.includes(children: [:node]).map(&:children).flatten.each do |child|
      current_nodes << child.node if child.node.is_a?(Question) || child.node.is_a?(PredefinedSyndrome)
    end

    if current_nodes.any?
      current_instances = Instance.where('instanceable_id = ? AND instanceable_type = ? AND node_id IN (?)', id, self.class.name, current_nodes.map(&:id).flatten)
      nodes << current_instances
      get_children(current_instances, nodes)
    else
      nodes
    end
  end

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if Diagnostic.joins(version: :algorithm)
         .where('reference = ? AND algorithms.id = ?', "#{I18n.t('diagnostics.reference')}#{reference}", version.algorithm.id).any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('diagnostics.reference')}#{reference}" unless self.reference.include?(I18n.t('duplicated'))
  end
end
