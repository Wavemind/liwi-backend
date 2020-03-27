class AddIsAntiMalarialAndIsAntibioticToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_anti_malarial, :boolean, default: false
    add_column :nodes, :is_antibiotic, :boolean, default: false
  end
end
