# Category of question for the first complaints of the patient
# Reference prefix : CC
class Questions::ComplaintCategory < Question

  has_many :node_complaint_categories, foreign_key: 'complaint_category_id' # Complaint category linked to the questions and questions sequences
  has_many :complaint_categories, through: :node_complaint_categories

  def self.policy_class
    QuestionPolicy
  end

  def self.variable
    'complaint_category'
  end

  # @return [Boolean]
  # Verify if current node have instances dependencies
  def instance_dependencies?
    instances.any? || diagnostics.any?
  end

  # Associate proper step depending on category ; empty for parent
  def associate_step
    self.step = Question.steps[:complaint_categories_step]
  end
end
