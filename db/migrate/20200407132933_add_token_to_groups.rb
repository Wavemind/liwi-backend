class AddTokenToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :token, :string
  end
end
