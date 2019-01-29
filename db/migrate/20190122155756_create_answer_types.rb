class CreateAnswerTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_types do |t|
      t.string :value
      t.string :display

      t.timestamps
    end

    add_reference :nodes, :answer_type, foreign_key: true, index: true

  end
end
