# Manage user
class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :recoverable, :lockable, :trackable, :registerable, :timeoutable
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
      if !password.match(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-_§]).{8,}$/)
        errors.add :password, "Password complexity requirement not met"
      end
    end
  end
end
