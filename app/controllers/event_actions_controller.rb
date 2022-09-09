class EventActionsController < ApplicationController
  before_action :setup_event

  def new
  end

  def destroy
  end

  private

  def setup_event
    @event = Event.new(event_actions: [EventAction.new])
  end
end