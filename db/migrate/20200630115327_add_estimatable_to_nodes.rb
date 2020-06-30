class AddEstimatableToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :estimable, :boolean
  end
end
