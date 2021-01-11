class AddJobIdToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :job_id, :string, default: ""
  end
end
