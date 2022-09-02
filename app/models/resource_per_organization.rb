class ResourcePerOrganization < ApplicationRecord
  belongs_to :resource
  belongs_to :organization

  validates :resource, uniqueness: { scope: :organization }
end
