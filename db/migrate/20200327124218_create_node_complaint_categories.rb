class CreateNodeComplaintCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :node_complaint_categories do |t|
      t.belongs_to :node
      t.belongs_to :complaint_category
    end
  end
end
