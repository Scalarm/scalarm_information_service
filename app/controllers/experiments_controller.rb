class ExperimentsController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if ExperimentManager.where(address: address).blank?
      manager = ExperimentManager.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as Experiment Manager"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as Experiment Manager"}, status: 500
    end
  end

  def list
    managers = ExperimentManager.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    ExperimentManager.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as Experiment Manager"}
  end
end
