require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest
  test "get signup form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "johndoe", email: "johndoe@example.com", password: "password", admin: false} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "johndoe", response.body
  end

  test "get signup form and reject invalid username" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: " ", email: "johndoe@example.com", password: "password", admin: false} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get signup form and reject invalid email" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "johndoe", email: " ", password: "password", admin: false} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get signup form and reject blank password" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "johndoe", email: "johndoe@example.com", password: nil, admin: false} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
