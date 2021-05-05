class RemoveUnusedFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :administration_routes, :old_name, :string
    remove_column :algorithms, :old_age_limit_message, :string
    remove_column :nodes, :old_min_message_error, :string
    remove_column :nodes, :old_max_message_error, :string
    remove_column :nodes, :old_min_message_warning, :string
    remove_column :nodes, :old_max_message_warning, :string
    remove_column :instances, :old_duration, :string
    remove_column :instances, :old_description, :string
    remove_column :versions, :old_description, :text
  end
end
