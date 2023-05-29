class ResourceRequestItem < ApplicationRecord
  belongs_to :resource_request
  belongs_to :resource
  has_many :assist_requests

  attribute :quantity, :integer, default: 0
  attribute :quantity_used, :integer, default: 0

  validates :quantity, numericality: { other_than: 0 }
end
