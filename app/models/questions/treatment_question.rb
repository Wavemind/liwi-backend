# Category of question concerning question for drugs
# Reference prefix : TQ
class Questions::TreatmentQuestion < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'treatment_question'
  end

end
