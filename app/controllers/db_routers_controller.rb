class DbRoutersController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbRouter.where(address: address).blank?
      manager = DbRouter.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as DbRouter"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as DbRouter"}, status: 500
    end
  end

  def list
    managers = DbRouter.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    DbRouter.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as DbRouter"}
  end

end
