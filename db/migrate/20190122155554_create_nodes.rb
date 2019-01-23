class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :label
      t.string :reference
      t.integer :priority
      t.integer :category
      t.string :type

      t.text :description

      t.timestamps
    end
  end
end
