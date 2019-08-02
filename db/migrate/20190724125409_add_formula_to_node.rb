class AddFormulaToNode < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :formula, :string
  end
end
