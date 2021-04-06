class AddHstoreFields < ActiveRecord::Migration[6.0]
  def change
    enable_extension "hstore"
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
