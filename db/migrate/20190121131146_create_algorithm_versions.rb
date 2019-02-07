class CreateAlgorithmVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithm_versions do |t|
      t.string :version
      t.boolean :archived, default: false

      t.references :user, foreign_key: true, index: true
      t.references :algorithm, foreign_key: true, index: true

      t.timestamps
    end

    create_table :group_algorithm_versions do |t|
      t.references :algorithm_version, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end

    add_reference :devices, :group, foreign_key: true, index: true

  end
end
