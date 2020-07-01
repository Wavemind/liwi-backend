class AddMedalRConfigToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :medal_r_config, :json
  end
end
