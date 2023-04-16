class ResourceRequest < ApplicationRecord
  extend Enumerize
  belongs_to :user
  belongs_to :event
  belongs_to :organization, optional: true
  has_many :resource_request_items

  accepts_nested_attributes_for :resource_request_items,
                                reject_if: :all_blank, allow_destroy: true

  enumerize :status, in: [:active, :canceled, :complete, :demobilized], scope: :shallow
end
