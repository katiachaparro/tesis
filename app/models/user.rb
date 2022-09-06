class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_permissions
  has_many :organizations, through: :user_permissions

  def full_name
    "#{first_name} #{last_name}"
  end

  def super_admin?
    user_permissions.super_admin.any?
  end

  def user_permission
    user_permissions.first
  end
end
