class AddFieldsToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :is_triage, :boolean, default: false
    add_column :nodes, :is_identifiable, :boolean, default: false
  end
end
