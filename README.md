![Scalarm Logo](http://scalarm.com/images/scalarmNiebieskiemale.png)

[![Build Status](https://travis-ci.org/Scalarm/scalarm_information_service.svg?branch=master)](https://travis-ci.org/Scalarm/scalarm_information_service)

Scalarm Information Service
===========================

Information Service is a rails app, which implements the 'service locator' design
pattern for Scalarm. It is a central point which gathers information about other
Scalarm services: Experiment and Storage Manager.

This service is essential for Scalarm to work well.

To run the services you need to fulfill the following requirements:

Ruby version
------------

Currently we use and test Scalarm against MRI 2.1.2 but the Rubinius version of Ruby should be good as well.

```
$ curl -L https://get.rvm.io | bash
```

Agree on anything they ask :)

```
$ source $HOME/.rvm/scripts/rvm
$ rvm install 2.1.2
```

Also agree on anything. After the last command, rubinius version of ruby will be downloaded and installed from source.


System dependencies
-------------------

For SL 6.4 you need to add nginx repo and then install:

```
$ yum install git vim nginx wget man libxml2 sqlite sqlite-devel R curl sysstat
```

Some requirements will be installed by rvm also during ruby installation.

Any dependency required by native gems.

Installation
------------

You can download it directly from GitHub

```sh
git clone https://github.com/Scalarm/scalarm_information_service
```

After downloading the code you just need to install gem requirements:

```sh
cd scalarm_information_service
bundle install
```

if any dependency is missing you will be noticed :)

Configuration
-------------

As the Information Service exposes HTTPS interface via the Thin web server you need to provide SSL certificate and private.
There are two files with configuration: config/secrets.yml and config/thin.yml .
secrets.yml is a standard configuration file added in Rails 4 to have a single place for all secrets in an application. We used this approach in our Scalarm platform. An example of config/secrets.yml:

```sh
development:
  secret_key_base: 'd132fd22bc612e157d722e980c4b0525b938f225f9f7f66ea'
  service_login: scalarm
  service_password: scalarm
test:
  secret_key_base: 'd132fd22bc612e157d722e980c4b0525b938f225f9f7f66ea'
  service_login: scalarm
  service_password: scalarm
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  service_login: <%= ENV["INFORMATION_SERVICE_LOGIN"] %>
  service_password: <%= ENV["INFORMATION_SERVICE_PASSWORD"] %>
  service_crt: ./config/scalarm-cert.pem
  service_key: ./config/scalarm-cert-key.pem
```

The second configuration file config/thin.yml is related to the web server called
Thin which is used to serve Information Service by default.

An example of config/thin.yml:

```sh
pid: tmp/pids/thin.pid
log: log/thin.log
environment: production
port: 11300
tag: ScalarmInformationService
```

The web server uses SSL in production mode. Please generate OpenSSL key and certificate pair: ``scalarm-cert-key.pem`` and ``scalarm-cert.pem`` in order to launch thin server with HTTPS. You can follow this tutorial: http://www.akadia.com/services/ssh_test_certificate.html

To start/stop the service you can use the provided Rakefile:

```sh
export RAILS_ENV=production
rake service:start
rake service:stop
```

Before the first start of the service you will probably need to create database schemas.

```
RAILS_ENV=production rake db:migrate
```

License
----

MIT
