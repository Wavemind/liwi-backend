class AddCutOffs < ActiveRecord::Migration[6.0]
  def change
    add_column :diagnostics, :cut_off_start, :integer
    add_column :diagnostics, :cut_off_end, :integer

    add_column :conditions, :cut_off_start, :integer
    add_column :conditions, :cut_off_end, :integer

    add_column :nodes, :cut_off_start, :integer
    add_column :nodes, :cut_off_end, :integer
  end
end
