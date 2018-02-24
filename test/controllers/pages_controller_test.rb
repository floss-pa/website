require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should get new" do
    get new_page_url
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post pages_url, params: { page: { carousel: @page.carousel, content: @page.content, in_menu: @page.in_menu, is_home: @page.is_home, is_publish: @page.is_publish, language: @page.language, title: @page.title, user_id: @page.user_id } }
    end

    assert_redirected_to page_url(Page.last)
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_url(@page)
    assert_response :success
  end

  test "should update page" do
    patch page_url(@page), params: { page: { carousel: @page.carousel, content: @page.content, in_menu: @page.in_menu, is_home: @page.is_home, is_publish: @page.is_publish, language: @page.language, title: @page.title, user_id: @page.user_id } }
    assert_redirected_to page_url(@page)
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
