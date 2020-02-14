# Log all connection of tablet
class Activity < ApplicationRecord

  belongs_to :device
  belongs_to :user, optional: true

  # Latitude and longitude is not required. If value is 0, user doesn't accept to send GPS information
  validates_presence_of :timezone
  validates_presence_of :version

  accepts_nested_attributes_for :device, reject_if: :all_blank, allow_destroy: true

end
