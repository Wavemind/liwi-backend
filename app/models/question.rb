# Child of Node / Questions asked to the patient
class Question < Node

  enum priority: [:basic, :triage, :priority]

  has_many :answers
  belongs_to :category
  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  private

  def unique_reference
    if Question.where(reference: "#{category.reference_prefix}_#{reference}").any?
      errors.add(:reference, I18n.t('nodes.validation.reference_used'))
    end
  end

  def complete_reference
    self.reference = "#{category.reference_prefix}_#{reference}" unless reference.start_with?("#{category.reference_prefix}_")
  end

end
