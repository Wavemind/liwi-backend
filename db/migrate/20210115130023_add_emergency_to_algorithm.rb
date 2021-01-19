class AddEmergencyToAlgorithm < ActiveRecord::Migration[6.0]
  def change
    add_column :algorithms, :emergency_content, :text, default: ""
  end
end
