# Define which questions is available for an algorithm
class AvailableQuestion < ApplicationRecord

  belongs_to :algorithm
  belongs_to :question

end
