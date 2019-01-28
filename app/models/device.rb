# Manage devices (tablet)
class Device < ApplicationRecord

  enum status: [:active, :inactive]

  has_many :activities
  has_many :users, through: :activities

  validates_presence_of :mac_address
  validates_presence_of :name
  validates_presence_of :model
  validates_presence_of :brand
  validates_presence_of :os
  validates_presence_of :os_version
  validates_presence_of :status

  # @params nil
  # @return [JSON] last activity of a user
  # Return last entry of current device with user attached
  def last_activity
    activities.last.as_json(include: [:user])
  end

end
