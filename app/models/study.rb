class Study < ApplicationRecord
  belongs_to :algorithm, optional: true

  validates_presence_of :label
end
