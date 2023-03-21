# Can be gif or images and stock in server with carrierwave
class Media < ApplicationRecord
  include CopyCarrierwaveFile
  mount_uploader :url, MediaUploader

  belongs_to :fileable, polymorphic: true
  belongs_to :source, class_name: 'Media', optional: true

  validates_presence_of :label_translations
  validates_presence_of :url

  translates :label

  def duplicate_file(original_media)
    begin
      copy_carrierwave_file(original_media, self, :url)
      self.save!
    rescue
      self.url = "https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80"
      self.save!
    end
  end
end
