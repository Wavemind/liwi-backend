# Child of Node / Questions asked to the patient
class Question < Node

  enum priority: [:basic, :triage, :priority]

  has_many :answers
  belongs_to :category
  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  before_create :complete_reference

  def complete_reference
    self.reference = "#{category.reference_prefix}_#{reference}"
  end

end
