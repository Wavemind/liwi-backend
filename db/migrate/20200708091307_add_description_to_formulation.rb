class AddDescriptionToFormulation < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    add_column :formulations, :description_translations, :hstore
  end
end
