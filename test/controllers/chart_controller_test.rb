require 'test_helper'

class ChartControllerTest < ActionController::TestCase
  def test_register_address
    authorize_request(request)
    post :register, address: 'some_address'
    assert_response :success
    assert_equal 'ok', JSON.parse(response.body)['status']

    get :list
    assert_response :success
    assert_includes JSON.parse(response.body), 'some_address'
  end

  def test_register_address_unauthorized
    authorize_request(request)
    get :list
    assert_response :success
    assert_not_includes JSON.parse(response.body), 'some_address'

    clear_authorization(request)
    post :register, address: 'some_address'
    assert_response 401
    authorize_request(request)
  end

end
