# Can be gif or images and stock in server with carrierwave
class TechnicalFile < ApplicationRecord
  mount_uploader :file, TechnicalFileUploader

  validates_presence_of :file

  before_create :upload_file
  after_create :activate

  def activate
    TechnicalFile.where(active: true).update(active: false)

    self.update(active: true)
  end

  def upload_file

  end
end
