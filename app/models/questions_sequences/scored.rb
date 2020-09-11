# Define a sequence based on the score to each answers
# Reference prefix : QSS
class QuestionsSequences::Scored < QuestionsSequence

  def self.policy_class
    QuestionsSequencePolicy
  end

  def self.variable
    'scored'
  end

end
