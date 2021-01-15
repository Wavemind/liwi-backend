# Category of question concerning exposures to environments at risk
# Reference prefix : E
class Questions::Exposure < Question

  after_create :create_unavailable_answer, if: Proc.new { unavailable == '1' || unavailable == true} # Ensure unavailable is checked

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'exposure'
  end

  private

  # Automatically create unavailable answer
  # Create 1 automatic answer if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    answer = self.answers.new(reference: '0', value: 'not_available', label_en: I18n.t('answers.unknown'))
    answer.save(validate: false)
  end

end
