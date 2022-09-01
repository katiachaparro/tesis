class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private
  def current_organization
    @organization ||= Organization.find(url_decrypt(params[:organization_id])) rescue nil
  end
  def current_ability
    @current_ability ||= Ability.new(current_user, current_organization)
  end
end
