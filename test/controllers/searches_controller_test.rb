require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get results" do
    get searches_results_url
    assert_response :success
  end

end
