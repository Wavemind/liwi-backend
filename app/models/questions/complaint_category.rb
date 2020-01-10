# Category of question for the first complaints of the patient
# Reference prefix : CC
class Questions::ComplaintCategory < Question


  def self.variable
    'complaint_category'
  end

  # @return [Boolean]
  # Verify if current node have instances dependencies
  def instance_dependencies?
    dependencies.map(&:instanceable).present? || diagnostics.any?
  end

end
