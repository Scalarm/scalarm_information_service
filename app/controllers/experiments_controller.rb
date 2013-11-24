class ExperimentsController < ApplicationController
  before_filter :authenticate, :except => [ :list ]

  def register
    address = params[:address]

    if ExperimentManager.where(address: address).blank?
      manager = ExperimentManager.new(address: address)
      manager.save

      render inline: "Success: '#{address}' registered as Experiment manager"
    else

      render inline: "Failure: '#{address}' is already registered as Experiment manager", status: 500
    end
  end

  def list
    managers = ExperimentManager.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    if ExperimentManager.where(address: address).blank?

      render inline: "Failure: There is no Experiment manager registered at '#{address}'", status: 500
    else

      ExperimentManager.destroy_all(address: address)

      render inline: "Success: '#{address}' deregistered as Experiment manager"
    end
  end
end
