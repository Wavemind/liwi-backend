# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean_answers, if: Proc.new { answer_type.value == 'Boolean' }

  enum priority: [:basic, :triage, :priority]

  has_many :answers, foreign_key: 'node_id'
  belongs_to :category
  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if algorithm.questions.where(reference: "#{category.reference_prefix}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    if category.present?
      self.reference = "#{category.reference_prefix}_#{reference}"
    end
  end

  # Automatically create the answers, since they can't be changed
  def create_boolean_answers
    Answer.create_boolean(id)
  end
end
