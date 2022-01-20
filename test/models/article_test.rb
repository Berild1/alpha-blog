require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    @article = Article.new(title: "Test article title", description: "Test article description", user_id: @user.id)
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    assert_not @article.valid?
  end

  test "title should not be too long" do
    @article.title = "a" * 101
    assert_not @article.valid?
  end

  test "title should not be too short" do
    @article.title = "aa"
    assert_not @article.valid?
  end

  test "description should be present" do
    @article.description = " "
    assert_not @article.valid?
  end

  test "description should not be too long" do
    @article.description = "a" * 301
    assert_not @article.valid?
  end

  test "description should not be too short" do
    @article.description = "aa"
    assert_not @article.valid?
  end

end