class AddEmergencyContentVersionToAlgorithm < ActiveRecord::Migration[6.0]
  def change
    add_column :algorithms, :emergency_content_version, :bigint, default: 0
  end
end
