# Define the children of an answer
class Child < ApplicationRecord

  belongs_to :relation
  belongs_to :node

end
