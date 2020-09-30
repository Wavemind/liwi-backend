# Define a regular sequence of questions
# Reference prefix : TI
class QuestionsSequences::Triage < QuestionsSequence

  def self.policy_class
    QuestionsSequencePolicy
  end

  def self.variable
    'triage'
  end

end
