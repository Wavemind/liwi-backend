# TODO : Define its utility ?
# Category of question concerning questions concerning previous consultations
# Reference prefix : CR
class Questions::ConsultationRelated < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'consultation_related'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps(:registration_step)
  end
end
