class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.string :name
      t.boolean :archived, default: false

      t.references :user, foreign_key: true, index: true
      t.references :algorithm, foreign_key: true, index: true

      t.timestamps
    end

    create_table :group_accesses do |t|
      t.boolean :access, default: true
      t.datetime :end_date

      t.references :version, foreign_key: true, index: true
      t.references :group, foreign_key: true, index: true

      t.timestamps
    end

    add_reference :devices, :group, foreign_key: true, index: true

  end
end
