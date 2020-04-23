class AddConfigFieldsToVersion < ActiveRecord::Migration[5.2]
  def change
    add_reference :versions, :top_left_instance
    add_reference :versions, :first_top_right_question
    add_reference :versions, :second_top_right_question
  end
end
