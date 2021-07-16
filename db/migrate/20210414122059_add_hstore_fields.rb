class AddHstoreFields < ActiveRecord::Migration[6.0]
  def change
    enable_extension "hstore"
    rename_column :administration_routes, :name, :old_name
    rename_column :algorithms, :age_limit_message, :old_age_limit_message
    rename_column :nodes, :min_message_error, :old_min_message_error
    rename_column :nodes, :max_message_error, :old_max_message_error
    rename_column :nodes, :min_message_warning, :old_min_message_warning
    rename_column :nodes, :max_message_warning, :old_max_message_warning
    rename_column :instances, :duration, :old_duration
    rename_column :instances, :description, :old_description
    rename_column :versions, :description, :old_description

    add_column :administration_routes, :name_translations, :hstore
    add_column :algorithms, :age_limit_message_translations, :hstore
    add_column :nodes, :min_message_error_translations, :hstore
    add_column :nodes, :max_message_error_translations, :hstore
    add_column :nodes, :min_message_warning_translations, :hstore
    add_column :nodes, :max_message_warning_translations, :hstore
    add_column :instances, :duration_translations, :hstore
    add_column :instances, :description_translations, :hstore
    add_column :versions, :description_translations, :hstore
  end
end
