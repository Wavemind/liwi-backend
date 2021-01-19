class AddTranslationsToAlgorithms < ActiveRecord::Migration[6.0]
  def change
    enable_extension "hstore"
    add_column :algorithms, :emergency_content_translations, :hstore
  end
end
