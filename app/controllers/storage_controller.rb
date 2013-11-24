class StorageController < ApplicationController
  before_filter :authenticate, :except => [ :list ]

    def register
      address = params[:address]

      if StorageManager.where(address: address).blank?
        manager = StorageManager.new(address: address)
        manager.save

        render inline: "Success: '#{address}' registered as Storage manager"
      else

        render inline: "Failure: '#{address}' is already registered as Storage manager", status: 500
      end
    end

    def list
      managers = StorageManager.all.map(&:address)

      render json: managers
    end

    def deregister
      address = params[:address]

      if StorageManager.where(address: address).blank?

        render inline: "Failure: There is no Storage manager registered at '#{address}'", status: 500
      else

        StorageManager.destroy_all(address: address)

        render inline: "Success: '#{address}' deregistered as Storage manager"
      end
    end
end
