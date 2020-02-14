class AddFieldsToTreatment < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :minimal_dose_per_kg, :decimal
    add_column :nodes, :maximal_dose_per_kg, :decimal
    add_column :nodes, :maximal_dose, :decimal
    add_column :nodes, :treatment_type, :integer
    add_column :nodes, :pill_size, :integer
    add_column :nodes, :doses_per_day, :integer
  end
end
