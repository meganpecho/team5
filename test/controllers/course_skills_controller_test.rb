require 'test_helper'

class CourseSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_skill = course_skills(:one)
  end

  test "should get index" do
    get course_skills_url
    assert_response :success
  end

  test "should get new" do
    get new_course_skill_url
    assert_response :success
  end

  test "should create course_skill" do
    assert_difference('CourseSkill.count') do
      post course_skills_url, params: { course_skill: { course_id: @course_skill.course_id, skill_id: @course_skill.skill_id } }
    end

    assert_redirected_to course_skill_url(CourseSkill.last)
  end

  test "should show course_skill" do
    get course_skill_url(@course_skill)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_skill_url(@course_skill)
    assert_response :success
  end

  test "should update course_skill" do
    patch course_skill_url(@course_skill), params: { course_skill: { course_id: @course_skill.course_id, skill_id: @course_skill.skill_id } }
    assert_redirected_to course_skill_url(@course_skill)
  end

  test "should destroy course_skill" do
    assert_difference('CourseSkill.count', -1) do
      delete course_skill_url(@course_skill)
    end

    assert_redirected_to course_skills_url
  end
end
