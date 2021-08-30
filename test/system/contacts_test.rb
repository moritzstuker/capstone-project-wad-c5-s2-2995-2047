require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    visit(login_path)
    fill_in('session[login]', with: 'admin@test.dev')
    fill_in('session[password]', with: 'password')
    send_keys(:enter)
    sleep(4.seconds)
  end

  test 'add contact through form' do
    visit(new_contact_path)
    fill_in('contact[name]', with: 'Galactic Empire')
    fill_in('contact[activity]', with: 'Rebel harassment')
    fill_in('contact[email]', with: 'info@empire.com')
    fill_in('contact[street]', with: 'Palpatine Loop 1')
    fill_in('contact[city]', with: 'Kaas City')
    fill_in('contact[country]', with: 'Dromund Kaas')
    assert_difference('Contact.count') do
      send_keys(:enter)
      sleep(4.seconds)
    end
  end
end
