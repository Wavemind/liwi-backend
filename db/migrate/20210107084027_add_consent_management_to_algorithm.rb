class AddConsentManagementToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :consent_management, :boolean, default: true
  end
end
