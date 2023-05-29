class AssistRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :setup_header, only: [:new]
  before_action :setup_assist_request, except: [:new, :create_assist]

  def new; end

  def arrive_modal; end

  def demobilize_modal; end

  def arrive; end

  def demobilize; end

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
end
