ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def authorize_request(request)
    user = Rails.application.secrets.service_login
    pw = Rails.application.secrets.service_password
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  def clear_authorization(request)
    request.env['HTTP_AUTHORIZATION'] = nil
  end

  def self.add_test_register_address
    define_method 'test_register_address' do
      authorize_request(request)
      post :register, address: 'some_address'
      assert_response :success
      assert_equal 'ok', JSON.parse(response.body)['status']

      get :list
      assert_response :success
      assert_includes JSON.parse(response.body), 'some_address'
    end
  end

  def self.add_test_register_address_unauthorized
    define_method 'test_register_address_unauthorized' do
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

  def self.add_test_deregister_address
    define_method 'test_deregister_address' do
      authorize_request(request)
      post :register, address: 'some'
      assert_response :success

      get :list
      assert_response :success
      assert_includes JSON.parse(response.body), 'some'

      post :deregister, address: 'some'
      assert_response :success

      get :list
      assert_response :success
      assert_not_includes JSON.parse(response.body), 'some'
    end
  end

  def self.add_test_get_list
    define_method 'test_get_list' do
      get :list
      assert_response :success
    end
  end

end
