# Category of question for the global information
# Reference prefix : BD
class Questions::BasicDemographic < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'basic_demographic'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps(:registration_step)
  end
end
