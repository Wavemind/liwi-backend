class AddAnswerRequiredToAnswerType < ActiveRecord::Migration[5.2]
  def change
    add_column :answer_types, :answer_required, :boolean, default: true
  end
end
