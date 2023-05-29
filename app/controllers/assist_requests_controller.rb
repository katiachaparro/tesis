class AssistRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :setup_header, only: [:new]
  before_action :setup_assist_request, except: [:new, :create_assist]

  def new; end

  def arrive_modal; end

  def state_modal; end

  def demobilize_modal; end

  def arrive
    @assist_request.register_arrive(arrive_params)
    redirect_to request.referrer, notice: "Se registró el arribo del recurso #{@assist_request.code}."
  end

  def demobilize
    @assist_request.demobilize(demobilized_params)
    redirect_to request.referrer, notice: "Se desmovilizó el recurso #{@assist_request.code}."
  end

  def change_state
    @assist_request.change_state(state_params)
    redirect_to request.referrer, notice: "Se actualizó el estado del recurso #{@assist_request.code}."
  end

  def create_assist
    params['assist_request_items_attributes'].each do |request_item_id, value|
      AssistRequest.create_assist_items(request_item_id, value['quantity'].to_i, current_user)
    end
  end


  private

  def setup_header
    @resource_request =  ResourceRequest.find_by_id(params[:resource_request_id])
  end

  def setup_assist_request
    @assist_request = AssistRequest.find_by_id(params[:assist_request_id])
  end

  def assist_request_params
    params.require(:resource_request).permit(resource_request_items_attributes: [:resource_id, :quantity])
  end

  def arrive_params
    params.require(:assist_request).permit(:code, :arrival_date, :vehicle_registration, :number_of_people, :status, :assigned_to, :comments)
  end

  def state_params
    params.require(:assist_request).permit(:status, :assigned_to, :comments)
  end

  def demobilized_params
    params.require(:assist_request).permit(:demobilizing_person, :demobilization_date, :comments)
  end
end
