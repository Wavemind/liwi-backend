class CreateEnabledDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :enabled_diagnostics do |t|
      t.references :algorithm_version, foreign_key: true, index: true
      t.references :diagnostic, foreign_key: true, index: true

      t.timestamps
    end
  end
end
