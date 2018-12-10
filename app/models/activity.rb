class Activity < ApplicationRecord

  belongs_to :device
  belongs_to :user, optional: true

  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :timezone
  validates_presence_of :version

  accepts_nested_attributes_for :device, reject_if: :all_blank, allow_destroy: true

end
