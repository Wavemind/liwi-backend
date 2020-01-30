class FixVersionNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :versions, :triage_chief_complaints_order, :triage_complaint_categories_order
    rename_column :versions, :triage_vital_signs_order, :triage_basic_measurements_order
  end
end
