class EventMailer < ApplicationMailer
  def event_notification
    @notification = params[:record]
    @user = @notification.recipient
    @event = @notification.event
    mail(to: recipient(@user), subject: @event.name)
  end
end
