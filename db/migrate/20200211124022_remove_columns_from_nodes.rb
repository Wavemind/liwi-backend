class RemoveColumnsFromNodes < ActiveRecord::Migration[5.2]
  def change
    remove_column :nodes, :minimal_dose_per_kg
    remove_column :nodes, :maximal_dose_per_kg
    remove_column :nodes, :maximal_dose
    remove_column :nodes, :treatment_type
    remove_column :nodes, :pill_size
    remove_column :nodes, :doses_per_day
  end
end
