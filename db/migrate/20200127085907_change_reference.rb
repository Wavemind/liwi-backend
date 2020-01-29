class ChangeReference < ActiveRecord::Migration[5.2]
  def change
    change_column :diagnostics, :reference, 'integer USING id::INT'
    change_column :nodes, :reference, 'integer USING id::INT'
    change_column :answers, :reference, 'integer USING id::INT'
  end
end
