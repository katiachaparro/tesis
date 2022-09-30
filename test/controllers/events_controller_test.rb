require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { affected_area: @event.affected_area, commander: @event.commander, communication_channels: @event.communication_channels, e_location: @event.e_location, egress_route: @event.egress_route, entry_route: @event.entry_route, event_nature: @event.event_nature, event_start: @event.event_start, form_start: @event.form_start, isolation: @event.isolation, location: @event.location, name: @event.name, objectives: @event.objectives, pc_location: @event.pc_location, security_message: @event.security_message, strategy: @event.strategy, tactics: @event.tactics, threats: @event.threats } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { affected_area: @event.affected_area, commander: @event.commander, communication_channels: @event.communication_channels, e_location: @event.e_location, egress_route: @event.egress_route, entry_route: @event.entry_route, event_nature: @event.event_nature, event_start: @event.event_start, form_start: @event.form_start, isolation: @event.isolation, location: @event.location, name: @event.name, objectives: @event.objectives, pc_location: @event.pc_location, security_message: @event.security_message, strategy: @event.strategy, tactics: @event.tactics, threats: @event.threats } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
