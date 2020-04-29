class AddQuestionsOrdersToVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :questions_orders, :json

    remove_column :versions, :triage_questions_order
    remove_column :versions, :triage_unique_triage_question_order
    remove_column :versions, :triage_complaint_category_order
    remove_column :versions, :triage_basic_measurement_order
    remove_column :versions, :triage_chronic_condition_order
  end
end
