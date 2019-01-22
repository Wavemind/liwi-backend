# Child of Node / Questions asked to the patient
class Question < Node

  has_many :answers
  has_many :available_questions
  has_many :algorithms, through: :available_questions

  belongs_to :answer_type

  validates_presence_of :priority
  validates_presence_of :category

end
