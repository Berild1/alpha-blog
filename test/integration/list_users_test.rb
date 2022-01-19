require "test_helper"

class ListUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    @user2 = User.create(username: "janedoe", email: "janedoe@example.com", password: "password", admin: false)
  end

  test "should show users listing" do
    get '/users'
    assert_select "a[href=?]", user_path(@user), text: @user.username
    assert_select "a[href=?]", user_path(@user2), text: @user2.username
  end
end
