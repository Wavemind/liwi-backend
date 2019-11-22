# Manage role
class Role < ApplicationRecord

  validates_presence_of :name

  enum stage: [:registration, :triage, :test, :consultation]

  has_many :user_roles

end
