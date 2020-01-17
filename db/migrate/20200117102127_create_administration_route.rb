class CreateAdministrationRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :administration_routes do |t|
      t.integer :type
      t.string :name
    end
  end
end
