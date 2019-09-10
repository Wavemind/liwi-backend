class AddTriageQuestionsOrderToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :triage_questions_order, :integer, array: true, default: []
  end
end
