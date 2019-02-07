# Intermediary table between groups and algorithm_version
class GroupAlgorithmVersion < ApplicationRecord

  belongs_to :group
  belongs_to :algorithm_version

end
