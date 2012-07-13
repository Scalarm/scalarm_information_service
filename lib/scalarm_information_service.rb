require "scalarm_information_service/version"
require "sinatra"
require "yaml"

module Scalarm

  class ScalarmInformationService# < Sinatra::Base

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

    def server_port
      @config["port"].to_i
    end

  end

end

sis = Scalarm::ScalarmInformationService.new

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



