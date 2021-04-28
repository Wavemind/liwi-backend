# Category of question who defines other condition that might influence the present patient condition
# Reference prefix : CH
class Questions::ChronicCondition < Question

  after_create :create_unavailable_answer, if: Proc.new { unavailable == '1' || unavailable == true} # Ensure unavailable is checked
  
  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'chronic_condition'
  end

  private

  # Automatically create unavailable answer
  # Create 1 automatic answer if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    answer = self.answers.new(reference: '0', value: 'not_available', label_translations: Hash[Language.all.map(&:code).unshift('en').collect { |k| [k, I18n.t('answers.unknown', locale: k)] } ])
    answer.save(validate: false)
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:medical_history]
  end
end
