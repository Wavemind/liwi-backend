# Category of question to complement basic measurements questions
# Reference prefix : AM
class Questions::AnswerableBasicMeasurement < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'answerable_basic_measurement'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:basic_measurements_step]
  end
end
