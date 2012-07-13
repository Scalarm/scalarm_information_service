# ScalarmInformationService

Scalarm Information Service is a part of Scalarm - Massively Self-Scalable Platform for Data Farming .

More information at: www.scalarm.com (page under construction).

Scalarm Information Service is a central point which have essential information about a Scalarm platform installation.

Currently, it intends to provide access to packages with Scalarm components for scalarm_node_manager:
  - scalarm_experiment_manager
  - scalarm_storage_manager
  - scalarm_simulation_manager

You can provide the following configuration options in the <gem_path>/etc/config.yaml file:
  - port which will be used by built-in http server
  - managers_dir_path from which the above mentioned files will be served.

## Installation

Add this line to your application's Gemfile:

    gem 'scalarm_information_service'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scalarm_information_service

## Usage

Currently we only support simple usage where config file is at <gem_path>/etc/config.yaml
Since, we use daemons to run in background, there is a number of options possible, but the most common include:

$ scalarm_information_service (start|run|stop|help)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

Dariusz Król <dkrol@agh.edu.pl>
