class AddJsonAndJsonVersionToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :medal_r_json, :json
    add_column :versions, :medal_r_json_version, :integer, default: 0
  end
end
