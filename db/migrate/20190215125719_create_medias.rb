class CreateMedias < ActiveRecord::Migration[5.2]
  def change
    create_table :medias do |t|
      t.string :label
      t.string :url
      t.references :fileable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
