# Category of question concerning vital signs taken during the consultation
# Reference prefix : VS
class Questions::VitalSignAnthropometric < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'vital_sign_anthropometric'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:basic_measurements_step]
  end
end
