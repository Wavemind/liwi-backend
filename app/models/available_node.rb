# Define which questions is available for an algorithm
class AvailableNode < ApplicationRecord

  belongs_to :algorithm
  belongs_to :node

end
