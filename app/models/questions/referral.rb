# Category of question about referral
# Reference prefix : R
class Questions::Referral < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'referral'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:referral_step]
  end
end
