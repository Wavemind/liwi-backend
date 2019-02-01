class CreateCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :reference_prefix

      t.timestamps
    end
  end
end
