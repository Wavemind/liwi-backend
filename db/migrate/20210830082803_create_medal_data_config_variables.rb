class CreateMedalDataConfigVariables < ActiveRecord::Migration[6.0]
  def change
    create_table :medal_data_config_variables do |t|
      t.string "label"
      t.string "api_key"
      t.references :version, foreign_key: true, index: true
      t.belongs_to :question
    end
  end
end
