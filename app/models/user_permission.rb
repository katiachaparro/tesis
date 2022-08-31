class UserPermission < ApplicationRecord
  belongs_to :organization
  belongs_to :role
end
