require "data_mapper"

class DbInstance
  include DataMapper::Resource

  property :uri,            String,   :key => true
  property :registered_at,  DateTime, :default => Time.now
end