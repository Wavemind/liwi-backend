class AddDescriptionToStudies < ActiveRecord::Migration[6.0]
  def change
    add_column :studies, :description, :text, default: ""
  end
end
