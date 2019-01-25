class CreateDiagnosticHealthCares < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnostic_health_cares do |t|
      t.belongs_to :diagnostic
      t.belongs_to :health_care

      t.timestamps
    end
  end
end
