# Define a regular sequence of questions
# Reference prefix : DC
class QuestionsSequences::Comorbidity < QuestionsSequence

  def self.policy_class
    QuestionsSequencePolicy
  end

  def self.variable
    'comorbidity'
  end

end
