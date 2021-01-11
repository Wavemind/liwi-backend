# Category of question concerning vaccines
# Reference prefix : V
class Questions::Vaccine < Question

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'vaccine'
  end

  private

  # Automatically create unavailable answer
  # Create 1 automatic answer if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    answer = self.answers.new(reference: '0', value: 'not_available', label_en: I18n.t('answers.unknown'))
    answer.save(validate: false)
  end

end
