class RenameQuestionsOrderToMedalRConfigInVersion < ActiveRecord::Migration[5.2]
  def change
    rename_column :versions, :questions_orders, :medal_r_config
  end
end
