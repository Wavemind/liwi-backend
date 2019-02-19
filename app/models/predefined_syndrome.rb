# Define the children of an answer
class PredefinedSyndrome < Node
  after_create :create_answers

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  has_many :components, class_name: "Instance", as: :instanceable, dependent: :destroy

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.predefined_syndromes.where(reference: "#{I18n.t('predefined_syndromes.reference')}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    self.reference = "#{I18n.t('predefined_syndromes.reference')}_#{reference}"
  end

  # Automatically create the answers, since they can't be changed
  def create_answers
    answers.create!(reference: '1', label: I18n.t('answers.yes'))
    answers.create!(reference: '2', label: I18n.t('answers.no'))
  end
end
