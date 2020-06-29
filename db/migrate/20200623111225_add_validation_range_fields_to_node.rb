class AddValidationRangeFieldsToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :min_value_warning, :float
    add_column :nodes, :max_value_warning, :float
    add_column :nodes, :min_value_error, :float
    add_column :nodes, :max_value_error, :float

    add_column :nodes, :min_message_warning, :string
    add_column :nodes, :max_message_warning, :string
    add_column :nodes, :min_message_error, :string
    add_column :nodes, :max_message_error, :string
  end
end
