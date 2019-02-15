# Can be gif or images and stock in server with carrierwave
class Media < ApplicationRecord
  mount_uploader :url, MediaUploader

  belongs_to :fileable, polymorphic: true

  validates_presence_of :label
  validates_presence_of :url
end
