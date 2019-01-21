class AlgorithmVersion < ApplicationRecord

  belongs_to :algorithm
  belongs_to :user

  # has_many :medical_cases

  validates_presence_of :json
  validates_presence_of :version

  validates_uniqueness_of :version

end
