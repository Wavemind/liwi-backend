class RenameDiagnosticToDiagnosis < ActiveRecord::Migration[6.0]
  def change
    rename_column :final_diagnostic_health_cares, :final_diagnostic_id, :final_diagnosis_id
    rename_column :instances, :final_diagnostic_id, :final_diagnosis_id
    rename_column :medical_case_final_diagnostics, :final_diagnostic_id, :final_diagnosis_id
    rename_column :nodes, :diagnostic_id, :diagnosis_id

    rename_table :diagnostics, :diagnoses
    rename_table :medical_case_final_diagnostics, :medical_case_final_diagnoses
  end
end
