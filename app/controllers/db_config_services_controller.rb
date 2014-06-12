class DbConfigServicesController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbConfigService.where(address: address).blank?
      manager = DbConfigService.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as DbConfigService"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as DbConfigService"}, status: 500
    end
  end

  def list
    managers = DbConfigService.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    DbConfigService.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as DbConfigService"}
  end
end
