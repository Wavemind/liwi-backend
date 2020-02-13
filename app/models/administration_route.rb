# Define the possible administration routes for a treatment
class AdministrationRoute < ApplicationRecord

  enum category: [:enteral, :parenteral_injectable, :mucocutaneous]

  has_many :formulations

end
