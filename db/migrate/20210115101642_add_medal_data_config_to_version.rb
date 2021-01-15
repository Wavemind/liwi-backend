class AddMedalDataConfigToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :medal_data_config, :json, default: {}
  end
end
