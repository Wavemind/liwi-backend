class CreateMedicalCaseFinalDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_case_final_diagnostics do |t|
      t.belongs_to :final_diagnostic
      t.belongs_to :medical_case

      t.timestamps
    end
  end
end
