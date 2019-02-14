# Container of many versions of algorithms
class Algorithm < ApplicationRecord

  has_many :algorithm_versions
  has_many :nodes, dependent: :destroy
  has_many :questions, -> { where type: 'Question' }, through: :available_nodes, source: :node
  has_many :managements, -> { where type: 'Management' }, through: :available_nodes, source: :node
  has_many :treatments, -> { where type: 'Treatment' }, through: :available_nodes, source: :node
  has_many :predefined_syndromes, -> { where type: 'PredefinedSyndrome' }, through: :available_nodes, source: :node

  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name

end
