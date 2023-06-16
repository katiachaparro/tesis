class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  def url
    params[:url]
  end

  def event
    Event.find_by_id(params[:event])
  end

  def message
    params[:message]
  end

  def self.ransackable_attributes(auth_object = nil)
    ['created_at']
  end
end
