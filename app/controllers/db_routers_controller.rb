class DbRoutersController < ApplicationController
  before_filter :authenticate, :except => [:list]

  def register
    address = params[:address]

    if DbRouter.where(address: address).blank?
      manager = DbRouter.new(address: address)
      manager.save

      render inline: "Success: '#{address}' registered as DB router"
    else

      render inline: "Failure: '#{address}' is already registered as DB router", status: 500
    end
  end

  def list
    managers = DbRouter.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    if DbRouter.where(address: address).blank?

      render inline: "Failure: There is no DB router registered at '#{address}'", status: 500
    else

      DbRouter.destroy_all(address: address)

      render inline: "Success: '#{address}' deregistered as DB router"
    end
  end

end
