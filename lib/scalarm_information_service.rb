require "scalarm_information_service/version"
require "node_manager_guard"
require "sinatra"
require "yaml"
require 'data_mapper'

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

    def start_node_manager_guard
      NodeManagerGuard.new(@config["node_manager_guard_interval"]).start_guard
    end

  end

end

# data mapper initialization
DataMapper::Logger.new($stdout, :debug)
spec = Gem::Specification.find_by_name("scalarm_information_service")
db_file_path = File.join(spec.gem_dir, "db", "information_service.db")
DataMapper.setup(:default, "sqlite://#{db_file_path}")
require "model/node_manager"
DataMapper.finalize
DataMapper.auto_upgrade!

sis = Scalarm::ScalarmInformationService.new
sis.start_node_manager_guard

# sinatra web interface initialization
use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == sis.credentials
end

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



