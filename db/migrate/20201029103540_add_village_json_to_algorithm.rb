class AddVillageJsonToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :village_json, :json
  end
end
