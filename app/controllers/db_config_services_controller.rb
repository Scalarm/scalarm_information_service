class DbConfigServicesController < AbstractServiceController
  def self.name
    'DbConfigService'
  end

  def self.model_class
    DbConfigService
  end
end
