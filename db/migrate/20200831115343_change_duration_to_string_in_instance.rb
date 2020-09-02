class ChangeDurationToStringInInstance < ActiveRecord::Migration[5.2]
  def change
    change_column :instances, :duration, :string
  end
end
