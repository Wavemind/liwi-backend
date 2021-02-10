# TODO : Define its utility ?
# Category of question concerning physical signs to consider at triage
# Reference prefix : UP
class Questions::UniqueTriagePhysicalSign < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'unique_triage_physical_sign'
  end

end
