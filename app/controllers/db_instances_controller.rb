class DbInstancesController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbInstance.where(address: address).blank?
      manager = DbInstance.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as DbInstance"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as DbInstance"}, status: 500
    end
  end

  def list
    managers = DbInstance.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    DbInstance.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as DbInstance"}
  end
end
