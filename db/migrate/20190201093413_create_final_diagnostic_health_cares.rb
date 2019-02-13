class CreateFinalDiagnosticHealthCares < ActiveRecord::Migration[5.2]
  def change
    create_table :final_diagnostic_health_cares do |t|
      t.belongs_to :node
      t.belongs_to :final_diagnostic

      t.timestamps
    end
  end
end
