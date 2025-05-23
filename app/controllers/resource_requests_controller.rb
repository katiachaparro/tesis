class ResourceRequestsController < ApplicationController
  load_and_authorize_resource
  include NotificationsHelper
  before_action :setup_event
  before_action :set_resource_request, only: [:cancel, :assist_modal]

  def new
    @resource_request = ResourceRequest.new
    @resource_request.resource_request_items.build
  end

  def cancel
    @resource_request.cancel_request(current_user)
    redirect_to event_path(@event), turbo_stream: true, notice: "La solicitud fue cancelada."
  end

  def assist_modal; end

  def create
    @resource_request = ResourceRequest.new(resource_request_params)
    @resource_request.event = @event
    @resource_request.user = current_user
    @resource_request.status = ResourceRequest.status.active
    @resource_request.code = "#{@event.name[0..2]}-#{@event.resource_request_ids.count + 1}"

    if @resource_request.save
      notify_new_resource_request(@event, @resource_request)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: 'Los recursos fueron solicitados exitosamente.' }
        format.turbo_stream { flash.now[:notice] = 'Los recursos fueron solicitados exitosamente.' }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('resource_request_form', partial: 'resource_requests/form', locals: { resource_request: @resource_request }),
                 status: :unprocessable_entity
        end
      end
    end
  end


  private

  def setup_event
    @event =  Event.find(params[:event_id])
  end

  def set_resource_request
    @resource_request = ResourceRequest.find_by_id(params['resource_request_id'])
  end

  def resource_request_params
    params.require(:resource_request).permit(:organization_id, :sender, resource_request_items_attributes: [:resource_id, :quantity])
  end
end
