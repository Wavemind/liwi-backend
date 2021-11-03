class RemoveFinalDiagnosisHealthCare < ActiveRecord::Migration[6.0]
  def change
    drop_table :final_diagnosis_health_cares
  end
end
