class ResourceRequestItem < ApplicationRecord
  belongs_to :resource_request
  belongs_to :resource
  has_many :assist_requests

  delegate :event, :to => :resource_request, :allow_nil => true
  delegate :user, :to => :resource_request, :allow_nil => true

  attribute :quantity, :integer, default: 0
  attribute :quantity_used, :integer, default: 0

  validates :resource, :quantity, presence: true
  validates :quantity, numericality: { other_than: 0 }
end
