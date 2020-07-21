class UpdateFormulation < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    add_column :formulations, :injection_instructions_translations, :hstore
  end
end
