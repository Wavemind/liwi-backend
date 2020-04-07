# Manage groups
class Group < ApplicationRecord

  has_many :devices
  has_many :group_accesses
  has_many :versions, through: :group_accesses
  has_many :medical_staffs

  enum architecture: [:standalone, :client_server]

  validates_presence_of :name
  validates_presence_of :architecture
  validates_presence_of :pin_code

  after_validation :validate_code_pin
  after_validation :validate_ips

  after_create :generate_token

  accepts_nested_attributes_for :medical_staffs, reject_if: :all_blank, allow_destroy: true

  private

  # Ensure the code pin is a 4 digits
  def validate_code_pin
    self.errors.add(:pin_code, I18n.t('groups.errors.code_pin_unvalid')) if pin_code.match('^[0-9]{4}$').nil?
  end

  # Ensure the IPs are in a good format
  def validate_ips
    if client_server?
      self.errors.add(:local_data_ip, I18n.t('groups.errors.ip_invalid')) if local_data_ip.present? && local_data_ip.match('^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$').nil?
    elsif standalone?
      self.errors.add(:main_data_ip, I18n.t('groups.errors.ip_invalid')) if main_data_ip.present? && main_data_ip.match('^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$').nil?
    end
  end

  def generate_token
    key = SecureRandom.random_bytes(32)
    crypt = ActiveSupport::MessageEncryptor.new(key)
    self.token = crypt.encrypt_and_sign(pin_code)
    self.save
  end
end
