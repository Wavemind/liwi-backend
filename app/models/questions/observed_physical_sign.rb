# Category of question for the observed physical signs
# Reference prefix : OS
class Questions::ObservedPhysicalSign < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'observed_physical_sign'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:medical_history]
  end
end
