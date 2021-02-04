class AddStepToNode < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :step, :integer
  end
end
