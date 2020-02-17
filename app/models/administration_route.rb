# Define the possible administration routes for a treatment
class AdministrationRoute < ApplicationRecord

  has_many :formulations

  # @return [String]
  # Return a displayable string for the view
  def display_name
    I18n.t('administration_routes.labels')[id]
  end
end
