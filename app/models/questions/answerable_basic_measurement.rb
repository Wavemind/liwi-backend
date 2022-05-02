# Category of question concerning basic measurements taken during the triage
# Reference prefix : BM
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
