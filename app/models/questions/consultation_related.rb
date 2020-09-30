# Category of question concerning questions concerning previous consultations
# Reference prefix : CR
class Questions::ConsultationRelated < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'consultation_related'
  end

end
