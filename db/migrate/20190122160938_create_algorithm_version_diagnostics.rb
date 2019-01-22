class CreateAlgorithmVersionDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithm_version_diagnostics do |t|
      t.references :algorithm_version, foreign_key: true, index: true
      t.references :diagnostic, foreign_key: true, index: true

      t.timestamps
    end
  end
end
