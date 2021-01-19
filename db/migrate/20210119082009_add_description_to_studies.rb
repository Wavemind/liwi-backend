class AddDescriptionToStudies < ActiveRecord::Migration[5.2]
  def change
    add_column :studies, :description, :text, default: ""
  end
end
