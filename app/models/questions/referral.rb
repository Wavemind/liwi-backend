# Category of question about referral
# Reference prefix : R
class Questions::Referral < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'referral'
  end

end