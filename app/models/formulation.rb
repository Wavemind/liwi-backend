# Define the different forms for a drug
class Formulation < ApplicationRecord

  belongs_to :node
  belongs_to :administration_route

end
