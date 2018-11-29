class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :lockable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
end
