require 'test_helper'

class PrerequisitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prerequisite = prerequisites(:one)
  end

  test "should get index" do
    get prerequisites_url
    assert_response :success
  end

  test "should get new" do
    get new_prerequisite_url
    assert_response :success
  end

  test "should create prerequisite" do
    assert_difference('Prerequisite.count') do
      post prerequisites_url, params: { prerequisite: { course_id: @prerequisite.course_id, prerequisite_id: @prerequisite.prerequisite_id } }
    end

    assert_redirected_to prerequisite_url(Prerequisite.last)
  end

  test "should show prerequisite" do
    get prerequisite_url(@prerequisite)
    assert_response :success
  end

  test "should get edit" do
    get edit_prerequisite_url(@prerequisite)
    assert_response :success
  end

  test "should update prerequisite" do
    patch prerequisite_url(@prerequisite), params: { prerequisite: { course_id: @prerequisite.course_id, prerequisite_id: @prerequisite.prerequisite_id } }
    assert_redirected_to prerequisite_url(@prerequisite)
  end

  test "should destroy prerequisite" do
    assert_difference('Prerequisite.count', -1) do
      delete prerequisite_url(@prerequisite)
    end

    assert_redirected_to prerequisites_url
  end
end
