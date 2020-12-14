class AddMinimumAgeToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :minimum_age, :integer
  end
end
