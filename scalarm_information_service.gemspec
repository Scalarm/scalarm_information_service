# -*- encoding: utf-8 -*-
require File.expand_path('../lib/scalarm_information_service/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Dariusz Król']
  gem.email         = %w(dkrol@agh.edu.pl)
  gem.description   = %q{Scalarm Information Service is a central point which have essential information about a Scalarm platform installation.}
  gem.summary       = %q{Scalarm Information Service}
  gem.homepage      = 'http://www.scalarm.com'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ['scalarm_information_service'] #gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'scalarm_information_service'
  gem.require_paths = %w(lib)
  gem.version       = ScalarmInformationService::VERSION

  gem.add_dependency('sinatra', '1.4.2')
  gem.add_dependency('daemons', '1.1.9')
  gem.add_dependency('data_mapper', '1.2.0')
  gem.add_dependency('dm-sqlite-adapter', '1.2.0')
  gem.add_dependency('require_all', '1.2.1')

  gem.license = 'MIT'
end
