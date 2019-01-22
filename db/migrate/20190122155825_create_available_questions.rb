class CreateAvailableQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :available_questions do |t|
      t.references :algorithm, foreign_key: true, index: true
      t.references :node, foreign_key: true, index: true

      t.timestamps
    end
  end
end
