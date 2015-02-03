# Methods to implement:
# - self.model_class -> return model class
# - self.name -> long name for response messages

class AbstractServiceController < ApplicationController
  before_filter :authenticate, :except => [:list]

  # def self.name
  #   raise 'Class method "name" not implemented!'
  # end
  #
  # def self.model_class
  #   raise 'Class method "model_class" not implemented!'
  # end

  def register
    address = params[:address]

    if self.class.model_class.where(address: address).blank?
      manager = self.class.model_class.new(address: address)
      manager.save

      render json: {status: 'ok', msg: "Success: '#{address}' has been registered as #{self.class.name}"}
    else
      render json: {status: 'error', msg: "Failure: '#{address}' is already registered as #{self.class.name}"}, status: 500
    end
  end

  def list
    managers = self.class.model_class.all.map(&:address)

    render json: managers
  end

  def deregister
    address = params[:address]

    self.model_class.destroy_all(address: address)

    render json: {status: 'ok', msg: "Success: '#{address}' has been deregistered as #{self.class.name}"}
  end
end
