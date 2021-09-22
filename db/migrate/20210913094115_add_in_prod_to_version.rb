class AddInProdToVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :versions, :in_prod, :boolean, default: false
  end
end
