class DbInstancesController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbInstance.where(address: address).blank?
      manager = DbInstance.new(address: address)
      manager.save

      render inline: "Success: '#{address}' registered as DB instance"
    else

      render inline: "Failure: '#{address}' is already registered as DB instance", status: 500
    end
  end

  def list
    managers = DbInstance.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    if DbInstance.where(address: address).blank?

      render inline: "Failure: There is no DB instance registered at '#{address}'", status: 500
    else

      DbInstance.destroy_all(address: address)

      render inline: "Success: '#{address}' deregistered as DB instance"
    end
  end
end
