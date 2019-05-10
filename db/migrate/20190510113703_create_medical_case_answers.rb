class CreateMedicalCaseAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_case_answers do |t|
      t.string :value
      t.references :medical_case, index: true
      t.references :version, index: true
      t.references :answer, index: true
    end
  end
end
