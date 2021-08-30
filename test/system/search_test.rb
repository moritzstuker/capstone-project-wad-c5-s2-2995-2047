require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  setup do
    visit(login_path)
    fill_in('session[login]', with: 'admin@test.dev')
    fill_in('session[password]', with: 'password')
    send_keys(:enter)
    sleep(4.seconds)
  end

  test 'search projects with no result' do
    fill_in('query', with: 'non existing project')
    send_keys(:enter)
    sleep(4.seconds)
    assert page.has_content?('No such case found')
  end

  test 'search projects with result' do
    fill_in('query', with: 'First project')
    send_keys(:enter)
    sleep(4.seconds)
    assert page.has_content?('First project')
  end

  test 'search contacts with no result' do
    visit contacts_path(query: 'non existing contact')
    sleep(4.seconds)
    assert page.has_content?('No such contact found')
  end

  test 'search contacts with result' do
    visit contacts_path(query: 'John Doe')
    sleep(4.seconds)
    assert page.has_content?('John Doe')
  end

  test 'search deadlines with no result' do
    visit deadlines_path(query: 'non existing deadline')
    sleep(4.seconds)
    assert page.has_content?('No such deadline found')
  end

  test 'search deadlines with result' do
    visit deadlines_path(query: 'Brand impactful paradigms')
    sleep(4.seconds)
    assert page.has_content?('Brand impactful paradigms')
  end
end
