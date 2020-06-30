class AddEstimableToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :estimable, :boolean, default: false
  end
end
