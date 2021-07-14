require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:registered)
  end

  test "should log in" do
    get user_url(@user)
    assert_redirected_to login_url

    log_in_as(@user)
    get user_url(@user)
    assert_redirected_to dashboard_url
  end

  [
    #'root_url',
    'account_url',
    'contacts_url',
    'contact_url(1)',
    'edit_contact_url(1)',
    'contacts_import_url',
    'new_contact_url',
    'dashboard_url',
    'deadlines_url',
    'edit_deadline_url(1)',
    'new_deadline_url',
    #'login_url',
    'projects_url',
    'project_url(1)',
    'edit_project_url(1)',
    'new_project_url',
    'search_url',
    #'new_session_url',
    #'signup_url',
    'users_url',
    'user_url(1)',
    'edit_user_url(1)',
    #'new_user_url',
  ].each do |url|
    test "should not have access to #{url}" do
      get eval(url) # Yes, eval() is extremely dangerous and may create a security hole. But here 1) there's no user input and 2) it's only run in a test env, so the risk is nil.
      assert_redirected_to login_url
    end
  end

  [
    #'root_url',
    #'account_url',
    #'contacts_url',
    'contact_url(1)',
    'edit_contact_url(1)',
    #'contacts_import_url',
    #'new_contact_url',
    #'dashboard_url',
    #'deadlines_url',
    'edit_deadline_url(1)',
    #'new_deadline_url',
    #'login_url',
    #'projects_url',
    'project_url(1)',
    'edit_project_url(1)',
    #'new_project_url',
    #'search_url',
    #'new_session_url',
    #'signup_url',
    'users_url',
    'user_url(1)',
    'edit_user_url(1)',
    #'new_user_url',
  ].each do |url|
    test "should not have access to restricted url #{url}" do
      get eval(url)
      assert_response :redirect
    end
  end
end
