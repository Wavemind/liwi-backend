# Category of question for the calculate results from a formula and previous answers
# Reference prefix : BC
class Questions::BackgroundCalculation < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'background_calculation'
  end

end
