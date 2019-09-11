class AddTriageOrdersToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :triage_first_look_assessments_order, :integer, array: true, default: []
    add_column :versions, :triage_chief_complaints_order, :integer, array: true, default: []
    add_column :versions, :triage_vital_signs_order, :integer, array: true, default: []
    add_column :versions, :triage_chronical_conditions_order, :integer, array: true, default: []
  end
end
