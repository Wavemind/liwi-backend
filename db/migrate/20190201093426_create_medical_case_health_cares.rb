class CreateMedicalCaseHealthCares < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_case_health_cares do |t|
      t.references :treatable, polymorphic: true, index: { name: :index_medical_cases_treatable_id }

      t.timestamps
    end
  end
end
