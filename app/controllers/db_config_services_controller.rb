class DbConfigServicesController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbConfigService.where(address: address).blank?
      manager = DbConfigService.new(address: address)
      manager.save

      render inline: "Success: '#{address}' registered as DB config service"
    else

      render inline: "Failure: '#{address}' is already registered as DB config service", status: 500
    end
  end

  def list
    managers = DbConfigService.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    if DbConfigService.where(address: address).blank?

      render inline: "Failure: There is no DB config service registered at '#{address}'", status: 500
    else

      DbConfigService.destroy_all(address: address)

      render inline: "Success: '#{address}' deregistered as DB config service"
    end
  end
end
