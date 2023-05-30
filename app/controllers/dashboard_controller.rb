class DashboardController < ApplicationController
  def index
    org_id = current_user.organization_id
    @resource_requests = ResourceRequest.active
                                        .where(organization_id: [nil, org_id])
                                        .includes(:resource_request_items).order(created_at: :desc)
  end
end
