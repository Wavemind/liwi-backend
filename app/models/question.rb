# Child of Node / Questions asked to the patient
class Question < Node

  after_create :create_boolean, if: Proc.new { answer_type.value == 'Boolean' }
  after_create :create_unavailable_answer, if: Proc.new { unavailable == '1' && category.reference_prefix == 'A' } # Ensure unavailable is checked and the category is Assessment

  attr_accessor :unavailable

  enum priority: [:basic, :triage, :mandatory]

  has_many :answers, foreign_key: 'node_id', dependent: :destroy
  belongs_to :category
  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  private

  # {Node#unique_reference}
  # Scoped by the current algorithm
  def unique_reference
    if category.present? && algorithm.questions.where(reference: "#{category.reference_prefix}#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  # {Node#complete_reference}
  def complete_reference
    if category.present?
      self.reference = "#{category.reference_prefix}#{reference}"
    end
  end

  # Automatically create unavailable answer
  # Create 1 automatic answer for tests/assessments if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    Answer.create!(node_id: id, reference: '0', label_en: I18n.t('answers.unavailable'))
  end
end
