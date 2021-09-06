class RemoveUnusedFieldsFromVersion < ActiveRecord::Migration[6.0]
  def change
    remove_column :versions, :medal_r_config
    remove_column :versions, :medal_data_config
  end
end
