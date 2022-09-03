class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_organization

  private
  def current_organization
    @organization ||= Organization.find(params[:organization_id]) rescue nil if params[:organization_id].present?
  end
  def current_ability
    @current_ability ||= Ability.new(current_user, current_organization)
  end
end
