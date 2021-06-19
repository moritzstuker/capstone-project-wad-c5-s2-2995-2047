require 'test_helper'

class ContactRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_role = contact_roles(:one)
  end

  test "should get index" do
    get contact_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_role_url
    assert_response :success
  end

  test "should create contact_role" do
    assert_difference('ContactRole.count') do
      post contact_roles_url, params: { contact_role: { color: @contact_role.color, label: @contact_role.label } }
    end

    assert_redirected_to contact_role_url(ContactRole.last)
  end

  test "should show contact_role" do
    get contact_role_url(@contact_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_role_url(@contact_role)
    assert_response :success
  end

  test "should update contact_role" do
    patch contact_role_url(@contact_role), params: { contact_role: { color: @contact_role.color, label: @contact_role.label } }
    assert_redirected_to contact_role_url(@contact_role)
  end

  test "should destroy contact_role" do
    assert_difference('ContactRole.count', -1) do
      delete contact_role_url(@contact_role)
    end

    assert_redirected_to contact_roles_url
  end
end
