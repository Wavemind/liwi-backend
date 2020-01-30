# Can be gif or images and stock in server with carrierwave
class TechnicalFile < ApplicationRecord
  mount_uploader :file, TechnicalFileUploader
  belongs_to :user

  validates_presence_of :file

  after_create :activate

  def self.active
    TechnicalFile.all.where(active: true).first
  end

  def activate
    TechnicalFile.where(active: true).update(active: false)
    self.update(active: true)
  end
end
