class DashboardController < ApplicationController
  def index
    org_id = current_user.organization_id
    @show_organizations = params[:show_organizations].present?
    @events = Event.mappable_events
    @organizations = Organization.mappable_organizations if @show_organizations
    @scheduled_events = Event.uninitialized_events.by_organization(org_id)
    @resource_requests = ResourceRequest.active
                                        .where(organization_id: [nil, org_id])
                                        .includes(:resource_request_items).order(created_at: :desc)
  end
end
