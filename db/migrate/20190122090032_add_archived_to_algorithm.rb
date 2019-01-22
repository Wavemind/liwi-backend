class AddArchivedToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :archived, :boolean, default: false
  end
end
