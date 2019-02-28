# List every categories of questions
class Category < ApplicationRecord

  has_many :nodes

  validates_presence_of :name
  validates_presence_of :reference_prefix

  scope :question_categories, ->() { where(parent: 'Question') }
  scope :predefined_syndrome_categories, ->() { where(parent: 'PredefinedSyndrome') }

  translates :name

end
