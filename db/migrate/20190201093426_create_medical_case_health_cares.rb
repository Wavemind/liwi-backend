class CreateMedicalCaseHealthCares < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_case_health_cares do |t|
      t.belongs_to :node
      t.belongs_to :medical_case

      t.timestamps
    end
  end
end
