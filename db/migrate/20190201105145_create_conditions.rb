class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.integer :operator
      t.references :referenceable, polymorphic: true, index: { name: :index_referenceable_id }
      t.references :first_conditionable, polymorphic: true, index: { name: :index_first_conditionable_id }
      t.references :second_conditionable, polymorphic: true, index: { name: :index_second_conditionable_id }
      t.boolean :top_level, default: true
      t.integer :score

      t.timestamps
    end
  end
end
