class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.float :wheight
      t.references :node
      t.references :relation

      t.timestamps
    end
  end
end
