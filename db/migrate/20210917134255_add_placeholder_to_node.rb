class AddPlaceholderToNode < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :placeholder_translations, :hstore
  end
end
