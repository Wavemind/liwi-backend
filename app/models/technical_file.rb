# Can be gif or images and stock in server with carrierwave
class TechnicalFile < ApplicationRecord
  mount_uploader :file, TechnicalFileUploader

  scope :active, -> { where(active: true).first }

  validates_presence_of :file

  after_create :activate

  def activate
    TechnicalFile.where(active: true).update(active: false)
    self.update(active: true)
  end
end
