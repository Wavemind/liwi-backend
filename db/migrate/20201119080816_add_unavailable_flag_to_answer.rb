class AddUnavailableFlagToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :unavailable, :boolean, default: false
  end
end
