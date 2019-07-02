# Category of question for the medical tests
class Questions::AssessmentTest < Question

  after_create :create_unavailable_answer, if: Proc.new { unavailable == '1' } # Ensure unavailable is checked

  attr_accessor :unavailable

  def self.variable
    'assessment_test'
  end

  private

  # Automatically create unavailable answer
  # Create 1 automatic answer if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    answer = self.answers.new(reference: '0', label_en: I18n.t('answers.unavailable'))
    answer.save(validate: false)
  end
end
