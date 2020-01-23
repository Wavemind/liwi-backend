class UpdateVersionTriageOrderFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :versions, :triage_complaint_categories_order, :triage_complaint_category_order
    rename_column :versions, :triage_basic_measurements_order, :triage_vital_sign_triage_order
    rename_column :versions, :triage_first_look_assessments_order, :triage_emergency_sign_order
    rename_column :versions, :triage_chronical_conditions_order, :triage_chronic_condition_order
  end
end
