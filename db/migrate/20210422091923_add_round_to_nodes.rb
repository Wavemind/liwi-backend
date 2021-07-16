class AddRoundToNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :round, :integer
  end
end
