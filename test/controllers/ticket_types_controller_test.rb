require 'test_helper'

class TicketTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_type = ticket_types(:one)
  end

  test "should get index" do
    get ticket_types_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_type_url
    assert_response :success
  end

  test "should create ticket_type" do
    assert_difference('TicketType.count') do
      post ticket_types_url, params: { ticket_type: { name: @ticket_type.name } }
    end

    assert_redirected_to ticket_type_url(TicketType.last)
  end

  test "should show ticket_type" do
    get ticket_type_url(@ticket_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_type_url(@ticket_type)
    assert_response :success
  end

  test "should update ticket_type" do
    patch ticket_type_url(@ticket_type), params: { ticket_type: { name: @ticket_type.name } }
    assert_redirected_to ticket_type_url(@ticket_type)
  end

  test "should destroy ticket_type" do
    assert_difference('TicketType.count', -1) do
      delete ticket_type_url(@ticket_type)
    end

    assert_redirected_to ticket_types_url
  end
end
