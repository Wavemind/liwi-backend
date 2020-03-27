class FixVersionAttributes < ActiveRecord::Migration[5.2]
  def change
    rename_column :versions, :triage_emergency_sign_order, :triage_unique_triage_question_order
    rename_column :versions, :triage_vital_sign_triage_order, :triage_basic_measurement_order
  end
end
