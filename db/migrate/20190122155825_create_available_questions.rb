class CreateAvailableQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :available_questions do |t|
      t.references :algorithm, foreign_key: true, index: true
      t.belongs_to :question

      t.timestamps
    end
  end
end
