class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :lockable, :trackable
  include DeviseTokenAuth::Concerns::User

  belongs_to :role

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :role

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_deactivated
    unless deactivated
      '<span class="badge badge-success">Active</span>'
    else
      '<span class="badge badge-danger">Inactive</span>'
    end
  end

  # Replace destroy by lock account
  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end

end
