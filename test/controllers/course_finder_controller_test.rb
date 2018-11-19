require 'test_helper'

class CourseFinderControllerTest < ActionDispatch::IntegrationTest
  test "should get find_courses" do
    get course_finder_find_courses_url
    assert_response :success
  end

end
