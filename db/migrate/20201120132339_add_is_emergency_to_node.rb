class AddIsEmergencyToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_emergency, :boolean, default: false
  end
end
