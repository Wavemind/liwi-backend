class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :label
      t.string :reference
      t.integer :priority
      t.string :type

      t.belongs_to :category
      t.text :description

      t.timestamps
    end
  end
end
