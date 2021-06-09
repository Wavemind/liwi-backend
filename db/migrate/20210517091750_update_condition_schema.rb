class UpdateConditionSchema < ActiveRecord::Migration[6.0]
  def change
    remove_column :conditions, :operator, :integer
    remove_column :conditions, :top_level, :boolean
  end

  # change_table :conditions do |t|
  #   t.remove_references :second_conditionable, :polymorphic => true
  #   t.belongs_to :instance
  #   t.belongs_to :answer
  # end
end
