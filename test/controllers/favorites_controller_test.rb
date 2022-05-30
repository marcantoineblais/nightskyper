require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favorites_index_url
    assert_response :success
  end

  test "should get edit" do
    get favorites_edit_url
    assert_response :success
  end

  test "should get update" do
    get favorites_update_url
    assert_response :success
  end

  test "should get create" do
    get favorites_create_url
    assert_response :success
  end

  test "should get delete" do
    get favorites_delete_url
    assert_response :success
  end
end
