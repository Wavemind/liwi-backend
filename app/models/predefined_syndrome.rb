# Define the children of an answer
class PredefinedSyndrome < Node
  after_create :create_boolean

  belongs_to :category

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: 'Instance', as: :instanceable, dependent: :destroy

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.predefined_syndromes.where(reference: "#{category.reference_prefix}#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{category.reference_prefix}#{reference}"
  end
end
