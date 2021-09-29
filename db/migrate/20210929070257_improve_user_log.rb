class ImproveUserLog < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_logs, :data, :data_before
    add_column :user_logs, :data_after, :json
    add_timestamps :user_logs, default: Time.zone.now
    change_column_default :user_logs, :created_at, nil
    change_column_default :user_logs, :updated_at, nil
  end
end
