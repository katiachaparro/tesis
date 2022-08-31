class ResourcePerOrganization < ApplicationRecord
  belongs_to :resource
  belongs_to :organization
end
