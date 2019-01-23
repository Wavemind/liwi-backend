class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :reference
      t.string :label
      t.string :operator
      t.string :value

      t.belongs_to :question

      t.timestamps
    end
  end
end
