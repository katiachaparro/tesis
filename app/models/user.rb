class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_permissions
  has_many :organizations, through: :user_permissions
  has_many :notifications, as: :recipient, dependent: :destroy

  scope :exclude_organization, -> (org_id) { includes(:user_permissions).where.not(user_permissions: {organization_id: org_id}) }
  scope :include_organization, -> (org_id) { includes(:user_permissions).where(user_permissions: {organization_id: org_id}) }

  def self.ransackable_attributes(auth_object = nil)
    %w[ci email first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[organizations user_permissions]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def super_admin?
    user_permissions.super_admin.any?
  end

  def admin?
    user_permissions.admin.any?
  end

  def user?
    user_permissions.user.any?
  end

  def organization_id
    organization_ids.first
  end

  def user_permission
    user_permissions.first
  end
end
