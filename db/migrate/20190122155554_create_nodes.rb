class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :label
      t.string :reference
      t.string :priority
      t.string :category
      t.string :type

      t.text :description

      t.timestamps
    end
  end
end
