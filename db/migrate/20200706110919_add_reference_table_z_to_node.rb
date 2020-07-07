class AddReferenceTableZToNode < ActiveRecord::Migration[5.2]
  def change
    add_reference :nodes, :reference_table_z, index: true
    add_foreign_key :nodes, :nodes, column: :reference_table_z_id
  end
end
