# Intermediary table between user and group
class GroupUser < ApplicationRecord

  belongs_to :group
  belongs_to :user

end
