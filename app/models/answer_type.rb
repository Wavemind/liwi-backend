# Define how to display a question and how interpret their answers
class AnswerType < ApplicationRecord

  has_many :questions

  validates_presence_of :value
  validates_presence_of :display


  # @return [String]
  # Return a displayable string for the view
  def display_name
    I18n.t('answer_type.labels')[id]
  end
end
