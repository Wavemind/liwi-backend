class ChangePriorityType < ActiveRecord::Migration[5.2]
  def change
    remove_column :nodes, :priority
    add_column :nodes, :is_mandatory, :boolean, default: false
  end
end
