class AddNodeIdToDiagnostic < ActiveRecord::Migration[5.2]
  def change
    add_reference :diagnostics, :node, column: :node_id
  end
end
