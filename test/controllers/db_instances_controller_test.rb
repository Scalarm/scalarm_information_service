require 'test_helper'

class DbInstancesControllerTest < ActionController::TestCase
  add_test_get_list
  add_test_register_address
  add_test_register_address_unauthorized
  add_test_deregister_address
end
