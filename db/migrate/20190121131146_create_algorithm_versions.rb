class CreateAlgorithmVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithm_versions do |t|
      t.string :version
      t.text :json
      t.boolean :archived, default: false

      t.references :user, foreign_key: true, index: true
      t.references :algorithm, foreign_key: true, index: true

      t.timestamps
    end
  end
end
