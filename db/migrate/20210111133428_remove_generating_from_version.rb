class RemoveGeneratingFromVersion < ActiveRecord::Migration[5.2]
  def change
    remove_column :versions, :generating
  end
end
