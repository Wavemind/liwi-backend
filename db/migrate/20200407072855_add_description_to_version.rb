class AddDescriptionToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :description, :text
  end
end
