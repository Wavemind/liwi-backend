# Define every treatments for a diagnostic
class AssessmentTest < Question

  after_create :create_unavailable_answer, if: Proc.new { unavailable == '1' } # Ensure unavailable is checked

  private

  # Automatically create unavailable answer
  # Create 1 automatic answer if attr_accessor :unavailable in question is checked
  def create_unavailable_answer
    Answer.create!(node_id: id, reference: '0', label_en: I18n.t('answers.unavailable'))
  end
end
