class CreateDiagnostics < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    create_table :diagnostics do |t|
      t.string :reference
      t.hstore :label_translations

      t.references :version, foreign_key: true, index: true

      t.timestamps
    end
  end
end
