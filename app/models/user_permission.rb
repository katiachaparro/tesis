class UserPermission < ApplicationRecord
  belongs_to :organization
  belongs_to :role
  belongs_to :user

  scope :by_organization, -> (organization){ where(organization_id: organization&.id) }
end
