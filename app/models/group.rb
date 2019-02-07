# Manage groups
class Group < ApplicationRecord

  has_many :devices
  has_many :group_accesses
  has_many :algorithm_versions, through: :group_accesses

  validates_presence_of :name

end
