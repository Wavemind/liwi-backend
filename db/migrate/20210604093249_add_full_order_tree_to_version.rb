class AddFullOrderTreeToVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :versions, :full_order_json, :json
  end
end
