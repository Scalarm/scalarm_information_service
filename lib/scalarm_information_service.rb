require 'sinatra'
require 'yaml'
require 'data_mapper'
require 'require_all'

require_rel 'model'
require 'node_manager_guard'
require_relative 'scalarm_information_service/version'

module Scalarm

  class ScalarmInformationService

    def initialize
      spec = Gem::Specification.find_by_name("scalarm_information_service")
      @config = YAML::load_file File.join(spec.gem_dir, "etc", "config.yaml")
    end

    def experiment_manager_file
      File.join(@config["managers_dir_path"], "scalarm_experiment_manager.zip")
    end

    def storage_manager_file
      File.join(@config["managers_dir_path"], "scalarm_storage_manager.zip")
    end

    def simulation_manager_file
      File.join(@config["managers_dir_path"], "scalarm_simulation_manager.zip")
    end
    
    def simulation_code_file
      File.join(@config["managers_dir_path"], "repository.tar.gz")
    end
    
    def simulation_scenarios_file
      File.join(@config["managers_dir_path"], "simulation_scenarios.zip")
    end

    def server_port
      @config["port"].to_i
    end

    def credentials
      [@config["login"], @config["password"]]
    end

    def db_file_path
      @config["service_db_path"]
    end

    def register_node_manager(manager_uri)
      NodeManager.create(:uri => manager_uri)
    end

    def node_managers
      NodeManager.all.map{|node_manager| "#{node_manager.uri}---#{node_manager.registered_at}"}.join("|||")
    end

    def register_db_instance(manager_uri)
      DbInstance.create(:uri => manager_uri)
    end

    def deregister_db_instance(manager_uri)
      db_instance = DbInstance.first(:uri => manager_uri)
      db_instance.destroy
    end

    def db_instances
      DbInstance.all.map{|instance| "#{instance.uri}---#{instance.registered_at}"}.join("|||")
    end

    def register_db_config_service(manager_uri)
      DbConfigService.create(:uri => manager_uri)
    end

    def deregister_db_config_service(manager_uri)
      db_config_service = DbConfigService.first(:uri => manager_uri)
      db_config_service.destroy
    end

    def db_config_services
      DbConfigService.all.map { |instance| "#{instance.uri}---#{instance.registered_at}" }.join("|||")
    end

    def register_log_bank(manager_uri)
      LogBank.create(:uri => manager_uri)
    end

    def deregister_log_bank(manager_uri)
      LogBank.find(:uri => manager_uri).each do |log_bank|
        log_bank.destroy
      end
    end

    def log_banks
      LogBank.all.map { |instance| "#{instance.uri}---#{instance.registered_at}" }.join('|||')
    end

    def start_node_manager_guard
      NodeManagerGuard.new(@config["node_manager_guard_interval"]).start_guard
    end

  end

end

# data mapper initialization
DataMapper::Logger.new($stdout, :debug)
spec = Gem::Specification.find_by_name('scalarm_information_service')
db_file_path = File.join(spec.gem_dir, 'db', 'information_service.db')
DataMapper.setup(:default, "sqlite://#{db_file_path}")

DataMapper.finalize
DataMapper.auto_upgrade!

sis = Scalarm::ScalarmInformationService.new
sis.start_node_manager_guard

# sinatra web interface initialization
use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  [username, password] == sis.credentials
end

require 'socket'
host = ''
# pinging google to get ip of our host
UDPSocket.open { |s| s.connect('64.233.187.99', 1); host = s.addr.last } if host.nil?

set :bind, host
set :port, sis.server_port
enable :run

get '/download_experiment_manager' do
  send_file sis.experiment_manager_file
end

get '/download_storage_manager' do
  send_file sis.storage_manager_file
end

get '/download_simulation_manager' do
  send_file sis.simulation_manager_file
end

get '/download_simulation_code' do
  send_file sis.simulation_code_file
end

get '/download_simulation_scenarios' do
  send_file sis.simulation_scenarios_file
end

# two param: :server and :port
# server - ip with '.' replaced with '_'
post '/register_node_manager' do
  sis.register_node_manager("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

get '/node_managers' do
  sis.node_managers
end

post '/register_db_instance' do
  sis.register_db_instance("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

post '/deregister_db_instance' do
  sis.deregister_db_instance("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

get '/db_instances' do
  sis.db_instances
end

post '/register_db_config_service' do
  sis.register_db_config_service("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

post '/deregister_db_config_service' do
  sis.deregister_db_config_service("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

get '/db_config_services' do
  sis.db_config_services
end

post '/register_log_bank' do
  sis.register_log_bank("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

post '/deregister_log_bank' do
  sis.deregister_log_bank("#{params[:server].gsub("_", ",")}:#{params[:port]}")
end

get '/log_banks' do
  sis.log_banks
end






