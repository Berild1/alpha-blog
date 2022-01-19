require "test_helper"

class ListArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    @article = Article.create(title: "Test article", description: "Test description", user_id: @user.id)
    @article2 = Article.create(title: "Test article 2", description: "Test description 2", user_id: @user.id)
  end

  test "should show articles listing" do
    get '/articles'
    assert_select "a[href=?]", article_path(@article), text: @article.title
    assert_select "a[href=?]", article_path(@article2), text: @article2.title
  end
end
