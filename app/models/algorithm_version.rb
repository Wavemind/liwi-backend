# Version of an algorithm with its logic
class AlgorithmVersion < ApplicationRecord

  belongs_to :algorithm
  belongs_to :user

  has_many :diagnostics, dependent: :destroy

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  validates_presence_of :version

  validates_uniqueness_of :version, scope: :algorithm

  def display_label
    "#{algorithm.name} - #{version}"
  end

end
