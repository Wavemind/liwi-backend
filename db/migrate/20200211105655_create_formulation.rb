class CreateFormulation < ActiveRecord::Migration[5.2]
  def change
    create_table :formulations do |t|
      t.float :minimal_dose_per_kg
      t.float :maximal_dose_per_kg
      t.float :maximal_dose
      t.integer :medication_form
      t.integer :dose_form
      t.integer :liquid_concentration
      t.integer :doses_per_day
      t.integer :unique_dose

      t.references :node
      t.references :administration_route

      t.timestamp
    end
  end
end
