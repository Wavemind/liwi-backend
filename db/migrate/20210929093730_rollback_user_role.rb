class RollbackUserRole < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_logs, :data_before, :data
    remove_column :user_logs, :data_after, :json
  end
end
