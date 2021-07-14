require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be valid" do
    user_1 = User.new login: 'user_1', name: 'Jack the Fixture', password: 'password', password_confirmation: 'password', email: 'jackexample.com'
    refute user_1.valid?
    user_2 = User.new login: 'user_2', name: 'Jake the Fixture', password: 'password', password_confirmation: 'password', email: 'jake@examplecom'
    refute user_2.valid?
    user_3 = User.new login: 'user_3', name: 'John the Fixture', password: 'password', password_confirmation: 'password', email: 'john@'
    refute user_3.valid?
    user_4 = User.new login: 'user_4', name: 'Jody the Fixture', password: 'password', password_confirmation: 'password', email: 'jody@example.com'
    assert user_4.valid?
  end

  test "login must be unique" do
    User.create! login: 'user', name: 'Jack the Fixture', password: 'password', password_confirmation: 'password', email: 'jack@example.com'
    user = User.new login: 'user', name: 'Jake the Fixture', password: 'password', password_confirmation: 'password', email: 'jake@example.com'
    refute user.valid?
  end

  test "email must be unique" do
    User.create! login: 'user_1', name: 'Jack the Fixture', password: 'password', password_confirmation: 'password', email: 'jack@example.com'
    user = User.new login: 'user_2', name: 'Jake the Fixture', password: 'password', password_confirmation: 'password', email: 'jack@example.com'
    refute user.valid?
  end

  test "sets correct defaults" do
    user = User.new login: 'user', name: 'Jake the Fixture', password: 'password', password_confirmation: 'password', email: 'jack@example.com'
    assert_equal user.default_fee, 300.00
    assert_equal user.avatar, 'default-avatar.png'
    assert_equal user.role, :intern
    assert_equal user.locale, 'en'
  end
end
