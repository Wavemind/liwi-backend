# Define the children of an answer
class PredefinedSyndrome < Node
  before_destroy :diagnostic_dependencies
  after_create :create_answers

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: "Instance", as: :instanceable, dependent: :destroy

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if self.algorithm.predefined_syndromes.where(reference: "#{I18n.t('predefined_syndromes.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('predefined_syndromes.reference')}_#{reference}"
  end

  # Delete current predefined syndrome used in diagnostics
  def diagnostic_dependencies
    Instance.where(instanceable_type: 'Diagnostic', node_id: id).destroy_all
  end

  # Automatically create the answers, since they can't be changed
  def create_answers
    self.answers.create!(reference: '1', label: 'yes')
    self.answers.create!(reference: '2', label: 'no')
  end
end
