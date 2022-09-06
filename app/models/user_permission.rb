class UserPermission < ApplicationRecord
  extend Enumerize
  belongs_to :organization
  belongs_to :user

  validates :organization, uniqueness: { scope: :user }

  enumerize :role, in: [:user, :admin, :super_admin], scope: :shallow
  scope :by_organization, -> (organization){ where(organization_id: organization&.id) }
end
