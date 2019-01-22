class AddArchivedToAlgorithmVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithm_versions, :archived, :boolean, default: false
  end
end
