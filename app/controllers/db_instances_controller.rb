class DbConfigServicesController < AbstractServiceController
  def self.name
    'DbInstance'
  end

  def self.model_class
    DbInstance
  end
end
