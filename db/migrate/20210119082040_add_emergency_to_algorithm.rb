class AddEmergencyToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :emergency_content, :text, default: ""
  end
end
