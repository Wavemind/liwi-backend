# Can be gif or images and stock in server with carrierwave
class Media < ApplicationRecord
  include CopyCarrierwaveFile
  mount_uploader :url, MediaUploader

  belongs_to :fileable, polymorphic: true

  validates_presence_of :label_en
  validates_presence_of :url

  translates :label

  def duplicate_file(original_media)
    copy_carrierwave_file(original_media, self, :content_file)
    self.save!
  end

end
