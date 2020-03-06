# Define the possible administration routes for a treatment
class AdministrationRoute < ApplicationRecord

  has_many :formulations

  # @return [String]
  # Return a displayable string for the view
  def display_name
    I18n.t('administration_routes.labels')[id]
  end

  def self.generate_select_options
    options = []
    AdministrationRoute.all.map(&:category).uniq.each do |category|
      ar_option = {label: category, options: []}
      AdministrationRoute.where(category: category).map do |ar|
        ar_option[:options].push({value: ar.id, label: ar.name})
      end
      options.push(ar_option)
    end
    options
  end
end
