class AddFieldsToHealthFacility < ActiveRecord::Migration[5.2]
  def change
    add_column :health_facilities, :country, :string
    add_column :health_facilities, :area, :string
  end
end
