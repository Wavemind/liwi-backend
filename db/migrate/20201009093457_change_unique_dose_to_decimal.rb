class ChangeUniqueDoseToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :formulations, :unique_dose, :decimal
  end
end
