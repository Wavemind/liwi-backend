# Category of question for the global information
class Questions::Demographic < Question
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  def self.variable
    'demographic'
  end

end
