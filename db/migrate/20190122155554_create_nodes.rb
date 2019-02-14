class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :label
      t.string :reference
      t.integer :priority
      t.string :type

      t.belongs_to :category
      t.belongs_to :diagnostic
      t.text :description

      t.references :algorithm, foreign_key: true, index: true

      t.timestamps
    end

    add_reference :nodes, :final_diagnostic, column: :final_diagnostic_id

  end
end
