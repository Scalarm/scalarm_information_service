class StorageController < AbstractServiceController
  def self.service_name
    'Storage Manager'
  end

  def self.model_class
    StorageManager
  end
end
