class CreateAlgorithmVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithm_versions do |t|
      t.string :version
      t.string :json

      t.references :user, foreign_key: true, index: true
      t.references :algorithm, foreign_key: true, index: true

      t.timestamps
    end
  end
end
