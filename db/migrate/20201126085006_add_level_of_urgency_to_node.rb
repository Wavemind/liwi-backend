class AddLevelOfUrgencyToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :level_of_urgency, :integer, default: 5
  end
end
