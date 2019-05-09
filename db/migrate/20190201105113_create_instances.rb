class CreateInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :instances do |t|
      t.references :node, index: true
      t.references :instanceable, polymorphic: true, index: true

      t.timestamps
    end
    add_reference :instances, :final_diagnostic, column: :final_diagnostic_id
  end
end
