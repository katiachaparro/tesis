class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_permissions
  has_many :organizations, through: :user_permissions
  has_many :roles, through: :user_permissions

  def super_admin?
    roles.where(name: 'Super-admin').any?
  end
end
