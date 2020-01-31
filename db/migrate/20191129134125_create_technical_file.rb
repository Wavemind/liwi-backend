class CreateTechnicalFile < ActiveRecord::Migration[5.2]
  def change
    create_table :technical_files do |t|
      t.references :user, foreign_key: true, index: true
      t.string :file
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
