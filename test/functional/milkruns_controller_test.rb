require 'test_helper'

class MilkrunsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
