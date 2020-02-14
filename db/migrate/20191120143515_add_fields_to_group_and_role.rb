class AddFieldsToGroupAndRole < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :local_data_ip, :string
    add_column :groups, :main_data_ip, :string
    add_column :groups, :architecture, :integer
    add_column :groups, :pin_code, :string

    add_column :roles, :stage, :integer

    remove_column :users, :role_id
  end
end
