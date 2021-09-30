class AddDefaultLanguageToStudy < ActiveRecord::Migration[6.0]
  def change
    add_column :studies, :default_language, :string, default: 'en'
  end
end
