# Define the different forms for a drug
class Formulation < ApplicationRecord

  enum medication_form: [:tablet, :capsule, :syrup, :suspension, :suppository, :drops, :solution, :patch, :cream, :ointment, :gel, :spray, :inhaler]
  enum breakable: [:one, :two, :four]

  belongs_to :node
  belongs_to :administration_route

end
