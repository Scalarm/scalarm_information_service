class StorageController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if StorageManager.where(address: address).blank?
      manager = StorageManager.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as Storage Manager"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as Storage Manager"}, status: 500
    end
  end

  def list
    managers = StorageManager.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    StorageManager.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as Storage Manager"}
  end
end
