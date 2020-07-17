class UpdateGroup < ActiveRecord::Migration[5.2]
  def change
    rename_table :groups, :health_facilities
    add_column :health_facilities, :latitude, :decimal
    add_column :health_facilities, :longitude, :decimal

    rename_table :group_accesses, :health_facility_accesses

    rename_column :health_facility_accesses, :group_id, :health_facility_id
    rename_column :devices, :group_id, :health_facility_id
    rename_column :medical_staffs, :group_id, :health_facility_id
  end
end
