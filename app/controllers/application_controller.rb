class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_organization
  before_action  :set_breadcrumbs
  @per_page = 5

  private
  def current_organization
    @organization ||= Organization.find(params[:organization_id]) rescue nil if params[:organization_id].present?
  end
  def current_ability
    @current_ability ||= Ability.new(current_user, current_organization)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  def add_breadcrumbs(label, path = nil)
    @breadcrumbs << {
      label: label,
      path: path,
    }
  end
  def set_breadcrumbs
    @breadcrumbs = []
  end


end
