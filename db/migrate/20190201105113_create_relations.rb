class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.references :node, index: true
      t.references :relationable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
