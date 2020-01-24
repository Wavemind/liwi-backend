class AddSystemToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :system, :integer
  end
end
