class CreateAvailableNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :available_nodes do |t|
      t.references :algorithm, foreign_key: true, index: true
      t.belongs_to :node

      t.timestamps
    end
  end
end
