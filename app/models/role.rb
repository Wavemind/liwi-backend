# Manage role
class Role < ApplicationRecord

  validates_presence_of :name

  enum stage: [:registration, :triage, :test, :consultation, :health_cares]

  has_many :accesses

end
