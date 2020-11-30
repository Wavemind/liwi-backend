class AddIsArmControlToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :is_arm_control, :boolean, default: false
  end
end
