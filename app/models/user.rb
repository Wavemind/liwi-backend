# Manage user
class User < ApplicationRecord
  devise :invitable, :recoverable, :lockable, :trackable, :registerable, :timeoutable

  devise :two_factor_authenticatable, :two_factor_backupable,
         otp_backup_code_length: 10, otp_number_of_backup_codes: 10,
         :otp_secret_encryption_key => ENV['OTP_SECRET_KEY']

  include DeviseTokenAuth::Concerns::User

  enum role: [:admin, :clinician, :deployment_manager, :medal_r_user]

  has_many :activities
  has_many :devices, through: :activities
  has_many :accesses
  has_many :roles, through: :accesses
  has_many :user_studies
  has_many :studies, through: :user_studies

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :role

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates_confirmation_of :password
  validate :password_complexity

  # Ensure that backup codes can be serialized
  serialize :otp_backup_codes, JSON

  attr_accessor :otp_plain_backup_codes

  def self.get_current
    Thread.current[:user]
  end

  def self.get_current_ip
    Thread.current[:ip]
  end

  def self.set_current(user, ip)
    Thread.current[:user] = user
    Thread.current[:ip] = ip
  end

  # Override devise authentication verification with deactivated method
  def active_for_authentication?
    super && !deactivated
  end

  # Replace destroy by lock account
  # Override destroy method and lock the account instead
  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  # @return [String] add html badge
  # Display status of user's account
  def display_deactivated
    unless deactivated
      '<span class="badge badge-success">Active</span>'
    else
      '<span class="badge badge-danger">Inactive</span>'
    end
  end

  # @return [String] contact first_name and last_name
  # Display full name
  def full_name
    "#{first_name} #{last_name}"
  end

  def password_complexity
    if password.present?
      if !password.match(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/)
        errors.add :password, "Password complexity requirement not met"
      end
    end
  end

  ######################################################################
  ############################# 2FA ####################################
  ######################################################################

  # Generate an OTP secret it it does not already exist
  def generate_two_factor_secret_if_missing!
    return unless otp_secret.nil?
    update!(otp_secret: User.generate_otp_secret)
  end

  # Ensure that the user is prompted for their OTP when they login
  def enable_two_factor!
    update!(otp_required_for_login: true)
  end

  # Disable the use of OTP-based two-factor.
  def disable_two_factor!
    update!(
        otp_required_for_login: false,
        otp_secret: nil,
        otp_backup_codes: nil)
  end

  # URI for OTP two-factor QR code
  def two_factor_qr_code_uri
    issuer = ENV['OTP_2FA_ISSUER_NAME']
    label = email

    otp_provisioning_uri(label, issuer: issuer)
  end

  # Determine if backup codes have been generated
  def two_factor_backup_codes_generated?
    otp_backup_codes.present?
  end
end
