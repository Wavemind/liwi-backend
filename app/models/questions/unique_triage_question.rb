# Category of question who defines first basic question to possibly improve priority of a patient
# Reference prefix : UT
class Questions::UniqueTriageQuestion < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'unique_triage_question'
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:first_look_assessment_step]
  end
end
