class AddIsNeonatToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_neonat, :boolean, default: false
  end
end
