require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "creating a Event" do
    visit events_url
    click_on "New Event"

    fill_in "Affected area", with: @event.affected_area
    fill_in "Commander", with: @event.commander
    fill_in "Communication channels", with: @event.communication_channels
    fill_in "E location", with: @event.e_location
    fill_in "Egress route", with: @event.egress_route
    fill_in "Entry route", with: @event.entry_route
    fill_in "Event nature", with: @event.event_nature
    fill_in "Event start", with: @event.event_start
    fill_in "Form start", with: @event.form_start
    fill_in "Isolation", with: @event.isolation
    fill_in "Location", with: @event.location
    fill_in "Name", with: @event.name
    fill_in "Objectives", with: @event.objectives
    fill_in "Pc location", with: @event.pc_location
    fill_in "Security message", with: @event.security_message
    fill_in "Strategy", with: @event.strategy
    fill_in "Tactics", with: @event.tactics
    fill_in "Threats", with: @event.threats
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "updating a Event" do
    visit events_url
    click_on "Edit", match: :first

    fill_in "Affected area", with: @event.affected_area
    fill_in "Commander", with: @event.commander
    fill_in "Communication channels", with: @event.communication_channels
    fill_in "E location", with: @event.e_location
    fill_in "Egress route", with: @event.egress_route
    fill_in "Entry route", with: @event.entry_route
    fill_in "Event nature", with: @event.event_nature
    fill_in "Event start", with: @event.event_start
    fill_in "Form start", with: @event.form_start
    fill_in "Isolation", with: @event.isolation
    fill_in "Location", with: @event.location
    fill_in "Name", with: @event.name
    fill_in "Objectives", with: @event.objectives
    fill_in "Pc location", with: @event.pc_location
    fill_in "Security message", with: @event.security_message
    fill_in "Strategy", with: @event.strategy
    fill_in "Tactics", with: @event.tactics
    fill_in "Threats", with: @event.threats
    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "destroying a Event" do
    visit events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event was successfully destroyed"
  end
end
