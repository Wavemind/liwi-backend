# Manage groups
class Group < ApplicationRecord

  has_many :devices
  has_many :group_accesses
  has_many :versions, through: :group_accesses

  enum architecture: [:standalone, :client_server]

  validates_presence_of :name
  validates_presence_of :architecture
  validates_presence_of :pin_code

  before_validation :validate_code_pin
  after_validation :validate_ips


  private

  def validate_code_pin
    self.errors.add(:code_pin, I18n.t('groups.errors.code_pin_unvalid')) if pin_code.match('^[0-9]{4}$').nil?
  end

  def validate_ips
    if self.client_server?
      self.errors.add(:local_data_ip, I18n.t('groups.errors.ip_invalid')) if local_data_ip.present? && local_data_ip.match('^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$').nil?
    elsif self.standalone?
      self.errors.add(:main_data_ip, I18n.t('groups.errors.ip_invalid')) if main_data_ip.present? && main_data_ip.match('^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$').nil?
    end
  end
end
