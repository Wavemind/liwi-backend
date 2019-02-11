# Version of an algorithm with its logic
class AlgorithmVersion < ApplicationRecord

  belongs_to :algorithm
  belongs_to :user

  has_many :enabled_diagnostics
  has_many :diagnostics, through: :enabled_diagnostics

  has_many :group_algorithm_versions
  has_many :groups, through: :group_algorithm_version

  validates_presence_of :version

  validates_uniqueness_of :version, scope: :algorithm

end
