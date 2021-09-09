class CreateUserLog < ActiveRecord::Migration[6.0]
  def change
    create_table :user_logs do |t|
      t.belongs_to :user
      t.string :action
      t.string :model_type
      t.bigint :model_id
      t.json :data
      t.string :ip_address
    end
  end
end
