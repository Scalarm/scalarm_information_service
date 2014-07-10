# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ScalarmInformationService::Application.load_tasks

require 'yaml'

namespace :service do
  desc 'Start the service'
  task :start => :environment do
    if Rails.application.secrets.service_key.nil?
      command = "thin start -d -C config/thin.yml"
    else
      command = "thin start -d --ssl --ssl-key-file #{Rails.application.secrets.service_key} --ssl-cert-file #{Rails.application.secrets.service_crt} -C config/thin.yml"
    end

    puts command
    %x[#{command}]
  end

  desc 'Stop the service'
  task :stop => :environment do
    %x[thin stop -C config/thin.yml]
  end

end
