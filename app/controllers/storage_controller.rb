class StorageController < AbstractServiceController
  def self.name
    'Storage Manager'
  end

  def self.model_class
    StorageManager
  end
end
