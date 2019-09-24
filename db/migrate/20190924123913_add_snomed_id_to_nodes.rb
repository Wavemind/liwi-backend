class AddSnomedIdToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :snomed_id, :bigint
  end
end
