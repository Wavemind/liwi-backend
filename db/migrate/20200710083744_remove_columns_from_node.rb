class RemoveColumnsFromNode < ActiveRecord::Migration[5.2]
  def change
    remove_column :nodes, :administration_route_id
    remove_column :nodes, :is_filterable
  end
end
