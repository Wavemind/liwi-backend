# Manage devices (tablet)
class Device < ApplicationRecord

  enum status: [:active, :inactive]

  has_many :activities
  has_many :users, through: :activities

  belongs_to :group, optional: true

  validates :mac_address, uniqueness: true, presence: true

  # @params nil
  # @return [String] contact of multiple column
  # Return label of a device
  def label
    "#{brand} #{model} - #{mac_address}"
  end

  # @params nil
  # @return [JSON] last activity of a user
  # Return last entry of current device with user attached
  def last_activity
    activities.last.as_json(include: [:user])
  end

end
