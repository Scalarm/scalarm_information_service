require 'test_helper'

##
# Tests alias data_explorers for chart_services
class DataExplorerMigrationTest < ActionDispatch::IntegrationTest

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_get_empty_chart_services
    get '/chart_services'

    assert_response :success
    assert_equal [], JSON.parse(response.body)
  end

  def test_get_empty_data_explorers
    get '/data_explorers'

    assert_response :success
    assert_equal [], JSON.parse(response.body)
  end

  test 'register in chart_services and deregister in data_explorers' do
    address = 'some_address:111'

    user = Rails.application.secrets.service_login
    pw = Rails.application.secrets.service_password

    ## register

    post '/chart_services', {address: address}, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)}
    assert_response :success

    ## check presence in both variants

    get '/chart_services'
    assert_response :success
    assert_equal [address], JSON.parse(response.body)

    get '/data_explorers'
    assert_response :success
    assert_equal [address], JSON.parse(response.body)

    ## deregister

    delete '/data_explorers', {address: address}, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)}
    assert_response :success

    ## check if empty in both

    get '/chart_services'
    assert_response :success
    assert_equal [], JSON.parse(response.body)

    get '/data_explorers'
    assert_response :success
    assert_equal [], JSON.parse(response.body)
  end

  test 'register in data_explorers and deregister in chart_services' do
    address = 'some_address:111'

    user = Rails.application.secrets.service_login
    pw = Rails.application.secrets.service_password

    ## register

    post '/data_explorers', {address: address}, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)}
    assert_response :success

    ## check presence in both variants

    get '/chart_services'
    assert_response :success
    assert_equal [address], JSON.parse(response.body)

    get '/data_explorers'
    assert_response :success
    assert_equal [address], JSON.parse(response.body)

    ## deregister

    delete '/chart_services', {address: address}, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)}
    assert_response :success

    ## check if empty in both

    get '/chart_services'
    assert_response :success
    assert_equal [], JSON.parse(response.body)

    get '/data_explorers'
    assert_response :success
    assert_equal [], JSON.parse(response.body)
  end
end