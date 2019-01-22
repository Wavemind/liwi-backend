class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :reference
      t.string :label
      t.string :operator
      t.string :value

      t.references :node, foreign_key: true, index: true

      t.timestamps
    end
  end
end
