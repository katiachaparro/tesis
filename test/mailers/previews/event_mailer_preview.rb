# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def event_notification
    notification = Notification.last
    EventMailer.with(notification: notification).event_notification
  end
end
