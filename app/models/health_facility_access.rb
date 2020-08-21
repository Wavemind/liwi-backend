# Intermediary table between groups and version
class HealthFacilityAccess < ApplicationRecord
  before_create :archive_version

  belongs_to :health_facility
  belongs_to :version

  private

  # Callback before_create for archived a version
  def archive_version
    last_group_access = HealthFacilityAccess.find_by(health_facility_id: health_facility_id, end_date: nil)

    if last_group_access.present?
      last_group_access.end_date = Time.zone.now
      last_group_access.access = false
      last_group_access.save
    end
  end
end
