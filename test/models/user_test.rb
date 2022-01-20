require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.save
    @user2 = User.create(username: "johndoe", email: "janedoe@example.com", password: "password", admin: true)
    assert_not @user2.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.username = "aa"
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    @user.save
    @user2 = User.new(username: "janedoe", email: "johndoe@example.com", password: "password", admin: true)
    assert_not @user2.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 106
    assert_not @user.valid?
  end

  test "email should be valid" do
    @user.email = "johndoe@example"
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = nil
    assert_not @user.valid?
  end

end