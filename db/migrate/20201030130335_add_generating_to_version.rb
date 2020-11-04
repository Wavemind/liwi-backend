class AddGeneratingToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :generating, :boolean
  end
end
