# Answers give for a medical case
class Access < ApplicationRecord

  belongs_to :user
  belongs_to :role

end
