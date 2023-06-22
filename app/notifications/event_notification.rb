# To deliver this notification:
#
# EventNotification.with(post: @post).deliver_later(current_user)
# EventNotification.with(post: @post).deliver(current_user)

class EventNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "EventMailer", delay: 10.minutes, if: :unread?
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
