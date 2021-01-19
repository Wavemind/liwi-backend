class AddTranslationsToStudies < ActiveRecord::Migration[6.0]
  def change
    enable_extension "hstore"
    add_column :studies, :description_translations, :hstore
  end
end
