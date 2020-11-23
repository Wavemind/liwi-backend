class AddUnavailableToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :unavailable, :boolean, default: false
  end
end
