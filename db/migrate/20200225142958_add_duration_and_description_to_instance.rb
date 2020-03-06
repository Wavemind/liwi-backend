class AddDurationAndDescriptionToInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :instances, :duration, :integer
    add_column :instances, :description, :string
  end
end
