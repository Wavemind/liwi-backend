class CreateMedicalStaff < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_staffs do |t|
      t.string :first_name
      t.string :last_name
      t.integer :role
      t.belongs_to :group

      t.timestamps
    end
  end
end
