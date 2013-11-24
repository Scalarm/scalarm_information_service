require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get deregister" do
    get :deregister
    assert_response :success
  end

end
