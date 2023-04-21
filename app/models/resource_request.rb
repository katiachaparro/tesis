class ResourceRequest < ApplicationRecord
  belongs_to :user
  belongs_to :resource
  belongs_to :event
  belongs_to :organization
end
