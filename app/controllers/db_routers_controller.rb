class DbRoutersController < AbstractServiceController
  def self.name
    'DbRouter'
  end

  def self.model_class
    DbRouter
  end
end
