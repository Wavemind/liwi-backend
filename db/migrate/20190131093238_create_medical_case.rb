class CreateMedicalCase < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_cases do |t|
      t.string :file
      t.belongs_to :patient
      t.belongs_to :version

      t.timestamps
    end
  end
end
