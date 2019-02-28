class CreateCategory < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    create_table :categories do |t|
      t.hstore :name_translations
      t.string :parent
      t.string :reference_prefix

      t.timestamps
    end
  end
end
