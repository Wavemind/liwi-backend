# Version of an algorithm with its logic
class AlgorithmVersion < ApplicationRecord

  belongs_to :algorithm
  belongs_to :user

  has_many :enabled_diagnostics
  has_many :diagnostics, through: :enabled_diagnostics

  has_many :group_accesses
  has_many :groups, through: :group_accesses

  validates_presence_of :name

  validates_uniqueness_of :name, scope: :algorithm

  def display_label
    "#{algorithm.name} - #{name}"
  end

end
