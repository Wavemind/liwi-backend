class InvertStudyLinks < ActiveRecord::Migration[5.2]
  def change
    remove_column :studies, :algorithm_id
    add_column :algorithms, :study_id, :integer
  end
end
