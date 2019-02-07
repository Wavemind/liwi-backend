# Intermediary table between groups and algorithm_version
class GroupAccess < ApplicationRecord
  after_create :archive_algorithm_version

  belongs_to :group
  belongs_to :algorithm_version

  private

  # Callback after_create for archive algoritm_version
  def archive_algorithm_version
    last_group_access = GroupAccess.find_by(group_id: self.group_id, end_date: nil)
    last_group_access.end_date = Time.zone.now
    last_group_access.access = false
    last_group_access.save
  end
end
