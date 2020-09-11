# Category of question concerning physical exam to do on the patient
# Reference prefix : PE
class Questions::PhysicalExam < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'physical_exam'
  end

end
