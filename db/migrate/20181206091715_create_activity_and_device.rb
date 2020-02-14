class CreateActivityAndDevice < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :mac_address
      t.string :name
      t.string :model
      t.string :brand
      t.string :os
      t.string :os_version
      t.integer :status, default: 0

      t.timestamps
    end

    create_table :activities do |t|
      t.decimal :longitude, precision: 13, scale: 9
      t.decimal :latitude, precision: 13, scale: 9
      t.string :timezone
      t.string :version

      t.references :user, foreign_key: true, index: true
      t.references :device, foreign_key: true, index: true

      t.timestamps
    end
  end
end
