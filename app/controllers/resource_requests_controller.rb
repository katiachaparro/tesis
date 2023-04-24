class ResourceRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :setup_event

  def new
    @resource_request = ResourceRequest.new
    @resource_request.resource_request_items.build
  end

  def edit; end

  def create
    @resource_request = ResourceRequest.new(resource_request_params)
    @resource_request.event = @event
    @resource_request.user = current_user
    @resource_request.status = ResourceRequest.status.active

    if @resource_request.save
      # TODO: notify all organizations
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "Los recursos fueron solicitados exitosamente." }
        format.turbo_stream { flash.now[:notice] = "Los recursos fueron solicitados exitosamente." }
      end
    else
      render :new
    end
  end


  private

  def setup_event
    @event =  Event.find(params[:event_id])
  end

  def resource_request_params
    params.require(:resource_request).permit(resource_request_items_attributes: [:resource_id, :quantity])
  end
end
