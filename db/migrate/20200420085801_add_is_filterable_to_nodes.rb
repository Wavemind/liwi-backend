class AddIsFilterableToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_filterable, :boolean, default: false
  end
end
