class AddPositionXAndPositionYToInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :instances, :position_x, :integer, default: 100
    add_column :instances, :position_y, :integer, default: 100
  end
end
