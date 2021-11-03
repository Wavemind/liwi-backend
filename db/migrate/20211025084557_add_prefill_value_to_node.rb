class AddPrefillValueToNode < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :is_pre_fill, :boolean, default: false
  end
end
