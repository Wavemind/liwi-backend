class CreateUserStudies < ActiveRecord::Migration[6.0]
  def change
    create_table :user_studies do |t|
      t.belongs_to :user
      t.belongs_to :study
    end

    add_reference :health_facilities, :study, column: :study_id, foreign_key: true
  end
end
