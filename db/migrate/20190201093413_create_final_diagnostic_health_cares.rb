class CreateFinalDiagnosticHealthCares < ActiveRecord::Migration[5.2]
  def change
    create_table :final_diagnostic_health_cares do |t|
      t.references :treatable, polymorphic: true, index: { name: :index_final_diagnostics_treatable_id }
      t.belongs_to :final_diagnostic

      t.timestamps
    end
  end
end
