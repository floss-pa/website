require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news = news(:one)
  end

  test "should get index" do
    get news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_news_url
    assert_response :success
  end

  test "should create news" do
    assert_difference('News.count') do
      post news_index_url, params: { news: { keywords: @news.keywords, language: @news.language, publish: @news.publish, published_at: @news.published_at, title: @news.title, user_id: @news.user_id } }
    end

    assert_redirected_to news_url(News.last)
  end

  test "should show news" do
    get news_url(@news)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_url(@news)
    assert_response :success
  end

  test "should update news" do
    patch news_url(@news), params: { news: { keywords: @news.keywords, language: @news.language, publish: @news.publish, published_at: @news.published_at, title: @news.title, user_id: @news.user_id } }
    assert_redirected_to news_url(@news)
  end

  test "should destroy news" do
    assert_difference('News.count', -1) do
      delete news_url(@news)
    end

    assert_redirected_to news_index_url
  end
end
