class UserPermission < ApplicationRecord
  extend Enumerize
  belongs_to :organization
  belongs_to :user
  enumerize :role, in: [:user, :admin, :super_admin], scope: :shallow
  accepts_nested_attributes_for :user, allow_destroy: false

  #validations
  validates :organization, :user, presence: true
  validates :organization, uniqueness: { scope: :user }

  # scopes
  scope :by_organization, -> (organization){ where(organization_id: organization&.id) }

  def self.ransackable_attributes(auth_object = nil)
    %w[organization_id role user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[organization user]
  end
end
