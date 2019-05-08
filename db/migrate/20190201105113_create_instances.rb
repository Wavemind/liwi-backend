class CreateInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :instances do |t|
      t.references :node, index: true
      t.references :instanceable, polymorphic: true, index: true
      t.boolean :is_condition, default: false

      t.timestamps
    end
  end
end
