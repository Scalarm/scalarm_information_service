# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'ci/reporter/rake/minitest'
require File.expand_path('../config/application', __FILE__)

ScalarmInformationService::Application.load_tasks

require 'yaml'

task :check_test_env do
  raise 'RAILS_ENV not set to test' unless Rails.env.test?
end

namespace :test do |ns|
  # add dependency to check_test_env for each test task
  ns.tasks.each do |t|
    task_name = t.to_s.match(/test:(.*)/)[1]
    task task_name.to_sym => [:check_test_env] unless task_name.blank?
  end
end

namespace :ci do
  task :all => ['ci:setup:minitest', 'test']
end

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
    command = 'thin stop -C config/thin.yml'
    
    puts command
    %x[#{command}]
  end

  desc 'Restart the service'
  task :restart => [:stop, :start] {}
  
end
