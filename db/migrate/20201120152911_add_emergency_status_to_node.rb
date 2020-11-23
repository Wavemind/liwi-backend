class AddEmergencyStatusToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :emergency_status, :integer, default: 0
  end
end
