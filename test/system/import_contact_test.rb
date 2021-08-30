require "application_system_test_case"

class ImportContactTest < ApplicationSystemTestCase
  setup do
    visit(login_path)
    fill_in('session[login]', with: 'admin@test.dev')
    fill_in('session[password]', with: 'password')
    send_keys(:enter)
    sleep(4.seconds)
  end

  test 'search importable contacts with no result' do
    visit(contacts_import_path)
    fill_in('search', with: "#{ 'a' * 100 }")
    send_keys(:enter)
    sleep(4.seconds)
    assert page.has_content?('Found 0 result')
  end

  test 'import contact' do
    visit(contacts_import_path)
    fill_in('search', with: 'Hans')
    send_keys(:enter)
    sleep(4.seconds)
    assert_difference('Contact.count') do
      first('.container ul .box').click_button('Import')
    end
  end
end
