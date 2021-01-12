class Study < ApplicationRecord
  has_rich_text :description

  belongs_to :algorithm, optional: true

  validates_presence_of :label
end
