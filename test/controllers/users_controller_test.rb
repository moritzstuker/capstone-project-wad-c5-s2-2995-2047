require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:registered)
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: {
          login: 'new@epfl.ch',
          name: 'Jack the Fixture',
          password: 'password',
          password_confirmation: 'password',
          email: 'jack@example.com'
        }
      }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show dashboard" do
    log_in_as(@user)
    get user_url(@user)
    assert_redirected_to dashboard_url
  end

  test "should get edit" do
    log_in_as users(:admin)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should destroy user" do
    log_in_as users(:admin)

    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
