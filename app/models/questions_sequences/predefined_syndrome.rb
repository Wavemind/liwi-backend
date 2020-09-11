# Define a regular sequence of questions
# Reference prefix : PS
class QuestionsSequences::PredefinedSyndrome < QuestionsSequence

  def self.policy_class
    QuestionsSequencePolicy
  end

  def self.variable
    'predefined_syndrome'
  end

end
