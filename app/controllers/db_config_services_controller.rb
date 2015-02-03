class DbConfigServicesController < AbstractServiceController
  def self.service_name
    'DbConfigService'
  end

  def self.model_class
    DbConfigService
  end
end
