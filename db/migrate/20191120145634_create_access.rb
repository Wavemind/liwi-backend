class CreateAccess < ActiveRecord::Migration[5.2]
  def change
    create_table :accesses do |t|
      t.references :user
      t.references :role
    end
  end
end
