class CreateDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnostics do |t|
      t.string :reference
      t.string :label

      t.timestamps
    end
  end
end
