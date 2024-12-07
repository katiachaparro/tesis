class ResourceRequest < ApplicationRecord
  extend Enumerize
  belongs_to :user
  belongs_to :event
  belongs_to :organization, optional: true
  has_many :resource_request_items
  has_many :assist_requests, through: :resource_request_items
  after_create :create_event_action

  accepts_nested_attributes_for :resource_request_items,
                                reject_if: :all_blank, allow_destroy: true

  scope :requests_to_demobilize, -> (event_id) { where(event_id: event_id, status: ResourceRequest.status.active) }

  enumerize :status, in: [:active, :canceled, :completed, :demobilized], scope: :shallow

  def active?
    status == ResourceRequest.status.active
  end

  def cancelable?(current_user)
    return false unless active?

    org_id = current_user.organization_id
    organization_id == org_id || user.organization_id == org_id || event.organization_id == org_id
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

  def cancel_request(current_user)
    update(status: ResourceRequest.status.canceled)
    cancel_event_action(current_user)
  end

  private

  def create_event_action
    description = "El usuario #{user.full_name} creó la solicitud de recursos #{code}"
    description += " para la Organización: #{organization.name}" if organization.present?
    EventAction.create(
      description: description,
      date: Time.zone.now,
      event: event
    )
  end

  def cancel_event_action(current_user)
    description = "El usuario #{current_user.full_name} canceló la solicitud de recursos #{code}"
    description += " para la Organización: #{organization.name}" if organization.present?
    EventAction.create(
      description: description,
      date: Time.zone.now,
      event: event
    )
  end
end
