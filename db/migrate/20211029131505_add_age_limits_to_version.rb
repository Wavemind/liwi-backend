class AddAgeLimitsToVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :versions, :minimum_age, :integer
    add_column :versions, :age_limit, :integer
    add_column :versions, :age_limit_message, :hstore
  end
end
