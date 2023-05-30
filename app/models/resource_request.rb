class ResourceRequest < ApplicationRecord
  extend Enumerize
  belongs_to :user
  belongs_to :event
  belongs_to :organization, optional: true
  has_many :resource_request_items
  has_many :assist_requests, through: :resource_request_items

  accepts_nested_attributes_for :resource_request_items,
                                reject_if: :all_blank, allow_destroy: true

  enumerize :status, in: [:active, :canceled, :completed, :demobilized], scope: :shallow

  def active?
    status == ResourceRequest.status.active
  end

  def cancelable?(current_user)
    org_id = current_user.organization_id
    active? && assist_request_ids.empty? && user.organization_id == org_id
  end

  def user_can_assist? (user)
    org_id = user.organization_id
    organization.nil? || organization_id == org_id
  end

  def check_request_complete
    incomplete = resource_request_items.where('quantity > quantity_used').any?
    return if incomplete

    update(status: ResourceRequest.status.completed)
  end
end
