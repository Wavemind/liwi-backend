class AddReferenceTableMaleAndReferenceTableFemaleAndReferenceTableXAndReferenceTableYToNode < ActiveRecord::Migration[5.2]
  def change
    change_table :nodes do |t|
      t.string :reference_table_male
      t.string :reference_table_female

      t.references :reference_table_x
      t.references :reference_table_y
    end
  end
end
