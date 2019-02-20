class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    create_table :answers do |t|
      t.string :reference
      t.hstore :label_translations
      t.string :operator
      t.string :value

      t.belongs_to :node

      t.timestamps
    end
  end
end
