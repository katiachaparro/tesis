class NotificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = current_user.notifications.ransack(params[:q] || {})
    @q.sorts = ['created_at desc'] if @q.sorts.empty?
    @notifications = @q.result.page(params[:page]).per(@per_page)
  end

  def show
    @notification.mark_as_read!
    redirect_to @notification.url || event_path(@notification.params[:event])
  end

  def mark_as_read
    current_user.notifications.mark_as_read!
    redirect_to root_path
  end
end