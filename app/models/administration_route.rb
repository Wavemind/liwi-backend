# Define the possible administration routes for a treatment
class AdministrationRoute < ApplicationRecord

  enum type: [:enteral, :parenteral_injectable, :mucocutaneous]

  has_many :treatments

end
