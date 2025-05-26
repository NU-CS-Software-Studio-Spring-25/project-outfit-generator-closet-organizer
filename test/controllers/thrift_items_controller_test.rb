require "test_helper"

class ThriftItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get thrift_items_new_url
    assert_response :success
  end

  test "should get create" do
    get thrift_items_create_url
    assert_response :success
  end

  test "should get index" do
    get thrift_items_index_url
    assert_response :success
  end
end
