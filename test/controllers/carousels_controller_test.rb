require 'test_helper'

class CarouselsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carousel = carousels(:one)
  end

  test "should get index" do
    get carousels_url
    assert_response :success
  end

  test "should get new" do
    get new_carousel_url
    assert_response :success
  end

  test "should create carousel" do
    assert_difference('Carousel.count') do
      post carousels_url, params: { carousel: { active: @carousel.active, header: @carousel.header, image: @carousel.image, link: @carousel.link, page_id: @carousel.page_id, sentence: @carousel.sentence, user_id: @carousel.user_id } }
    end

    assert_redirected_to carousel_url(Carousel.last)
  end

  test "should show carousel" do
    get carousel_url(@carousel)
    assert_response :success
  end

  test "should get edit" do
    get edit_carousel_url(@carousel)
    assert_response :success
  end

  test "should update carousel" do
    patch carousel_url(@carousel), params: { carousel: { active: @carousel.active, header: @carousel.header, image: @carousel.image, link: @carousel.link, page_id: @carousel.page_id, sentence: @carousel.sentence, user_id: @carousel.user_id } }
    assert_redirected_to carousel_url(@carousel)
  end

  test "should destroy carousel" do
    assert_difference('Carousel.count', -1) do
      delete carousel_url(@carousel)
    end

    assert_redirected_to carousels_url
  end
end
