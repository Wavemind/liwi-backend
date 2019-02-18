class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.float :weight
      t.references :node
      t.references :instance

      t.timestamps
    end
  end
end
