require 'test_helper'

class SkillAssessmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get skill_assessment" do
    get skill_assessments_skill_assessment_url
    assert_response :success
  end

end
