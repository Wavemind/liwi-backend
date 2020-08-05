class CreateFinalDiagnosisExclusion < ActiveRecord::Migration[5.2]
  def change
    create_table :final_diagnosis_exclusions do |t|

    end

    remove_column :nodes, :final_diagnostic_id

    add_reference :final_diagnosis_exclusions, :excluding_diagnosis, index: true
    add_foreign_key :final_diagnosis_exclusions, :nodes, column: :excluding_diagnosis_id

    add_reference :final_diagnosis_exclusions, :excluded_diagnosis, index: true
    add_foreign_key :final_diagnosis_exclusions, :nodes, column: :excluded_diagnosis_id

  end
end
