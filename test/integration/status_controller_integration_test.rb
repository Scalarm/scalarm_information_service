require 'test_helper'
require 'mocha'

class StatusControllerIntegrationTest < ActionDispatch::IntegrationTest

  # When there is no chart service instances
  # Then the status should be failure
  test 'Status should be failure if there is no Experiment Supervisor instance' do
    # Given
    running_services = [ExperimentManager, StorageManager, ChartService]
    running_services.each do |service_class|
      StatusController.any_instance.stubs(:collect_service_states).with(service_class).returns([{status: 'ok'}])
    end

    StatusController.any_instance.stubs(:collect_service_states).with(ExperimentSupervisor).returns([])

    # When
    get '/scalarm_status.json'

    # Then
    parsed_response = JSON.parse(response.body)

    assert_equal 'failed', parsed_response['status']

    # NOTICE: message parsing - delete it if the messages change
    assert_equal 'Every service should have at least one instance', parsed_response['message']
  end

  test 'Status should be ok if all services has ok status' do
    # Given
    running_services = [ExperimentManager, StorageManager, ChartService, ExperimentSupervisor]
    running_services.each do |service_class|
      StatusController.any_instance.stubs(:collect_service_states).with(service_class).returns([{status: 'ok'}])
    end

    # When
    get '/scalarm_status.json'

    # Then
    parsed_response = JSON.parse(response.body)

    assert_equal 'ok', parsed_response['status'], parsed_response
  end

  test 'Status should be warning if at least one service (Storage in this case) has warning status' do
    # Given
    running_services = [ExperimentManager, ChartService, ExperimentSupervisor]
    running_services.each do |service_class|
      StatusController.any_instance.stubs(:collect_service_states).with(service_class).returns([{status: 'ok'}])
    end

    StatusController.any_instance.stubs(:collect_service_states).with(StorageManager).returns([{status: 'warning'}])

    # When
    get '/scalarm_status.json'

    # Then
    parsed_response = JSON.parse(response.body)

    assert_equal 'warning', parsed_response['status'], parsed_response
  end

  test 'Status should be failed if at least one service (Storage in this case) has failed status' do
    # Given
    running_services = [ExperimentManager, ChartService, ExperimentSupervisor]
    running_services.each do |service_class|
      StatusController.any_instance.stubs(:collect_service_states).with(service_class).returns([{status: 'ok'}])
    end

    StatusController.any_instance.stubs(:collect_service_states).with(StorageManager).returns([{status: 'failed'}])

    # When
    get '/scalarm_status.json'

    # Then
    parsed_response = JSON.parse(response.body)

    assert_equal 'failed', parsed_response['status'], parsed_response
  end

end
