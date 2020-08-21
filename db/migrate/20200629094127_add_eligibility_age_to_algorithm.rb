class AddEligibilityAgeToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :age_limit, :integer
    add_column :algorithms, :age_limit_message, :string
  end
end
