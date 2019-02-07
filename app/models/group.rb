# Manage groups
class Group < ApplicationRecord

  has_many :devices
  has_many :group_algorithm_versions
  has_many :algorithm_versions, through: :group_algorithm_version

  validates_presence_of :name

end
