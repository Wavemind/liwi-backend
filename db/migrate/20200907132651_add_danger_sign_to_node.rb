class AddDangerSignToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_danger_sign, :boolean, default: false
  end
end
