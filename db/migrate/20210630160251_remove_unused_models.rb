class RemoveUnusedModels < ActiveRecord::Migration[6.0]
  def change
    drop_table :medical_case_final_diagnoses
    drop_table :medical_case_health_cares
    drop_table :medical_case_answers
    drop_table :medical_cases
    drop_table :patients
  end
end
