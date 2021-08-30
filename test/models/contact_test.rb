require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "should trigger default name (when name is not provided)" do
    first_role = ContactRole.first
    contact = Contact.new email: 'jack@test.dev', street: 'Some street', city: 'Lausanne', country: 'Switzerland', category: :person, role: first_role
    assert_equal(contact.name, 'John Doe')
  end

  test "should trigger name validation error (name too long)" do
    first_role = ContactRole.first
    contact = Contact.new name: Faker::Lorem.paragraph_by_chars(number: 101, supplemental: false), email: 'jack@test.dev', street: 'Some street', city: 'Lausanne', country: 'Switzerland', category: :person, role: first_role
    refute contact.valid?
  end

  test "should trigger email validation error (missing symbol)" do
    first_role = ContactRole.first
    contact = Contact.new name: 'Jack', email: 'jacktest.dev', street: 'Some street', city: 'Lausanne', country: 'Switzerland', category: :person, role: first_role
    refute contact.valid?
  end

  test "should trigger role validation error (missing role)" do
    first_role = ContactRole.first
    contact = Contact.new name: 'John', email: 'jack@test.dev', street: 'Some street', city: 'Lausanne', country: 'Switzerland', category: :person
    refute contact.valid?
  end
end
