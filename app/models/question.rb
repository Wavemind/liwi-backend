# Child of Node / Questions asked to the patient
class Question < Node

  enum priority: [:basic, :triage, :priority]
  enum category: [:comorbidity, :exposure, :symptom, :physical_exam, :test]

  has_many :answers

  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

end
