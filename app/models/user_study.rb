# Studies available for a user
class UserStudy < ApplicationRecord
  belongs_to :user
  belongs_to :study
end
