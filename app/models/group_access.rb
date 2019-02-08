# Intermediary table between groups and algorithm_version
class GroupAccess < ApplicationRecord
  before_create :archive_algorithm_version

  belongs_to :group
  belongs_to :algorithm_version

  private

  # Callback before_create for archived an algorithm_version
  def archive_algorithm_version
    last_group_access = GroupAccess.find_by(group_id: self.group_id, end_date: nil)

    if last_group_access.present?
      last_group_access.end_date = Time.zone.now
      last_group_access.access = false
      last_group_access.save
    end
  end
end
