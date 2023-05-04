class DashboardController < ApplicationController
  def index
    @resource_requests = ResourceRequest.active.includes(:resource_request_items).order(created_at: :desc)
  end
end
