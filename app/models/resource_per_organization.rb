class ResourcePerOrganization < ApplicationRecord
  belongs_to :resource
  belongs_to :organization

  #validations
  validates :organization, :resource, presence: true
  validates :organization, uniqueness: { scope: :resource }

  #scopes
  scope :by_organization, -> (organization){ where(organization_id: organization&.id) }
end
