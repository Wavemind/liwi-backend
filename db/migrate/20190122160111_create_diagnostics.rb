class CreateDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnostics do |t|
      t.string :reference
      t.string :label

      t.references :algorithm_version, foreign_key: true, index: true

      t.timestamps
    end
  end
end
