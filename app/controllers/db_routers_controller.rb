class DbRoutersController < AbstractServiceController
  def self.service_name
    'DbRouter'
  end

  def self.model_class
    DbRouter
  end
end
