require "test_helper"

class ResourcePerOrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_per_organization = resource_per_organizations(:one)
  end

  test "should get index" do
    get resource_per_organizations_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_per_organization_url
    assert_response :success
  end

  test "should create resource_per_organization" do
    assert_difference('ResourcePerOrganization.count') do
      post resource_per_organizations_url, params: { resource_per_organization: {  } }
    end

    assert_redirected_to resource_per_organization_url(ResourcePerOrganization.last)
  end

  test "should show resource_per_organization" do
    get resource_per_organization_url(@resource_per_organization)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_per_organization_url(@resource_per_organization)
    assert_response :success
  end

  test "should update resource_per_organization" do
    patch resource_per_organization_url(@resource_per_organization), params: { resource_per_organization: {  } }
    assert_redirected_to resource_per_organization_url(@resource_per_organization)
  end

  test "should destroy resource_per_organization" do
    assert_difference('ResourcePerOrganization.count', -1) do
      delete resource_per_organization_url(@resource_per_organization)
    end

    assert_redirected_to resource_per_organizations_url
  end
end
