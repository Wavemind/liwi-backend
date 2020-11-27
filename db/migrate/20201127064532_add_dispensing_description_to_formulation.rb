class AddDispensingDescriptionToFormulation < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    add_column :formulations, :dispensing_description_translations, :hstore
  end
end
