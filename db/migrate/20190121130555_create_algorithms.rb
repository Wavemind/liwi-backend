class CreateAlgorithms < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithms do |t|
      t.string :name
      t.string :description

      t.references :user, foreign_key: true, index: true

      t.timestamps
    end

  end
end
