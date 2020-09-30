class RenameFinalDiagnosisExclusionInNodeExclusion < ActiveRecord::Migration[5.2]
  def change
    add_column :final_diagnosis_exclusions, :node_type, :integer
    rename_column :final_diagnosis_exclusions, :excluding_diagnosis_id, :excluding_node_id
    rename_column :final_diagnosis_exclusions, :excluded_diagnosis_id, :excluded_node_id
    rename_table :final_diagnosis_exclusions, :node_exclusions
  end
end
