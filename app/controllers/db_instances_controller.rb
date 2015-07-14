class DbInstancesController < AbstractServiceController
  def self.service_name
    'DbInstance'
  end

  def self.model_class
    DbInstance
  end
end
