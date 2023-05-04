class AssistRequest < ApplicationRecord
  belongs_to :resource_request_item
  belongs_to :organization
end
