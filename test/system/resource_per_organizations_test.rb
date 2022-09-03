require "application_system_test_case"

class ResourcePerOrganizationsTest < ApplicationSystemTestCase
  setup do
    @resource_per_organization = resource_per_organizations(:one)
  end

  test "visiting the index" do
    visit resource_per_organizations_url
    assert_selector "h1", text: "Resource Per Organizations"
  end

  test "creating a Resource per organization" do
    visit resource_per_organizations_url
    click_on "New Resource Per Organization"

    click_on "Create Resource per organization"

    assert_text "Resource per organization was successfully created"
    click_on "Back"
  end

  test "updating a Resource per organization" do
    visit resource_per_organizations_url
    click_on "Edit", match: :first

    click_on "Update Resource per organization"

    assert_text "Resource per organization was successfully updated"
    click_on "Back"
  end

  test "destroying a Resource per organization" do
    visit resource_per_organizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Resource per organization was successfully destroyed"
  end
end
